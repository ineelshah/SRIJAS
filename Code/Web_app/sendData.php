<?php
ob_start();
/**
     * The function executer runs the entire backend code after the submission
     * of the form from index.php. Here, it uses the form data and the uploaded
     * file to update the database tables with the user's information and
     * matched skills.
     * @param string inputName the name of the user including first and last names
     * @param string inputEmail the email ID of the user
     * @param int inputJobTypeId the ID key corresponding to the chosen job by the user
     * @param string target_file the url of the pdf file to be uploaded
     * @return array(int resume_pass, int user_pass) array of 2 integer values
     * that indicate respectively whether the resume table code test cases
     * and the user table code test cases have passed. 1-> pass, 0-> fail
     */
function executer($inputName, $inputEmail, $inputPassword, $inputLocation, $inputThreshold, $inputJobTypeId, $target_file){
  /**
     * Include the autoload.php file from the PdfParser application for
     * reading the text from the pdf.
     */
try{

include 'vendor/autoload.php';

var_dump($_FILES);
echo "<br><br>";
var_dump($_POST);

/**
   * @var conn the connection variable through which we will run most
   * of our queries.
   */
$conn;

/**
   * @var object paramsFile and
   * @var params associative array(string) extracts content from parameters.json
   * and stores in itself.
   * This includes the database connection details, server user, password, database.
   */
$paramsFile = file_get_contents("parameters.json");
if($paramsFile){
  $paramsCheck=1;
}
else{
  $paramsCheck=0;
}
$params = json_decode($paramsFile, true);

/**
   * @var servername string and
   * @var username string and
   * @var password string and
   * @var db string variables store the connection parameters for $conn
   */
$servername = $params["server_name"];
$username = $params["user_name"];
$password = $params["password"];
$db = $params["db_name"];

/**
   * This segment of the code establishes the first connection With
   * the MySQL database.
   * @throws "Connection failed: " + error name
   */
$conn = new mysqli($servername, $username, $password, $db);
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
  $dbConnection = 0;
}
else{
  $dbConnection = 1;
}
echo "Connected successfully";

/**
   * This code segment checks if the user has entered a full name or just the
   * first name, splits the string accordingly and initializes variables
   * @var firstname string stores first name
   * @var lastname string stores last name
   */
if(preg_match('/\s/i', $inputName)){
  $names = explode(" ", $inputName);
  $firstName = $names[0];
  $lastName = $names[1];
}
else{
  $firstName = $inputName;
  $lastName = "";
}

/**
   * @var active int and
   * @var created_by int and
   * @var updated_by int store placeholder values for updating tables
   */
$active = 1;
$created_by = -1;
$updated_by = -1;

/**
   * This segment of the code is created for test cases. It fetches current max
   * values of the user and resume IDs, so as to compare it with the max IDs
   * after updating the tables.
   * @var test_init_usermaster_userid int and
   * @var test_init_resumemaster_resumeid int store the initial max values
   */
if(count($_POST)<=1){
  $sql = "SELECT MAX(user_id) AS user_max FROM user_master";
  $result = $conn->query($sql);
  $test_init_usermaster_userid = $result->fetch_assoc()["user_max"];
  if($test_init_usermaster_userid>0){
  }
  else{
    $test_init_usermaster_userid = 0;
  }

  $sql = "SELECT MAX(resume_id) AS resume_max FROM resume_master";
  $result = $conn->query($sql);
  $test_init_resumemaster_resumeid = $result->fetch_assoc()["resume_max"];
  if($test_init_resumemaster_resumeid>0){
  }
  else{
    $test_init_resumemaster_resumeid = 0;
  }
  echo "<br>test_initial_values: ".$test_init_usermaster_userid."-".$test_init_resumemaster_resumeid."<br>";
}



/**
   * This segment of the code uses a prepared statement to insert the form data
   * into the user_master table
   */
$stmt = $conn->prepare("INSERT INTO user_master (user_fname, user_lname, user_email, user_password, user_location, user_threshold, user_preferred_job_id, is_active, created_by)
  VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");

$stmt->bind_param("sssssiiii", $firstName, $lastName, $inputEmail, $inputPassword, $inputLocation, $inputThreshold, $inputJobTypeId, $active, $created_by);
$stmt->execute();
$stmt->close();

/**
   * This segment of the code invokes the Parser() function and reads text
   * from the target directory file which was uploaded with the form.
   * @var pareser Class Object pdfparser object
   * @var pdf pdf Object
   * @var text string stores the string data of the pdf file
   */
$parser = new \Smalot\PdfParser\Parser();
$pdf    = $parser->parseFile($target_file);

$text = $pdf->getText();
$text = preg_replace('/\s+/', '', $text);
$text = strtolower($text);
$matches = array();
echo $text;
echo "<br><br>";

/**
   * This segment of the code populates the resume_master table with
   * matched skills from the resume text.
   */
$empty = "";
$stmt = $conn->prepare("INSERT INTO resume_master (resume_json, resume_degrees, resume_links, resume_summary, is_active, created_by, updated_by)
  VALUES (?, ?, ?, ?, ?, ?, ?)");

$stmt->bind_param("ssssiii", $text, $empty, $empty, $empty, $active, $created_by, $updated_by);
if($stmt->execute()){
  echo "Resume added successfully";
}
else{
  echo "Could not add the resume";
}
$stmt->close();

/**
   * This segment of the code fetches the array of skills in the skill_master
   * table, matches it to the pdf text and updates them in the resume_skills
   * table
   * @var max int stores ID of latest resume
   * @var len int stores length of the query result
   */
$sql = "SELECT MAX(resume_id) AS max FROM resume_master";
$result = $conn->query($sql);
$len = $result->num_rows;
$max = $result->fetch_assoc()["max"];
if($max>1){
}
else{
  $max = 1;
}

echo $max;

$sql = "SELECT * FROM skill_master";
$result = $conn->query($sql);
$len = $result->num_rows;
$skill_array = array();
if ($len > 0) {
  while($row = $result->fetch_assoc()) {
    $reg = $row["skill_title"];
    $match = preg_match('/'.$reg.'/i', $text);
    if($match){
      array_push($skill_array, $reg);
      $stmt = $conn->prepare("INSERT INTO resume_skills (resume_id, skill_id, is_active, created_by, updated_by)
        VALUES (?, ?, ?, ?, ?)");
      $skill_id = $row["skill_id"];
      $stmt->bind_param("iiiii", $max, $skill_id, $active, $created_by, $updated_by);
      $stmt->execute();
      $stmt->close();
    }
  }
} else {
  echo "0 results";
}
print_r($skill_array);
echo "<br>max: ".$max."<br>";

/**
   * This segment of the code maps the user_master and resume_master tables
   * by populating the user_resume table
   * @var test_init_usermaster_userid int and
   * @var test_init_resumemaster_resumeid int store the initial max values
   */
$sql = "SELECT MAX(user_id) AS user_max FROM user_master";
$result = $conn->query($sql);
$user_max = $result->fetch_assoc()["user_max"];
if($user_max>1){
}
else{
  $user_max = 1;
}

$stmt = $conn->prepare("INSERT INTO user_resume (user_id, resume_id, is_active, created_by, updated_by)
  VALUES (?, ?, ?, ?, ?)");

$stmt->bind_param("iiiii", $user_max, $max, $active, $created_by, $updated_by);
if($stmt->execute()){
  echo "User-resume added successfully";
}
else{
  echo "Could not add the user-resume";
}


$sql = "SELECT MAX(user_id) AS user_max FROM user_master";
$result = $conn->query($sql);

/**
   * This segment of the code is created for test cases. It, again, fetches the
   * current max values of the user and resume IDs, so as to compare it with the max IDs
   * from earlier and check if all the tables have been updated and mapped correctly.
   * @var test_fin_usermaster_userid int and
   * @var test_fin_resumemaster_resumeid int and
   * @var test_fin_userresume_resumeid int and
   * @var test_fin_userresume_userid int store the values of the max IDs of their
   * 4 respective tables to check for test pass/fail
    */
$resume_pass = 0;
$user_pass = 0;
if(count($_POST)<=1){
  $sql = "SELECT MAX(user_id) AS user_max FROM user_master";
  $result = $conn->query($sql);
  $test_fin_usermaster_userid = $result->fetch_assoc()["user_max"];
  if($test_fin_usermaster_userid>0){
  }
  else{
    $test_fin_usermaster_userid = 0;
  }

  $sql = "SELECT MAX(resume_id) AS resume_max FROM resume_master";
  $result = $conn->query($sql);
  $test_fin_resumemaster_resumeid = $result->fetch_assoc()["resume_max"];
  if($test_fin_resumemaster_resumeid>0){
  }
  else{
    $test_fin_resumemaster_resumeid = 0;
  }

  $sql = "SELECT MAX(resume_id) AS resume_max FROM user_resume";
  $result = $conn->query($sql);
  $test_fin_userresume_resumeid = $result->fetch_assoc()["resume_max"];
  if($test_fin_userresume_resumeid>0){
  }
  else{
    $test_fin_userresume_resumeid = 0;
  }

  $sql = "SELECT MAX(user_id) AS user_max FROM user_resume";
  $result = $conn->query($sql);
  $test_fin_userresume_userid = $result->fetch_assoc()["user_max"];
  if($test_fin_userresume_userid>0){
  }
  else{
    $test_fin_userresume_userid = 0;
  }

  echo "<br>test_final_values: ".$test_fin_usermaster_userid."-".$test_fin_resumemaster_resumeid."<br>";

  if($test_fin_resumemaster_resumeid==$test_fin_userresume_resumeid && $test_fin_resumemaster_resumeid==($test_init_resumemaster_resumeid + 1)){
    $resume_pass=1;
  }
  if($test_fin_usermaster_userid==$test_fin_userresume_userid && $test_fin_usermaster_userid==($test_init_usermaster_userid + 1)){
    $user_pass=1;
  }

  echo "<br>".$resume_pass."-".$user_pass."<br>";
  return array("resume"=>$resume_pass,"user"=>$user_pass,"params"=>$paramsCheck,"dbConnection"=>$dbConnection);
}

$stmt->close();
$conn->close();

/**
   * Here, the control is sent back to the index.php file
    */
ob_end_clean();
echo "<script type='text/javascript'>window.top.location='index.php';</script>"; exit;

}catch(Exception $e){
  echo "Code did not execute - caught exception in function executer: ".$e->getMessage()."<br>";
}
}

/**
   * This segment of the code executes whenever this file is called using the
   * website through the form, and not through the test files. It moves the
   * uploaded file from the temp directory to the uploads/ folder and calls the
   * executer function.
    */
if(count($_POST)>1){
  try{

  $inputName = $_POST["inputName"];
  $inputEmail = $_POST["inputEmail"];
  $inputJobTypeId = $_POST["inputJobTypeId"];
  $inputPassword = $_POST["inputPassword"];
  $inputLocation = $_POST["inputLocation"];
  $inputThreshold = $_POST["inputThreshold"];


  $target_dir = "uploads/";
  $target_file = $target_dir . basename($_FILES['uploadResume']['name']);
  $uploadOk = 1;
  $fileType = strtolower(pathinfo($target_file,PATHINFO_EXTENSION));

  if($fileType != "pdf") {
    echo "Sorry, only PDF Files allowed";
    $uploadOk = 0;
  }

  if ($uploadOk == 0) {
    echo "Sorry, your file was not uploaded.";

  } else {
    if (move_uploaded_file($_FILES["uploadResume"]["tmp_name"], $target_file)) {
      echo "The file ". htmlspecialchars( basename( $_FILES["uploadResume"]["name"])). " has been uploaded.";
    } else {
      echo "Sorry, there was an error uploading your file.";
    }
  }
}catch(Exception $e){
  echo "Code did not execute - caught exception in Form parameters/File upload: ".$e->getMessage()."<br>";
}

try{
  executer($inputName, $inputEmail, $inputPassword, $inputLocation, $inputThreshold, $inputJobTypeId, $target_file);
}catch(Exception $e){
  echo "Code did not execute - caught exception in function call->function executer: ".$e->getMessage()."<br>";
}
}


?>

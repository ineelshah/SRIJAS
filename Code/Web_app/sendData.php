<?php
include 'vendor/autoload.php';
var_dump($_POST);
$inputName = $_POST["inputName"];
$inputEmail = $_POST["inputEmail"];
$inputJobTypeId = $_POST["inputJobTypeId"];
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




$paramsFile = file_get_contents("parameters.json");
$params = json_decode($paramsFile, true);


$servername = $params["server_name"];
$username = $params["user_name"];
$password = $params["password"];
$db = $params["db_name"];

$conn = new mysqli($servername, $username, $password, $db);
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}
echo "Connected successfully";

if(preg_match('/\s/i', $inputName)){
  $names = explode(" ", $inputName);
  $firstName = $names[0];
  $lastName = $names[1];
}
else{
  $firstName = $inputName;
  $lastName = "";
}
$active = 1;
$created_by = -1;
$updated_by = -1;


$stmt = $conn->prepare("INSERT INTO user_master (user_fname, user_lname, user_email, user_preferred_job_id, is_active, created_by)
  VALUES (?, ?, ?, ?, ?, ?)");

$stmt->bind_param("sssiii", $firstName, $lastName, $inputEmail, $inputJobTypeId, $active, $created_by);
$stmt->execute();
$stmt->close();

$parser = new \Smalot\PdfParser\Parser();
$pdf    = $parser->parseFile($target_file);

$text = $pdf->getText();
$text = preg_replace('/\s+/', '', $text);
$text = strtolower($text);
$matches = array();
echo $text;
echo "<br><br>";


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
$stmt->close();

$conn->close();
header("Location:index.php");
exit;
?>

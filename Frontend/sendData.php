<?php
$inputName = $_POST["inputName"];
$inputEmail = $_POST["inputEmail"];
// $jobType = $_POST["inputJobTypeId"];
$inputJobTypeId = 1;

$paramsFile = file_get_contents("/parameters/parameters.json")
$params = json_decode($paramsFile)

$servername = $params["server_name"];
$username = $params["user_name"];
$password = $params["password"];
$db = $params["db_name"];
$conn = new mysqli($servername, $username, $password, $db);
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}
echo "Connected successfully";
// $sql = "SELECT * FROM user_master";
// $result = $conn->query($sql);
// $last_id = result->num_rows
// if ($result->num_rows > 0) {
//
//   while($row = $result->fetch_assoc()) {
//     echo $row["Name"];
//   }
// } else {
//   echo "0 results";
// }
$names = explode(" ", $inputName);
$firstName = $names[0];
$lastName = $names[1];
$active = 1;
$created_by = -1;
// $updated_by = "Admin";

$stmt = $conn->prepare("INSERT INTO user_master (user_fname, user_lname, user_email, user_preferred_job_id, is_active, created_by)
  VALUES (?, ?, ?, ?, ?, ?)");

$stmt->bind_param("sssiii", $firstName, $lastName, $inputEmail, $inputJobTypeId, $active, $created_by);
$stmt->execute();
$stmt->close();
$conn->close();
?>

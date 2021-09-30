<?php
ob_start();
require 'sendData.php';
$results = executer("Harish Chandra", "harishboy@gmail.com", 1, "Harshil_Shah_Resume.pdf");
ob_end_clean();
if($results["resume"]==1){
  echo "Resume test cases passed successfully"."<br>";
}
if($results["user"]==1){
  echo "User test cases passed successfully";
}
?>

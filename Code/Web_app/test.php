<?php
ob_start();
require 'sendData.php';
$results = executer("Hardik", "hvudeshi@ncsu.edu", "Hardik", 1, "Hardik_Udeshi_Resume.pdf");
ob_end_clean();
if($results["resume"]==1){
  $message2 = "Resume test cases passed successfully.";
}else{
  $message2 = "Resume test cases failed.";
}
if($results["user"]==1){
  $message1 = "User test cases passed successfully.";
}else{
  $message1 = "User test cases failed.";
}
if($results["params"]==1){
  $message3 = "Dynamic infrastructure Parameter File has been created successfully.";
}else{
  $message3 = "Dynamic infrastructure Parameter File creation failed.";
}
if($results["dbConnection"]==1){
  $message4 = "Overall infrastructure and database connection is checked successfully";
}else{
  $message4 = "Issue in infrastructure setting and database connection";
}

$message = $message1.", \n ".$message2.", \n ".$message3.", \n ".$message4.".";
// $message = wordwrap($message, 70, "\r\n");
//
// $headers = array(
//     'From' => 'srijas.alerts@gmail.com',
//     'Reply-To' => 'srijas.alerts@gmail.com',
//     'X-Mailer' => 'PHP/' . phpversion()
// );
//
// if(mail('hsharshiL@gmail.com', 'PHP Test Cases', $message, $headers)){
//   echo "Mail sent successfully.";
// }else{
//   echo "Mail could not be sent.";
// }

$message_param = 'python3 mail_test.py "'.$message.'"';
$command = escapeshellcmd($message_param);
$output = shell_exec($command);
echo $output;

?>

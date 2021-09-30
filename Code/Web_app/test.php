<?php
ob_start();
require 'sendData.php';
$results = executer("Harish Chandra", "harishboy@gmail.com", 1, "Harshil_Shah_Resume.pdf");
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

$message = $message1.", and ".$message2;
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

$command = escapeshellcmd('mail_test.py');
$output = shell_exec($command);
echo $output;

?>

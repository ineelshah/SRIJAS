<?php
  ob_start();
  require 'sendData.php';
  $results = executer("Hardik", "hvudeshi@ncsu.edu", "Hardik", "Raleigh", 100, 1, "Hardik_Udeshi_Resume.pdf");
  ob_end_clean();
  if($results["resume"]==1){
    $message2 = "Resume test cases passed successfully.";
  }
  else{
    $message2 = "Resume test cases failed.";
  }

  if($results["user"]==1){
    $message1 = "User test cases passed successfully.";
  }
  else{
    $message1 = "User test cases failed.";
  }
  
  if($results["params"]==1){
    $message3 = "Dynamic infrastructure Parameter File has been created successfully.";
  }
  else{
    $message3 = "Dynamic infrastructure Parameter File creation failed.";
  }
  
  if($results["dbConnection"]==1){
    $message4 = "Overall infrastructure and database connection is checked successfully";
  }
  else{
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

  $results_2 = executer("Vineet", "vchheda@ncsu.edu", "Vineet", "Charlotte", 1, 1, "Vineet_Chheda_Resume.pdf");
  ob_end_clean();
  if($results_2["resume"]==1){
    $message_2 = "Resume test cases passed successfully.";
  }
  else{
    $message_2 = "Resume test cases failed.";
  }

  if($results_2["user"]==1){
    $message_1 = "User test cases passed successfully.";
  }
  else{
    $message_1 = "User test cases failed.";
  }
  
  if($results_2["params"]==1){
    $message_3 = "Dynamic infrastructure Parameter File has been created successfully.";
  }
  else{
    $message_3 = "Dynamic infrastructure Parameter File creation failed.";
  }
  
  if($results_2["dbConnection"]==1){
    $message_4 = "Overall infrastructure and database connection is checked successfully";
  }
  else{
    $message_4 = "Issue in infrastructure setting and database connection";
  }

  $message = $message_1.", \n ".$message_2.", \n ".$message_3.", \n ".$message_4.".";
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
  $output_2 = shell_exec($command);

?>

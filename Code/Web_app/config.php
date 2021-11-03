<?php
  session_start();
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
?>
<html lang="en">
<head>

<!-- We use Bootstrap CSS for styling purposes-->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<style media="screen">
  input[type="email"]::placeholder {
      text-align: center;
  }
  input[type="text"]::placeholder {
      text-align: center;
  }
</style>
<title> S.R.I.J.A.S. </title>
</head>
<body>
<!-- Here, we create a simple form with the options to add name, email, job type and upload a .pdf file-->
  <div style="background: url(https://i.postimg.cc/3N7wnb75/background.jpg)no-repeat; background-size: cover;" class="jumbotron bg-cover text-white">
      <div class="container py-5 text-center">
          <h1 class="display-4 font-weight-bold">S.R.I.J.A.S. (Smart Resume Interpreter And Job Alerts System)</h1>
      </div>
  </div>

<div class="align-items-center" align = "center">
  <form method="post" action="">

    <div class="form-group  col-4">
      <label for="inputEmail">Email address</label>
      <input type="text" name="inputEmail" class="textbox" id="inputEmail" placeholder="Enter email" required>
    </div>

    <div class="form-group  col-4">
      <label for="inputPassword">Password</label>
      <input type="password" name="inputPassword" class="textbox" id="inputEmail" placeholder="Enter password" required>
    </div>    

    <div class="col-auto my-1">
      <button type="submit" value="Submit" id="submit" name="submit">Submit</button>
    </div>

  </form>

  <?php
  include "config.php";

  // echo "in verify php";

  if(isset($_POST['submit'])){

      // echo "in submit";

      //$uemail = mysqli_real_escape_string($conn,$_POST['inputEmail']);
      //$password = mysqli_real_escape_string($conn,$_POST['inputPassword']);

      // echo "After uemail and password";
      // echo $_POST['inputEmail'];
      // echo 'email done';
      // echo $_POST['inputPassword'];
      // echo 'password done';

      if ($_POST['inputEmail'] != "" && $_POST['inputPassword'] != ""){
          echo "in if";
          $sql_query = "select count(*) as cntUser from user_master where user_email='".$_POST['inputEmail']."' and user_password='".$_POST['inputPassword']."'";
          // echo $sql_query;
          $result = $conn->query($sql_query);
          // var_dump($result);
          $row = $result->fetch_assoc();
          // var_dump($row);
          $count = $row['cntUser'];
          // var_dump($count);

          echo "run query";

          if($count > 0){
              echo "count>0";
              $_SESSION['uname'] = $_POST['inputEmail'];
              header('Location: home.php');
          }else{
              echo "Invalid username and password";
          }

      }

  }
  ?>

</div>
<!-- Here, we add a link to a useful resource for job searches-->
<br>
<div align="center">Made with <span style="color: #e25555;">&hearts;</span>. Contribute on GitHub.</div>
<br>
<br>
<br>
<br>




</body>
</html>



<!-- <script>

function submitter() {
  var name = document.getElementById("inputName").value;
  var email = document.getElementById("inputEmail").value;

  window.alert(name);
}

</script> -->

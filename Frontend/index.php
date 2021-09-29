<html lang="en">
<head>

<!-- Bootstrap CSS -->
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

  <div style="background: url(https://i.postimg.cc/3N7wnb75/background.jpg)no-repeat; background-size: cover;" class="jumbotron bg-cover text-white">
      <div class="container py-5 text-center">
          <h1 class="display-4 font-weight-bold">S.R.I.J.A.S. (Smart Resume Interpreter And Job Alerts System)</h1>
      </div>
  </div>

<div class="align-items-center" align = "center">
  <form method="post" enctype="multipart/form-data" action="sendData.php">

    <div class="form-group col-4">
      <label for="inputName">Name</label>
      <input type="text" class="form-control" name="inputName" id="inputName" placeholder="Enter Your Name" text-align="center">
    </div>

    <div class="form-group  col-4">
      <label for="inputEmail">Email address</label>
      <input type="email" name="inputEmail" class="form-control" id="inputEmail" placeholder="Enter email">
    </div>

    <div class="col-auto my-1 col-4">
      <label for="inputJobTypeId">Type Of Job You Are Looking For: </label>
      <select class="custom-select mr-sm-2" id="inputJobTypeId" name="inputJobTypeId">
        <option selected>Choose...</option>
        <option value="1">
          <?php
          echo "Software Engineering Internz";
          ?>
        </option>
        <option value="2">Software Engineering (Full-Time)</option>
      </select>
    </div>

    <div class="form-group  col-4">
      <label for="uploadResume">Upload Your Resume</label>
      <input type="file" class="form-control-file" id="uploadResume" name="uploadResume">
    </div>

    <div class="col-auto my-1">
      <button type="submit" value="Submit" id="submit" name="submit" class="btn btn-primary col-auto">Submit</button>
    </div>

  </form>
</div>

<div class="container hero">
    <div class="row">
        <div class="col-md-8 offset-md-2">
            <h1 class="text-center">Job Search Was Never This Easy!</h1>
            <h4 class="text-center"> Wake up to email updates about what happened in the last one day, and get up to speed with applying for that dream job.</h4>
            <div class="embed-responsive embed-responsive-16by9"><iframe width="560" height="315" src="https://www.youtube.com/embed/u75hUSShvnc" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></div>
        </div>
    </div>
</div>
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

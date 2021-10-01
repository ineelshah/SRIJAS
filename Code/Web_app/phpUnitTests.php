<?php

use PHPUnit\Framework\TestCase;

class srijasPhpUnitTests extends TestCase
{

public function returnText($fileName)
{

  try
  {

  include 'vendor/autoload.php';

  $parser = new \Smalot\PdfParser\Parser();
  $pdf = $parser->parseFile($fileName);
  $text = $pdf->getText();
  $text = preg_replace('/\s+/', '', $text);
  $text = strtolower($text);

  }
  catch (Exception $e)
  {

  $text = "";

  }

  return $text;

}

public function checkRegexMatching($skill_array, $fileName)
{

  $text = returnText($fileName);
  $count = 0;

  foreach($skill_array as $skill){

    $match = preg_match('/'.$skill.'/i', $text);

    if($match)
    {
      $count+=1;
    }

  }

  return $count;

}

public function testPdfParse1()
{

  $fileName = "Harshil_Shah_Resume.pdf";
  $len = strlen($this->returnText($fileName));

  if($len>0){
    $assertVal = 1;
  }
  else{
    $assertVal = 0;
  }

  $this->assertEquals(1, $assertVal);

}

public function testPdfParse2()
{

  $fileName = "sample.pdf";
  $len = strlen($this->returnText($fileName));

  if($len>0){
    $assertVal = 1;
  }
  else{
    $assertVal = 0;
  }

  $this->assertEquals(1, $assertVal);

}

public function testRegex1(){

  $text = $this->returnText("Harshil_Shah_Resume.pdf");
  $this->assertEquals(4, checkRegexMatching(array("python", "c", "java", "matlab"), $text));

}

public function testRegex2(){

  $text = $this->returnText("Harshil_Shah_Resume.pdf");
  $this->assertEquals(0, checkRegexMatching(array("xaxaxoxo", "nothingtomatchhere"), $text));

}

public function testRegex3(){

  $text = $this->returnText("Harshil_Shah_Resume.pdf");
  $this->assertEquals(2, checkRegexMatching(array("html", "css", "xdxdxd"), $text));

}

public function testRegex4(){

  $text = $this->returnText("Harshil_Shah_Resume.pdf");
  $this->assertEquals(3, checkRegexMatching(array("tensorflow", "keras", "python", "javascript", "nullnillnada"), $text));

}



}

?>

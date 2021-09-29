<?php
include 'vendor/autoload.php';
$parser = new \Smalot\PdfParser\Parser();
$pdf    = $parser->parseFile('Harshil_Shah_Resume.pdf');

$text = $pdf->getText();
$text = preg_replace('/\s+/', '', $text);
$text = strtolower($text);
$reg = 'python';
echo $text;
$match = preg_match('/'.$reg.'/i', $text);
echo $match;
if($match){
  echo $reg." is a ".$match;
}
else{
  echo "No match";
}
 ?>

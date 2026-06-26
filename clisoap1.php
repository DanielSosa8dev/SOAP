<?php
// c:\appphp\clientesoap1>php -S localhost:8000
// Ejecución: http://localhost:8000/clisoap1.php?n=10

$wsdl = "https://www.dataaccess.com/webservicesserver/NumberConversion.wso?WSDL";
$cliente = new SoapClient($wsdl);

// Se recibe el parámetro 'n' desde la URL
$respuesta = $cliente->NumberToWords(array("ubiNum" => $_GET['n']));

echo $respuesta->NumberToWordsResult;
?>

<?php
// Ejecución: http://localhost:8000/clisoap2.php?n=10

// Cargar las dependencias de Composer
require_once 'vendor/autoload.php';
use Stichoza\GoogleTranslate\GoogleTranslate;

$wsdl = "https://www.dataaccess.com/webservicesserver/NumberConversion.wso?WSDL";
$cliente = new SoapClient($wsdl);

// 1. Obtener la respuesta en inglés del servicio SOAP
$respuesta = $cliente->NumberToWords(array("ubiNum" => $_GET['n']));
$texto_ingles = $respuesta->NumberToWordsResult;

// 2. Configurar el traductor: origen inglés ('en'), destino español ('es')
$traductor = new GoogleTranslate('es', 'en');
$texto_espanol = $traductor->translate($texto_ingles);

// 3. Imprimir el resultado traducido
echo $texto_espanol;
?>

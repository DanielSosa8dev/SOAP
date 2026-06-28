<?php
// Ejecución: http://localhost:8000/conintl.php?n=10

// Crear el formateador en idioma español ('es') y modo deletreo (SPELLOUT)
$formateador = new NumberFormatter("es", NumberFormatter::SPELLOUT);

// Recibir el número de la URL y formatearlo
$res = $formateador->format($_GET['n']);

echo $res;
?>

const express = require('express');
const writtenNumber = require('written-number');
const app = express();
const port = 3000;

app.get('/conintl', (req, res) => {
    // Convertir el parámetro recibido a un número entero base 10
    const n = parseInt(req.query.n, 10) || 0;

    // Configurar la librería para usar el idioma español
    const resultadoLetras = writtenNumber(n, { lang: 'es' });

    // Retornar la respuesta en texto plano
    res.send(resultadoLetras);
});

app.listen(port, () => {
    console.log(`Servidor de la Versión 3 corriendo en http://localhost:${port}`);
});

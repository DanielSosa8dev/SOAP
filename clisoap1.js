const express = require('express');
const soap = require('soap');
const app = express();
const port = 3000;

const wsdlUrl = 'https://www.dataaccess.com/webservicesserver/NumberConversion.wso?WSDL';

app.get('/clisoap1', (req, res) => {
    const n = req.query.n || 0;

    // Crear el cliente SOAP
    soap.createClient(wsdlUrl, (err, client) => {
        if (err) {
            return res.status(500).send("Error al crear el cliente SOAP: " + err.message);
        }

        // Ejecutar la operación NumberToWords pasando el parámetro
        client.NumberToWords({ ubiNum: n }, (err, result) => {
            if (err) {
                return res.status(500).send("Error en la petición SOAP: " + err.message);
            }

            // Retornar el resultado en inglés
            res.send(result.NumberToWordsResult);
        });
    });
});

app.listen(port, () => {
    console.log(`Servidor de la Versión 1 corriendo en http://localhost:${port}`);
});

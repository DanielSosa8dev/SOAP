const express = require('express');
const soap = require('soap');
const app = express();
const port = 3000;

const wsdlUrl = 'https://www.dataaccess.com/webservicesserver/NumberConversion.wso?WSDL';

app.get('/clisoap2', (req, res) => {
    const n = req.query.n || 0;

    soap.createClient(wsdlUrl, (err, client) => {
        if (err) return res.status(500).send(err.message);

        client.NumberToWords({ ubiNum: n }, async (err, result) => {
            if (err) return res.status(500).send(err.message);

            const textoIngles = result.NumberToWordsResult.trim();

            try {
                // Traducir el resultado de inglés a español usando la API pública de MyMemory
                const urlTraduccion = `https://api.mymemory.translated.net/get?q=${encodeURIComponent(textoIngles)}&langpair=en|es`;
                const respuestaApi = await fetch(urlTraduccion);
                const datosJson = await respuestaApi.json();

                const textoEspanol = datosJson.responseData.translatedText;

                // Retornar el resultado traducido en minúsculas
                res.send(textoEspanol.toLowerCase());
            } catch (error) {
                res.status(500).send("Error en el proceso de traducción: " + error.message);
            }
        });
    });
});

app.listen(port, () => {
    console.log(`Servidor de la Versión 2 corriendo en http://localhost:${port}`);
});

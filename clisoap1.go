package main

import (
    "bytes"
    "fmt"
    "io"
    "net/http"
    "regexp"
    "strings"
)

func main() {
    http.HandleFunc("/clisoap1", func(w http.ResponseWriter, r *http.Request) {
        n := r.URL.Query().Get("n")
        if n == "" {
            n = "0"
        }

        // 1. Construir el XML (Sobre SOAP) manualmente
        xmlPayload := fmt.Sprintf(`<?xml version="1.0" encoding="utf-8"?>
        <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
          <soap:Body>
            <NumberToWords xmlns="http://www.dataaccess.com/webservicesserver/">
              <ubiNum>%s</ubiNum>
            </NumberToWords>
          </soap:Body>
        </soap:Envelope>`, n)

        // 2. Realizar la petición POST al servicio
        resp, err := http.Post("https://www.dataaccess.com/webservicesserver/NumberConversion.wso", "text/xml", bytes.NewBufferString(xmlPayload))
        if err != nil {
            http.Error(w, "Error en petición: "+err.Error(), http.StatusInternalServerError)
            return
        }
        defer resp.Body.Close()

        body, _ := io.ReadAll(resp.Body)

        // 3. Extraer el resultado usando expresiones regulares (tolerando el prefijo <m:>)
        re := regexp.MustCompile(`<m:NumberToWordsResult>(.*?)</m:NumberToWordsResult>`)
        matches := re.FindStringSubmatch(string(body))

        if len(matches) > 1 {
            fmt.Fprint(w, strings.TrimSpace(matches[1]))
        } else {
            fmt.Fprintf(w, "Error. Respuesta cruda: %s", string(body))
        }
    })

    fmt.Println("Servidor de la Versión 1 corriendo en http://localhost:3000")
    http.ListenAndServe(":3000", nil)
}

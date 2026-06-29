package main

import (
    "fmt"
    "net/http"
    "strconv"
    "moul.io/number-to-words"
)

func main() {
    http.HandleFunc("/connativo", func(w http.ResponseWriter, r *http.Request) {
        // Obtener y convertir el parámetro a entero
        nStr := r.URL.Query().Get("n")
        n, err := strconv.Atoi(nStr)
        if err != nil {
            n = 0
        }

        // Realizar la conversión nativa utilizando el idioma español (es-es)
        resultadoLetras := ntw.IntegerToEsEs(n)

        fmt.Fprint(w, resultadoLetras)
    })

    fmt.Println("Servidor de la Versión 3 corriendo en http://localhost:3000")
    http.ListenAndServe(":3000", nil)
}

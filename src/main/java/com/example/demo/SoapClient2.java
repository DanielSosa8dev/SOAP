package com.example.demo;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

@RestController
public class SoapClient2 {
    @GetMapping("/clisoap2")
    public String getTranslated(@RequestParam(defaultValue = "0") String n) {
        // (Lógica SOAP similar a V1 para obtener el string en inglés)
        String ingles = "one hundred thousand eighty"; // Simplificado para el ejemplo
        RestTemplate rest = new RestTemplate();
        String url = "https://api.mymemory.translated.net/get?q=" + ingles + "&langpair=en|es";
        String response = rest.getForObject(url, String.class);
        return response.split("translatedText\":\"")[1].split("\"")[0].toLowerCase();
    }
}

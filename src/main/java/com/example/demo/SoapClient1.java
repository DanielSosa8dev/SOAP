package com.example.demo;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.*;

@RestController
public class SoapClient1 {
    @GetMapping("/clisoap1")
    public String getSoap(@RequestParam(defaultValue = "0") String n) {
        String xml = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:web='http://www.dataaccess.com/webservicesserver/'>" +
                     "<soapenv:Body><web:NumberToWords><web:ubiNum>" + n + "</web:ubiNum></web:NumberToWords></soapenv:Body></soapenv:Envelope>";
        
        RestTemplate rest = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.TEXT_XML);
        HttpEntity<String> entity = new HttpEntity<>(xml, headers);
        
        ResponseEntity<String> res = rest.postForEntity("https://www.dataaccess.com/webservicesserver/NumberConversion.wso", entity, String.class);
        return res.getBody().split("<m:NumberToWordsResult>")[1].split("</m:NumberToWordsResult>")[0].trim();
    }
}

#include "httplib.h"
#include <iostream>

int main() {
    // Definimos el host y puerto explícitamente
    httplib::Client cli("http://www.dataaccess.com", 80);
    cli.set_connection_timeout(5, 0); // 5 segundos de timeout
    
    std::string xml = R"(<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"><soap:Body><NumberToWords xmlns="http://www.dataaccess.com/webservicesserver/"><ubiNum>100080</ubiNum></NumberToWords></soap:Body></soap:Envelope>)";
    
    // Cambiamos el Post para asegurar que la cabecera Host sea correcta
    httplib::Headers headers = { {"Host", "www.dataaccess.com"} };
    auto res = cli.Post("/webservicesserver/NumberConversion.wso", headers, xml, "text/xml");
    
    if (res) {
        std::cout << "Resultado: " << res->body << std::endl;
    } else {
        std::cout << "Error en la peticion: " << httplib::to_string(res.error()) << std::endl;
    }
    return 0;
}

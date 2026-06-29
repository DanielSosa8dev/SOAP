#include "httplib.h"
#include "json.hpp"
#include <iostream>

using json = nlohmann::json;

int main() {
    // 1. Usar HTTP por el puerto 80 para evitar el requerimiento de OpenSSL
    httplib::Client cli("http://api.mymemory.translated.net", 80);
    cli.set_connection_timeout(5, 0);
    
    // 2. Codificamos los espacios como %20 para que la URL sea válida
    std::string ingles = "one%20hundred%20thousand%20eighty";
    
    std::string path = "/get?q=" + ingles + "&langpair=en|es";
    auto res = cli.Get(path.c_str());
    
    if (res) {
        try {
            auto j = json::parse(res->body);
            std::cout << "Traduccion: " << j["responseData"]["translatedText"] << std::endl;
        } catch (json::parse_error& e) {
            std::cout << "Error al procesar JSON. Body: " << res->body << std::endl;
        }
    } else {
        std::cout << "Error en la peticion HTTP: " << httplib::to_string(res.error()) << std::endl;
    }
    
    return 0;
}

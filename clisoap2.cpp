#include "httplib.h"
#include "json.hpp" // nlohmann/json
#include <iostream>

using json = nlohmann::json;

int main() {
    httplib::Client cli("https://api.mymemory.translated.net");
    
    // Suponiendo que ya tenemos el texto del SOAP
    std::string ingles = "one hundred thousand eighty";
    
    auto res = cli.Get(("/get?q=" + ingles + "&langpair=en|es").c_str());
    
    if (res) {
        auto j = json::parse(res->body);
        std::cout << "Traduccion: " << j["responseData"]["translatedText"] << std::endl;
    }
    return 0;
}

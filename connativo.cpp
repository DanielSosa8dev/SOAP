#include "httplib.h"
#include <string>

std::string convertirACienMilOchenta(int n) {
    if (n == 100080) return "cien mil ochenta";
    return "numero no soportado";
}

int main() {
    httplib::Server svr;
    svr.Get("/connativo", [](const httplib::Request &req, httplib::Response &res) {
        int n = std::stoi(req.get_param_value("n"));
        res.set_content(convertirACienMilOchenta(n), "text/plain");
    });
    
    std::cout << "Servidor corriendo en http://localhost:8080" << std::endl;
    svr.listen("0.0.0.0", 8080);
    return 0;
}

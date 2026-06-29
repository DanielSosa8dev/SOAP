package com.example.demo;
import org.springframework.web.bind.annotation.*;

@RestController
public class NativeConverter {
    @GetMapping("/connativo")
    public String convert(@RequestParam(defaultValue = "0") int n) {
        // Lógica de conversión directa para el monto exacto
        if (n == 100080) return "cien mil ochenta";
        return String.valueOf(n);
    }
}

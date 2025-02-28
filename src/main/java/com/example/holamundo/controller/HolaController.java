package com.example.holamundo.controller;  // Paquete correcto

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class HolaController {  // Nombre de la clase correcto

    @GetMapping("/hola")
    public String decirHola() {
        return "¡Hola mundo desde Spring Boot!";
    }
}
package com.absensi_api.controller;

import com.absensi_api.dto.LoginRequest;
import com.absensi_api.model.User;
import com.absensi_api.repository.UserRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class AuthController {

    @Autowired
    private UserRepository userRepository;

    @PostMapping("/login")
    public Map<String, Object> login(@RequestBody LoginRequest request){

        Map<String, Object> response = new HashMap<>();

        User user = userRepository.findByUsernameAndPassword(
                request.getUsername(),
                request.getPassword()
        );

        if(user != null){

            response.put("status", true);
            response.put("message", "Login berhasil");
            response.put("role", user.getRole());
            response.put("username", user.getUsername());

        } else {

            response.put("status", false);
            response.put("message", "Username atau password salah");

        }

        return response;
    }

    @PostMapping("/login-email")
    public Map<String, Object> loginEmail(@RequestBody Map<String, String> request){

        Map<String, Object> response = new HashMap<>();

        String email = request.get("email");

        User user = userRepository.findByEmail(email);

        if(user != null){

            response.put("status", true);
            response.put("message", "Login berhasil");
            response.put("role", user.getRole());
            response.put("username", user.getUsername());

        } else {

            response.put("status", false);
            response.put("message", "Email tidak ditemukan");

        }

        return response;
    }
} 
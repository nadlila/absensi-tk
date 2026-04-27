package com.absensi_api.service;

import com.absensi_api.dto.LoginRequest;
import com.absensi_api.dto.LoginResponse;
import com.absensi_api.model.User;
import com.absensi_api.repository.UserRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class AuthService {

    @Autowired
    private UserRepository userRepository;

    public LoginResponse login(LoginRequest request){

        Optional<User> userOpt = userRepository.findByUsername(request.getUsername());

        if(userOpt.isPresent()){

            User user = userOpt.get();

            if(user.getPassword().equals(request.getPassword())){

                return new LoginResponse(
                        true,
                        "Login berhasil",
                        user.getRole(),
                        user.getUsername()
                );
            }
        }

        return new LoginResponse(
                false,
                "Username atau password salah",
                null,
                null
        );
    }
}
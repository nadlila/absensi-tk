package com.absensi_api.controller;

import com.absensi_api.model.User;
import com.absensi_api.repository.UserRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/users")
public class UserController {

    @Autowired
    private UserRepository userRepository;

    // GET semua user
    @GetMapping
    public List<User> getAllUsers(){
        return userRepository.findAll();
    }

    // TAMBAH USER
    @PostMapping
    public User createUser(@RequestBody User user){
        return userRepository.save(user);
    }

    // UPDATE USER
    @PutMapping("/{id}")
    public User updateUser(@PathVariable Long id, @RequestBody User user){

        User existing = userRepository.findById(id).orElseThrow();

        existing.setUsername(user.getUsername());
        existing.setPassword(user.getPassword());
        existing.setEmail(user.getEmail());
        existing.setRole(user.getRole());

        return userRepository.save(existing);
    }

    // DELETE USER
    @DeleteMapping("/{id}")
    public void deleteUser(@PathVariable Long id){
        userRepository.deleteById(id);
    }
}
package com.absensi_api.controller;

import com.absensi_api.model.StatusAbsensi;
import com.absensi_api.repository.StatusAbsensiRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/status-absensi")
public class StatusAbsensiController {

    @Autowired
    private StatusAbsensiRepository repo;

    @GetMapping
    public List<StatusAbsensi> getAll(){
        return repo.findAll();
    }
}
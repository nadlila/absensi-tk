package com.absensi_api.controller;

import com.absensi_api.model.HariLibur;
import com.absensi_api.repository.HariLiburRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/hari-libur")
@CrossOrigin
public class HariLiburController {

    @Autowired
    private HariLiburRepository hariLiburRepository;

    @GetMapping
    public List<HariLibur> getAll() {
        return hariLiburRepository.findAll();
    }

    @PostMapping
    public HariLibur create(@RequestBody HariLibur hariLibur) {
        return hariLiburRepository.save(hariLibur);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        hariLiburRepository.deleteById(id);
    }
}

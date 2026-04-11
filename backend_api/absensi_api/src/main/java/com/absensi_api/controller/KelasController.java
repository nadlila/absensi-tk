package com.absensi_api.controller;

import com.absensi_api.model.Kelas;
import com.absensi_api.repository.KelasRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/kelas")
public class KelasController {

    @Autowired
    private KelasRepository kelasRepository;

    @GetMapping
    public List<Kelas> getAll() {
        return kelasRepository.findAll();
    }

    @PostMapping
    public Kelas create(@RequestBody Kelas kelas) {
        return kelasRepository.save(kelas);
    }

    @PutMapping("/{id}")
    public Kelas update(@PathVariable String id, @RequestBody Kelas kelas) {

        Kelas existing = kelasRepository.findById(id).orElseThrow();

        existing.setNamaKelas(kelas.getNamaKelas());

        return kelasRepository.save(existing);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable String id) {
        kelasRepository.deleteById(id);
    }
}
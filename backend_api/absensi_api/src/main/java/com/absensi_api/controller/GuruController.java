package com.absensi_api.controller;

import com.absensi_api.model.Guru;
import com.absensi_api.repository.GuruRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/guru")
@CrossOrigin
public class GuruController {

    @Autowired
    private GuruRepository guruRepository;

    // GET semua guru
    @GetMapping
    public List<Guru> getAllGuru() {
        return guruRepository.findAll();
    }

    // GET guru by id
    @GetMapping("/{id}")
    public Guru getGuruById(@PathVariable Long id) {
        return guruRepository.findById(id).orElse(null);
    }

    // POST tambah guru
    @PostMapping
    public Guru createGuru(@RequestBody Guru guru) {
        return guruRepository.save(guru);
    }

    // PUT update guru
    @PutMapping("/{id}")
    public Guru updateGuru(@PathVariable Long id, @RequestBody Guru guru) {

        Guru existing = guruRepository.findById(id).orElse(null);

        if (existing != null) {
            existing.setNamaGuru(guru.getNamaGuru());
            existing.setNuptk(guru.getNuptk());
            existing.setStatus(guru.getStatus());
            existing.setTempatLahir(guru.getTempatLahir());
            existing.setTanggalLahir(guru.getTanggalLahir());
            existing.setAlamat(guru.getAlamat());
            existing.setIdUser(guru.getIdUser());

            return guruRepository.save(existing);
        }

        return null;
    }

    // DELETE guru
    @DeleteMapping("/{id}")
    public void deleteGuru(@PathVariable Long id) {
        guruRepository.deleteById(id);
    }

}
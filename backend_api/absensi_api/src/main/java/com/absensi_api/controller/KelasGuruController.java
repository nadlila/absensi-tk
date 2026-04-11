package com.absensi_api.controller;

import com.absensi_api.dto.KelasDetailDTO;
import com.absensi_api.model.KelasGuru;
import com.absensi_api.repository.KelasGuruRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/kelas-guru")
public class KelasGuruController {

    @Autowired
    private KelasGuruRepository kelasGuruRepository;

    // GET semua
    @GetMapping
    public List<KelasGuru> getAll() {
        return kelasGuruRepository.findAll();
    }

    // GET berdasarkan kelas
    @GetMapping("/kelas/{idKelas}")
    public List<KelasGuru> getByKelas(@PathVariable String idKelas) {
        return kelasGuruRepository.findByIdKelas(idKelas);
    }

    // GET berdasarkan guru
    @GetMapping("/guru/{idGuru}")
    public List<KelasGuru> getByGuru(@PathVariable Long idGuru) {
        return kelasGuruRepository.findByIdGuru(idGuru);
    }

    @GetMapping("/detail")
    public List<KelasDetailDTO> getDetailKelas() {
        return kelasGuruRepository.getDetailKelasAktif();
    }

    @GetMapping("/guru/{idGuru}")
    public KelasGuru getKelasGuru(@PathVariable Long idGuru){

        return kelasGuruRepository.getKelasGuruAktif(idGuru);

    }

    // POST tambah wali kelas
    @PostMapping
    public KelasGuru create(@RequestBody KelasGuru kelasGuru) {
        return kelasGuruRepository.save(kelasGuru);
    }

    // PUT update
    @PutMapping("/{id}")
    public KelasGuru update(
            @PathVariable Long id,
            @RequestBody KelasGuru data) {

        KelasGuru existing = kelasGuruRepository.findById(id).orElseThrow();

        existing.setIdKelas(data.getIdKelas());
        existing.setIdGuru(data.getIdGuru());
        existing.setIdTahunAjaran(data.getIdTahunAjaran());

        return kelasGuruRepository.save(existing);
    }

    // DELETE
    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        kelasGuruRepository.deleteById(id);
    }
}
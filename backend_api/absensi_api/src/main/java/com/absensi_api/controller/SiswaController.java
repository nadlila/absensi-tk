package com.absensi_api.controller;
import org.springframework.transaction.annotation.Transactional;

import com.absensi_api.model.Siswa;
import com.absensi_api.repository.SiswaKelasRepository;
import com.absensi_api.repository.SiswaRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/siswa")
public class SiswaController {

    @Autowired
    private SiswaRepository siswaRepository;

    @GetMapping
    public List<Siswa> getAll() {
        return siswaRepository.findAll();
    }

//     @GetMapping("/kelas/{idKelas}")
// public List<Siswa> getByKelas(@PathVariable String idKelas) {
//     return siswaRepository.findByIdKelas(idKelas);
//}
    @PostMapping
    public Siswa create(@RequestBody Siswa siswa) {
        return siswaRepository.save(siswa);
    }

    @PutMapping("/{id}")
    public Siswa update(@PathVariable Long id, @RequestBody Siswa siswa) {

        Siswa existing = siswaRepository.findById(id).orElseThrow();

        existing.setNamaSiswa(siswa.getNamaSiswa());
        existing.setNisn(siswa.getNisn());
        existing.setTempatLahir(siswa.getTempatLahir());
        existing.setTanggalLahir(siswa.getTanggalLahir());
        existing.setAlamat(siswa.getAlamat());

        return siswaRepository.save(existing);
    }

    @Autowired
        private SiswaKelasRepository siswaKelasRepository;
    @Transactional
    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {

    // 🔥 hapus relasi dulu
    siswaKelasRepository.deleteByIdSiswa(id);

    // 🔥 baru hapus siswa
    siswaRepository.deleteById(id);
}
@GetMapping("/kelas/{idKelas}")
public List<?> getSiswaByKelas(
        @PathVariable String idKelas,
        @RequestParam Long idTahunAjaran
){
    return siswaKelasRepository.getByKelasDanTahun(idKelas, idTahunAjaran);
}
}
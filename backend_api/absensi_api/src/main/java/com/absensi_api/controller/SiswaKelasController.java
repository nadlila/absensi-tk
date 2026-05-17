package com.absensi_api.controller;

import com.absensi_api.model.SiswaKelas;
import com.absensi_api.repository.SiswaKelasRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@RequestMapping("/api/siswa-kelas")
public class SiswaKelasController {

    @Autowired
    private SiswaKelasRepository siswaKelasRepository;

    // 🔥 TAMBAH (dipakai saat tambah siswa)
    @PostMapping
    public SiswaKelas create(@RequestBody SiswaKelas data){
        return siswaKelasRepository.save(data);
    }

    // 🔥 MUTASI (FIX BUG DOBEL)
    @PutMapping("/mutasi")
    public SiswaKelas mutasi(@RequestBody Map<String, Object> payload){

    Long idSiswa = Long.valueOf(payload.get("idSiswa").toString());
    String idKelas = payload.get("idKelas").toString();
    Long idTahun = Long.valueOf(payload.get("idTahunAjaran").toString());

    Optional<SiswaKelas> optional =
        siswaKelasRepository.findByIdSiswaAndIdTahunAjaran(idSiswa, idTahun);

    if(optional.isEmpty()){
        throw new RuntimeException("Data siswa_kelas tidak ditemukan");
    }

    SiswaKelas sk = optional.get();

    sk.setIdKelas(idKelas);

    return siswaKelasRepository.save(sk);
}

    // 🔥 FILTER (dipakai Flutter kamu)
    @GetMapping("/filter")
    public List<?> filter(
            @RequestParam String idKelas,
            @RequestParam Long idTahun
    ){
        return siswaKelasRepository.getByKelasDanTahun(idKelas, idTahun);
    }

//     // 🔥 NAIK KELAS MASSAL
@PostMapping("/naik-kelas-massal")
public String naikKelasMassal(@RequestBody Map<String, Object> payload) {
    String idKelasAsal = payload.get("idKelasAsal").toString();
    Long idTahunLama = Long.valueOf(payload.get("idTahunLama").toString());

    String idKelasBaru = payload.get("idKelasBaru").toString();
    Long idTahunBaru = Long.valueOf(payload.get("idTahunBaru").toString());

    // 1. Ambil semua siswa dari kelas lama & tahun lama
    List<SiswaKelas> listSiswaLama = siswaKelasRepository.findByIdKelasAndIdTahunAjaran(idKelasAsal, idTahunLama);

    int count = 0;
    for (SiswaKelas sk : listSiswaLama) {
        // 2. Cek apakah siswa sudah terdaftar di tahun baru (biar tidak dobel)
        boolean exists = siswaKelasRepository.findByIdSiswaAndIdTahunAjaran(sk.getIdSiswa(), idTahunBaru).isPresent();

        if (!exists) {
            SiswaKelas baru = new SiswaKelas();
            baru.setIdSiswa(sk.getIdSiswa());
            baru.setIdKelas(idKelasBaru); // Kelas tujuan (bisa sama atau beda)
            baru.setIdTahunAjaran(idTahunBaru);
            siswaKelasRepository.save(baru);
            count++;
        }
    }

    return "Berhasil memindahkan " + count + " siswa ke kelas " + idKelasBaru;
}

@PostMapping("/naik-kelas-siswa")
public String naikKelasPerSiswa(@RequestBody Map<String, Object> payload){

    Long idSiswa = Long.valueOf(payload.get("idSiswa").toString());
    String idKelasBaru = payload.get("idKelas").toString();
    Long idTahunBaru = Long.valueOf(payload.get("idTahunAjaran").toString());

    // 🔥 CEK BIAR GAK DOBEL
    boolean sudahAda =
            siswaKelasRepository
            .findByIdSiswaAndIdTahunAjaran(idSiswa, idTahunBaru)
            .isPresent();

    if(sudahAda){
        return "Siswa sudah ada di tahun ini";
    }

    SiswaKelas baru = new SiswaKelas();

    baru.setIdSiswa(idSiswa);
    baru.setIdKelas(idKelasBaru);
    baru.setIdTahunAjaran(idTahunBaru);

    siswaKelasRepository.save(baru);

    return "Naik kelas berhasil";
}
@GetMapping("/kelas/{idKelas}")
public List<?> getSiswaByKelas(
        @PathVariable String idKelas,
        @RequestParam Long idTahunAjaran
){
    return siswaKelasRepository.getByKelasDanTahun(idKelas, idTahunAjaran);
}
}
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
//     @PostMapping("/naik-kelas")
// public String naikKelas(@RequestBody Map<String, Object> payload){

//     Long tahunLama = Long.valueOf(payload.get("tahunLama").toString());
//     Long tahunBaru = Long.valueOf(payload.get("tahunBaru").toString());

//     Map<String, String> mapping =
//             (Map<String, String>) payload.get("mapping");

//     List<SiswaKelas> dataLama =
//             siswaKelasRepository.findByIdTahunAjaran(tahunLama);

//     for(SiswaKelas sk : dataLama){

//         String kelasBaru = mapping.get(sk.getIdKelas());

//         // 🔥 kalau tidak ada mapping → skip (misal B = lulus)
//         if(kelasBaru == null) continue;

//         // 🔥 anti dobel
//         boolean sudahAda =
//                 siswaKelasRepository
//                 .findByIdSiswaAndIdTahunAjaran(
//                         sk.getIdSiswa(), tahunBaru
//                 ).isPresent();

//         if(sudahAda) continue;

//         SiswaKelas baru = new SiswaKelas();

//         baru.setIdSiswa(sk.getIdSiswa());
//         baru.setIdTahunAjaran(tahunBaru);
//         baru.setIdKelas(kelasBaru);

//         siswaKelasRepository.save(baru);
//     }

//     return "Naik kelas berhasil";
// }

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
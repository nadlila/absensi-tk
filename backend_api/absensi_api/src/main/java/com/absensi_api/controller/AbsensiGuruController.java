 package com.absensi_api.controller;

import com.absensi_api.model.Guru;
import com.absensi_api.repository.GuruRepository;
import com.absensi_api.repository.AbsensiGuruRepository;
import com.absensi_api.model.StatusAbsensi;
import com.absensi_api.model.TahunAjaran;
import com.absensi_api.model.AbsensiGuru;
import com.absensi_api.repository.StatusAbsensiRepository;
import com.absensi_api.repository.TahunAjaranRepository;
import com.absensi_api.dto.RekapGuruDTO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
 
@RestController
@RequestMapping("/api/absensi-guru")
@CrossOrigin
public class AbsensiGuruController {

    @Autowired
    private AbsensiGuruRepository absensiGuruRepository;

    @Autowired
    private GuruRepository guruRepository;

    @Autowired
    private StatusAbsensiRepository statusRepo;

    @Autowired
    private TahunAjaranRepository tahunRepo;

    @PostMapping
    public AbsensiGuru create(@RequestBody AbsensiGuru request) {

        Guru guru = guruRepository
                .findById(request.getGuru().getIdGuru())
                .orElseThrow(() -> new RuntimeException("Guru tidak ditemukan"));

        StatusAbsensi status = statusRepo
                .findById(request.getStatus().getIdStatus())
                .orElseThrow(() -> new RuntimeException("Status tidak ditemukan"));

        TahunAjaran tahun = tahunRepo
            .findById(request.getIdTahunAjaran())
            .orElse(null);

        if (absensiGuruRepository.existsByGuruAndTanggal(guru, request.getTanggal())) {
            throw new RuntimeException("Guru sudah absen hari ini");
        }

        request.setGuru(guru);
        request.setStatus(status);
        request.setTahunAjaran(tahun);

        return absensiGuruRepository.save(request);
    }

    @GetMapping
    public List<AbsensiGuru> getAll() {
        return absensiGuruRepository.findAll();
    }

    @GetMapping("/guru/{idGuru}")
    public List<AbsensiGuru> getByGuru(@PathVariable Long idGuru) {
        Guru guru = guruRepository.findById(idGuru).orElse(null);
        if (guru != null) {
            return absensiGuruRepository.findByGuru(guru);
        }
        return List.of();
    }

    @GetMapping("/tahun/{idTahun}")
    public List<AbsensiGuru> getByTahun(
            @PathVariable Long idTahun
    ) {
        return absensiGuruRepository
                .findByTahunAjaran_IdTahunAjaran(idTahun);
    }

    @GetMapping("/rekap/{idTahun}")
    public List<RekapGuruDTO> getRekapGuru(
            @PathVariable Long idTahun
    ) {
        return absensiGuruRepository.getRekapGuru(idTahun);
    }
}
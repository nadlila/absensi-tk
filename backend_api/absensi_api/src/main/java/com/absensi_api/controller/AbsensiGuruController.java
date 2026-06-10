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

import java.time.LocalTime;
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

        LocalTime jamSekarang = LocalTime.now();
        String namaStatus = status.getNamaStatus().toLowerCase();
        
        // Logika khusus untuk status "Hadir"
        if (namaStatus.equals("hadir")) {
            // Batasan Jam Absen
            if (jamSekarang.isBefore(LocalTime.of(7, 0))) {
                throw new RuntimeException("Absen belum dibuka, silakan kembali pukul 07:00");
            }
            if (jamSekarang.isAfter(LocalTime.of(8, 30))) {
                throw new RuntimeException("Batas waktu absen telah berakhir (8:30)");
            }

            // Logika Keterangan Terlambat
            if (jamSekarang.isAfter(LocalTime.of(7, 30))) {
                request.setKeterangan("Terlambat");
            } else {
                request.setKeterangan("Tepat Waktu");
            }
        } else {
            // Jika Izin/Sakit, keterangan dikosongkan (alasan sudah ada di kolom 'alasan')
            request.setKeterangan("-");
        }

        request.setGuru(guru);
        request.setStatus(status);
        request.setTahunAjaran(tahun);
        request.setJam(jamSekarang);

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

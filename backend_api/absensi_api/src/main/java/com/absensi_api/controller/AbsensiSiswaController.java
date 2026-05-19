package com.absensi_api.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.HashMap;
import java.util.Map;
import java.time.LocalDate;

import com.absensi_api.dto.DetailAbsensiDTO;
import com.absensi_api.dto.RekapAbsensiDTO;
import com.absensi_api.model.AbsensiSiswa;
import com.absensi_api.model.StatusAbsensi;
import com.absensi_api.repository.AbsensiSiswaRepository;

import java.util.List;


@RestController
@RequestMapping("/api/absensi-siswa")
public class AbsensiSiswaController {
    @PersistenceContext
    private EntityManager em;

    @Autowired
    private AbsensiSiswaRepository repo;

    @PostMapping
    public Map<String, Object> saveAbsensi(@RequestBody List<AbsensiSiswa> list) {
        int saved = 0;
        int skipped = 0;

        for (AbsensiSiswa data : list) {
            if (data.getIdStatus() != null) {
                data.setStatus(
                        em.getReference(StatusAbsensi.class, data.getIdStatus())
                );
            }

            boolean exists = repo.existsBySiswa_IdSiswaAndTanggal(
                    data.getIdSiswa(),
                    data.getTanggal()
            );

            if (!exists) {
                repo.save(data);
                saved++;
            } else {
                skipped++;
            }
        }

        Map<String, Object> response = new HashMap<>();
        response.put("saved", saved);
        response.put("skipped", skipped);
        response.put("status", "success");
        return response;
    }

    @GetMapping("/rekap")
    public List<RekapAbsensiDTO> rekap(
            @RequestParam String idKelas,
            @RequestParam Long idTahun
    ) {
        return repo.getRekapByTahun(
                idKelas,
                idTahun
        );
    }

    @GetMapping("/detail-siswa")
    public List<DetailAbsensiDTO> detailSiswa(
            @RequestParam Long idSiswa,
            @RequestParam Long idTahun
    ) {
        return repo.getDetailSiswa(idSiswa, idTahun);
    }

    @GetMapping("/detail")
    public List<DetailAbsensiDTO> getDetailByTanggal(
            @RequestParam Long idSiswa,
            @RequestParam String start,
            @RequestParam String end
    ) {
        return repo.getDetailByTanggal(
                idSiswa,
                LocalDate.parse(start),
                LocalDate.parse(end)
        );
    }

    @GetMapping("/daily-stats")
    public java.util.Map<java.lang.String, java.lang.Integer> getDailyStats(
            @RequestParam java.lang.String idKelas,
            @RequestParam java.lang.String tanggal
    ) {
        LocalDate date = LocalDate.parse(tanggal);
        java.util.List<AbsensiSiswa> list = repo.findByKelas_IdKelasAndTanggal(idKelas, date);
        java.util.Map<java.lang.String, java.lang.Integer> stats = new HashMap<>();

        stats.put("hadir", 0);
        stats.put("izin", 0);
        stats.put("sakit", 0);
        stats.put("alfa", 0);

        for (AbsensiSiswa a : list) {
            java.lang.String status = a.getStatus().getNamaStatus().toLowerCase();
            stats.put(status, stats.getOrDefault(status, 0) + 1);
        }
        return stats;
    }
}

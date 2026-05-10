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

import com.absensi_api.dto.DetailAbsensiDTO;
import com.absensi_api.dto.RekapAbsensiDTO;
import com.absensi_api.model.AbsensiSiswa;
import com.absensi_api.model.StatusAbsensi;
import com.absensi_api.repository.AbsensiSiswaRepository;

import java.time.LocalDate;
import java.util.List;


@RestController
@RequestMapping("/api/absensi-siswa")
public class AbsensiSiswaController {
    @PersistenceContext
        private EntityManager em;

    @Autowired
    private AbsensiSiswaRepository repo;

    @PostMapping
public void saveAbsensi(@RequestBody List<AbsensiSiswa> list){

    for(AbsensiSiswa data : list){

        // 🔥 FIX: ambil reference dari DB
            if(data.getIdStatus() != null){
                data.setStatus(
                    em.getReference(StatusAbsensi.class, data.getIdStatus())
                );
            }

            boolean exists = repo.existsBySiswa_IdSiswaAndTanggal(
                data.getIdSiswa(),
                data.getTanggal()
            );

            if(!exists){
                repo.save(data);
            }
        }
    }

    @GetMapping("/rekap")
    public List<RekapAbsensiDTO> rekap(
        @RequestParam String idKelas,
        @RequestParam Long idTahun
    ){
        return repo.getRekapByTahun(
            idKelas,
            idTahun
        );
    }

    @GetMapping("/detail-siswa")
    public List<DetailAbsensiDTO> detailSiswa(
        @RequestParam Long idSiswa,
        @RequestParam Long idTahun
    ){
        return repo.getDetailSiswa(idSiswa, idTahun);
    }

    @GetMapping("/detail")
    public List<DetailAbsensiDTO> getDetailByTanggal(
        @RequestParam Long idSiswa,
        @RequestParam String start,
        @RequestParam String end
    ){
        return repo.getDetailByTanggal(
            idSiswa,
            LocalDate.parse(start),
            LocalDate.parse(end)
        );
    }

}
    


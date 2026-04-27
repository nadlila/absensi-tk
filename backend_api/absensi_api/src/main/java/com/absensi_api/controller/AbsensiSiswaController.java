package com.absensi_api.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.absensi_api.dto.DetailAbsensiDTO;
import com.absensi_api.dto.RekapAbsensiDTO;
import com.absensi_api.model.AbsensiSiswa;
import com.absensi_api.repository.AbsensiSiswaRepository;

import java.time.LocalDate;
import java.util.List;


@RestController
@RequestMapping("/api/absensi-siswa")
public class AbsensiSiswaController {

    @Autowired
    private AbsensiSiswaRepository repo;

    @PostMapping
    public void saveAbsensi(@RequestBody List<AbsensiSiswa> list){

        for(AbsensiSiswa data : list){

            boolean exists = repo.existsByIdSiswaAndTanggal(
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
    @RequestParam String start,
    @RequestParam String end
){
    return repo.getRekap(
        idKelas,
        LocalDate.parse(start),
        LocalDate.parse(end)
    );
}

@GetMapping("/detail-siswa")
public List<DetailAbsensiDTO> detailSiswa(
    @RequestParam Long idSiswa,
    @RequestParam Long idTahun
){
    return repo.getDetailSiswa(idSiswa, idTahun);
}

}
    


package com.absensi_api.controller;

import com.absensi_api.dto.SiswaDetailDTO;
import com.absensi_api.model.SiswaKelas;
import com.absensi_api.repository.SiswaKelasRepository;
//import com.absensi_api.service.SiswaKelasService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import com.absensi_api.dto.SiswaDetailDTO;

@RestController
@RequestMapping("/api/siswa-kelas")
public class SiswaKelasController {

    @Autowired
    private SiswaKelasRepository siswaKelasRepository;

    // GET semua data
    @GetMapping
    public List<SiswaKelas> getAll() {
        return siswaKelasRepository.findAll();
    }

    // GET berdasarkan kelas
    @GetMapping("/kelas/{idKelas}")
    public List<SiswaKelas> getByKelas(@PathVariable String idKelas) {
        return siswaKelasRepository.findByIdKelas(idKelas);
    }

    // GET berdasarkan tahun ajaran
    @GetMapping("/tahun/{idTahun}")
    public List<SiswaKelas> getByTahun(@PathVariable Long idTahun) {
        return siswaKelasRepository.findByIdTahunAjaran(idTahun);
    }

    // POST tambah data
    @PostMapping
    public SiswaKelas create(@RequestBody SiswaKelas siswaKelas) {
        return siswaKelasRepository.save(siswaKelas);
    }

    // @Autowired
    // private SiswaKelasService siswaKelasService;

    // @PostMapping("/naik-kelas/{tahunBaru}")
    // public void naikKelas(@PathVariable Long tahunBaru){

    //     siswaKelasService.naikKelas(tahunBaru);

    // }

    // DELETE
    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        siswaKelasRepository.deleteById(id);
    }
    @GetMapping("/detail")
    public List<SiswaDetailDTO> getDetail() {
        return siswaKelasRepository.getSiswaDetail();
    }
    @GetMapping("/filter")
    public List<SiswaDetailDTO> getByKelasDanTahun(
        @RequestParam String idKelas,
        @RequestParam Long idTahun) {

        return siswaKelasRepository.getByKelasDanTahun(idKelas, idTahun);
    }
}
package com.absensi_api.controller;

import com.absensi_api.model.TahunAjaran;
import com.absensi_api.repository.TahunAjaranRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/tahun-ajaran")
public class TahunAjaranController {

    @Autowired
    private TahunAjaranRepository tahunAjaranRepository;

    @GetMapping
    public List<TahunAjaran> getAll() {
        return tahunAjaranRepository.findAll();
    }

    @GetMapping("/aktif")
    public TahunAjaran getAktif() {
        return tahunAjaranRepository.findByStatus("aktif").orElse(null);
    }

    @PostMapping
    public TahunAjaran create(@RequestBody TahunAjaran tahunAjaran) {
        return tahunAjaranRepository.save(tahunAjaran);
    }

    @PutMapping("/{id}")
    public TahunAjaran update(@PathVariable Long id, @RequestBody TahunAjaran tahunAjaran) {

        TahunAjaran existing = tahunAjaranRepository.findById(id).orElseThrow();

        existing.setTahun(tahunAjaran.getTahun());
        existing.setSemester(tahunAjaran.getSemester());
        existing.setStatus(tahunAjaran.getStatus());

        return tahunAjaranRepository.save(existing);
    }

    @PutMapping("/aktif/{id}")
    public void aktifkan(@PathVariable Long id){

        List<TahunAjaran> list = tahunAjaranRepository.findAll();

        for(TahunAjaran t : list){
            t.setStatus("tidak");
            tahunAjaranRepository.save(t);
        }

        TahunAjaran aktif = tahunAjaranRepository.findById(id).orElseThrow();
        aktif.setStatus("aktif");

        tahunAjaranRepository.save(aktif);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        tahunAjaranRepository.deleteById(id);
    }
}
package com.absensi_api.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "hari_libur")
public class HariLibur {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idLibur;
    
    private LocalDate tanggal;
    private String keterangan;

    public Long getIdLibur() {
        return idLibur;
    }

    public void setIdLibur(Long idLibur) {
        this.idLibur = idLibur;
    }

    public LocalDate getTanggal() {
        return tanggal;
    }

    public void setTanggal(LocalDate tanggal) {
        this.tanggal = tanggal;
    }

    public String getKeterangan() {
        return keterangan;
    }

    public void setKeterangan(String keterangan) {
        this.keterangan = keterangan;
    }
}

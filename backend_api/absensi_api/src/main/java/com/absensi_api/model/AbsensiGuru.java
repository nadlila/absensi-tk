package com.absensi_api.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "absensi_guru")
public class AbsensiGuru {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idAbsensiGuru;

    @ManyToOne
    @JoinColumn(name = "id_guru")
    private Guru guru;

    private LocalDate tanggal;

    private String status;

    public Long getIdAbsensi() {
        return idAbsensiGuru;
    }

    public void setIdAbsensi(Long idAbsensi) {
        this.idAbsensiGuru = idAbsensiGuru;
    }

    public Guru getGuru() {
        return guru;
    }

    public void setGuru(Guru guru) {
        this.guru = guru;
    }

    public LocalDate getTanggal() {
        return tanggal;
    }

    public void setTanggal(LocalDate tanggal) {
        this.tanggal = tanggal;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
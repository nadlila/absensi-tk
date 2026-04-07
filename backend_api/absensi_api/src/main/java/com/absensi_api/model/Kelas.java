package com.absensi_api.model;

import jakarta.persistence.*;

@Entity
@Table(name = "kelas")
public class Kelas {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idKelas;

    private String namaKelas;

    @ManyToOne
    @JoinColumn(name = "wali_kelas")
    private Guru waliKelas;

    public Long getIdKelas() {
        return idKelas;
    }

    public void setIdKelas(Long idKelas) {
        this.idKelas = idKelas;
    }

    public String getNamaKelas() {
        return namaKelas;
    }

    public void setNamaKelas(String namaKelas) {
        this.namaKelas = namaKelas;
    }

    public Guru getWaliKelas() {
        return waliKelas;
    }

    public void setWaliKelas(Guru waliKelas) {
        this.waliKelas = waliKelas;
    }
}
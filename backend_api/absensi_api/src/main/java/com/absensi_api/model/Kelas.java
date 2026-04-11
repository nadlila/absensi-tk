package com.absensi_api.model;

import jakarta.persistence.*;

@Entity
@Table(name = "kelas")
public class Kelas {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String idKelas;

    private String namaKelas;

    public String getIdKelas() {
        return idKelas;
    }

    public void setIdKelas(String idKelas) {
        this.idKelas = idKelas;
    }

    public String getNamaKelas() {
        return namaKelas;
    }

    public void setNamaKelas(String namaKelas) {
        this.namaKelas = namaKelas;
    }
}
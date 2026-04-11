package com.absensi_api.model;

import jakarta.persistence.*;

@Entity
@Table(name = "kelas_guru")
public class KelasGuru {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String idKelas;

    private Long idGuru;

    private Long idTahunAjaran;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getIdKelas() {
        return idKelas;
    }

    public void setIdKelas(String idKelas) {
        this.idKelas = idKelas;
    }

    public Long getIdGuru() {
        return idGuru;
    }

    public void setIdGuru(Long idGuru) {
        this.idGuru = idGuru;
    }

    public Long getIdTahunAjaran() {
        return idTahunAjaran;
    }

    public void setIdTahunAjaran(Long idTahunAjaran) {
        this.idTahunAjaran = idTahunAjaran;
    }
}
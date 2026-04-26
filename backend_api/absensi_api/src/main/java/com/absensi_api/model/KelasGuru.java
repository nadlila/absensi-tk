package com.absensi_api.model;

import jakarta.persistence.*;

@Entity
@Table(name = "kelas_guru")
public class KelasGuru {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "id_kelas")
    private String idKelas;

    @Column(name = "id_guru")
    private Long idGuru;

    @Column(name = "id_tahun_ajaran")
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
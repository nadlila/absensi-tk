package com.absensi_api.model;

import jakarta.persistence.*;

@Entity
@Table(name = "tahun_ajaran")
public class TahunAjaran {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idTahunAjaran;

    private String tahun;

    private String semester;

    private String status;

    public Long getIdTahunAjaran() {
        return idTahunAjaran;
    }

    public void setIdTahunAjaran(Long idTahunAjaran) {
        this.idTahunAjaran = idTahunAjaran;
    }

    public String getTahun() {
        return tahun;
    }

    public void setTahun(String tahun) {
        this.tahun = tahun;
    }

    public String getSemester() {
        return semester;
    }

    public void setSemester(String semester) {
        this.semester = semester;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
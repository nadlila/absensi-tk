package com.absensi_api.dto;

public class KelasDetailDTO {

    private String idKelas;
    private String namaKelas;
    private String waliKelas;
    private String tahun;
    private String semester;

    public KelasDetailDTO(
            String idKelas,
            String namaKelas,
            String waliKelas,
            String tahun,
            String semester) {

        this.idKelas = idKelas;
        this.namaKelas = namaKelas;
        this.waliKelas = waliKelas;
        this.tahun = tahun;
        this.semester = semester;
    }

    public String getIdKelas() {
        return idKelas;
    }

    public String getNamaKelas() {
        return namaKelas;
    }

    public String getWaliKelas() {
        return waliKelas;
    }

    public String getTahun() {
        return tahun;
    }

    public String getSemester() {
        return semester;
    }
}
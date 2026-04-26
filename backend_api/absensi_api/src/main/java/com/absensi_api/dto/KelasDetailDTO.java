package com.absensi_api.dto;

public class KelasDetailDTO {

    private Long id;
    private String idKelas;
    private String namaKelas;
    private String waliKelas;
    private String tahun;
    private String semester;
    private Long idGuru;
    private Long idTahunAjaran; // 🔥 WAJIB

    // 🔥 CONSTRUCTOR HARUS SESUAI QUERY
    public KelasDetailDTO(
            Long id,
            String idKelas,
            String namaKelas,
            String waliKelas,
            String tahun,
            String semester,
            Long idGuru,
            Long idTahunAjaran) {

        this.id = id;
        this.idKelas = idKelas;
        this.namaKelas = namaKelas;
        this.waliKelas = waliKelas;
        this.tahun = tahun;
        this.semester = semester;
        this.idGuru = idGuru;
        this.idTahunAjaran = idTahunAjaran;
    }

    public Long getId() {
        return id;
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

    public Long getIdGuru() {
        return idGuru;
    }

    public Long getIdTahunAjaran() {
        return idTahunAjaran;
    }
}
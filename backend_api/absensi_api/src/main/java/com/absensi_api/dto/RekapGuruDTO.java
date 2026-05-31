package com.absensi_api.dto;

public class RekapGuruDTO {

    private Long idGuru;
    private String namaGuru;

    private Long hadir;
    private Long izin;
    private Long sakit;
    private Long alpa;

    public RekapGuruDTO(
            Long idGuru,
            String namaGuru,
            Long hadir,
            Long izin,
            Long sakit,
            Long alpa
    ) {
        this.idGuru = idGuru;
        this.namaGuru = namaGuru;
        this.hadir = hadir;
        this.izin = izin;
        this.sakit = sakit;
        this.alpa = alpa;
    }

    public Long getIdGuru() {
        return idGuru;
    }

    public String getNamaGuru() {
        return namaGuru;
    }

    public Long getHadir() {
        return hadir;
    }

    public Long getIzin() {
        return izin;
    }

    public Long getSakit() {
        return sakit;
    }

    public Long getAlpa() {
        return alpa;
    }
}
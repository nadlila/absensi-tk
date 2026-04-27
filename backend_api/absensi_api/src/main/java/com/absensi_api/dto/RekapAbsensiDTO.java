package com.absensi_api.dto;

public class RekapAbsensiDTO {

    private Long idSiswa;
    private String namaSiswa;

    private Long hadir;
    private Long izin;
    private Long sakit;
    private Long alfa;

    public RekapAbsensiDTO(
        Long idSiswa,
        String namaSiswa,
        Long hadir,
        Long izin,
        Long sakit,
        Long alfa
    ){
        this.idSiswa = idSiswa;
        this.namaSiswa = namaSiswa;
        this.hadir = hadir;
        this.izin = izin;
        this.sakit = sakit;
        this.alfa = alfa;
    }

    // getter
    public Long getIdSiswa() { return idSiswa; }
    public String getNamaSiswa() { return namaSiswa; }
    public Long getHadir() { return hadir; }
    public Long getIzin() { return izin; }
    public Long getSakit() { return sakit; }
    public Long getAlfa() { return alfa; }
}
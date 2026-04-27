package com.absensi_api.dto;

import java.time.LocalDate;

public class DetailAbsensiDTO {

    private LocalDate tanggal;
    private String status;
    private String keterangan;

    public DetailAbsensiDTO(
        LocalDate tanggal,
        String status,
        String keterangan
    ){
        this.tanggal = tanggal;
        this.status = status;
        this.keterangan = keterangan;
    }

    public LocalDate getTanggal() { return tanggal; }
    public String getStatus() { return status; }
    public String getKeterangan() { return keterangan; }
}
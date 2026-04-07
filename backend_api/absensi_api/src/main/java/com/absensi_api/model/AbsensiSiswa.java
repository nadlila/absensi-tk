package com.absensi_api.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "absensi_siswa")
public class AbsensiSiswa {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idAbsensi;

    @ManyToOne
    @JoinColumn(name = "id_siswa")
    private Siswa siswa;

    private LocalDate tanggal;

    private String status;

    private String keterangan;

    public Long getIdAbsensi() {
        return idAbsensi;
    }

    public void setIdAbsensi(Long idAbsensi) {
        this.idAbsensi = idAbsensi;
    }

    public Siswa getSiswa() {
        return siswa;
    }

    public void setSiswa(Siswa siswa) {
        this.siswa = siswa;
    }

    public LocalDate getTanggal() {
        return tanggal;
    }

    public void setTanggal(LocalDate tanggal) {
        this.tanggal = tanggal;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getKeterangan() {
        return keterangan;
    }

    public void setKeterangan(String keterangan) {
        this.keterangan = keterangan;
    }
}
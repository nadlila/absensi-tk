package com.absensi_api.model;

import jakarta.persistence.*;

@Entity
@Table(name = "guru")
public class Guru {

     @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_guru")
    private Long idGuru;

    @Column(name = "nama_guru")
    private String namaGuru;

    @Column(name = "nuptk")
    private String nuptk;

    @Column(name = "status")
    private String status;

    @Column(name = "tempat_lahir")
    private String tempatLahir;

    @Column(name = "tanggal_lahir")
    private String tanggalLahir;

    @Column(name = "alamat")
    private String alamat;

    @Column(name = "id_user")
    private Long idUser;

    public Long getIdGuru() {
        return idGuru;
    }

    public void setIdGuru(Long idGuru) {
        this.idGuru = idGuru;
    }

    public String getNamaGuru() {
        return namaGuru;
    }

    public void setNamaGuru(String namaGuru) {
        this.namaGuru = namaGuru;
    }

    public String getNuptk() {
        return nuptk;
    }

    public void setNuptk(String nuptk) {
        this.nuptk = nuptk;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getTempatLahir() {
        return tempatLahir;
    }

    public void setTempatLahir(String tempatLahir) {
        this.tempatLahir = tempatLahir;
    }

    public String getTanggalLahir() {
        return tanggalLahir;
    }

    public void setTanggalLahir(String tanggalLahir) {
        this.tanggalLahir = tanggalLahir;
    }

    public String getAlamat() {
        return alamat;
    }

    public void setAlamat(String alamat) {
        this.alamat = alamat;
    }

    public Long getIdUser() {
        return idUser;
    }

    public void setIdUser(Long idUser) {
        this.idUser = idUser;
    }
}
package com.absensi_api.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "absensi_siswa") 
public class AbsensiSiswa {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_absensi_siswa") 
    private Long idAbsensi;
    @ManyToOne
    @JoinColumn(name = "id_siswa")
    private Siswa siswa;

    private LocalDate tanggal;

    @ManyToOne
    @JoinColumn(name = "id_status")
    private StatusAbsensi status;

    private String keterangan;

    @ManyToOne
    @JoinColumn(name = "id_kelas")
    private Kelas kelas;

    @ManyToOne
    @JoinColumn(name = "id_tahun_ajaran")
    private TahunAjaran tahunAjaran;

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

    public StatusAbsensi getStatus() {
        return status;
    }

    public void setStatus(StatusAbsensi status) {
        this.status = status;
    }
 
    public String getKeterangan() {
        return keterangan;
    }

    public void setKeterangan(String keterangan) {
        this.keterangan = keterangan;
    }
    public Long getIdSiswa() {
    return siswa != null ? siswa.getIdSiswa() : null;
    }

    public void setIdSiswa(Long idSiswa) {
        this.siswa = new Siswa();
        this.siswa.setIdSiswa(idSiswa);
    }

    public Kelas getKelas() {
    return kelas;
    }

    public void setKelas(Kelas kelas) {
        this.kelas = kelas;
    }

    public String getIdKelas() {
        return kelas != null
                ? kelas.getIdKelas()
                : null;
    }

    public void setIdKelas(String idKelas) {
        this.kelas = new Kelas();
        this.kelas.setIdKelas(idKelas);
    }

    public Long getIdTahunAjaran() {
        return tahunAjaran != null ? tahunAjaran.getIdTahunAjaran() : null;
    }

    public void setIdTahunAjaran(Long idTahunAjaran) {
        this.tahunAjaran = new TahunAjaran();
        this.tahunAjaran.setIdTahunAjaran(idTahunAjaran);
    }

    // 🔥 TAMBAHAN WAJIB
    public Long getIdStatus() {
        return status != null ? status.getIdStatus() : null;
    }

    public void setIdStatus(Long idStatus) {
        this.status = new StatusAbsensi();
        this.status.setIdStatus(idStatus);
    }
}
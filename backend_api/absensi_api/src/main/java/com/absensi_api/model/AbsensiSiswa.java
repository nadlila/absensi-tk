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

    @Column(name = "id_kelas")
    private String idKelas;

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

    public String getIdKelas() {
    return idKelas;
    }

    public void setIdKelas(String idKelas) {
        this.idKelas = idKelas;
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
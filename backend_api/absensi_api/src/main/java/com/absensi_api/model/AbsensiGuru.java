package com.absensi_api.model;

import jakarta.persistence.*;
import java.time.LocalDate;


@Entity
@Table(name = "absensi_guru")
public class AbsensiGuru {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idAbsensiGuru;

    @ManyToOne
    @JoinColumn(name = "id_guru")
    private Guru guru;

    private LocalDate tanggal;

    @ManyToOne
    @JoinColumn(name = "id_status")
    private StatusAbsensi status;

    @ManyToOne
    @JoinColumn(name = "id_tahun_ajaran")
    private TahunAjaran tahunAjaran;

    public Long getIdAbsensi() {
        return idAbsensiGuru;
    }

    public void setIdAbsensi(Long idAbsensi) {
        this.idAbsensiGuru = idAbsensi;
    }

    public Guru getGuru() {
        return guru;
    }

    public void setGuru(Guru guru) {
        this.guru = guru;
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
    public TahunAjaran getTahunAjaran() {
    return tahunAjaran;
    }

    public void setTahunAjaran(TahunAjaran tahunAjaran) {
        this.tahunAjaran = tahunAjaran;
    }

    public Long getIdTahunAjaran() {
        return tahunAjaran != null
                ? tahunAjaran.getIdTahunAjaran()
                : null;
    }

    public void setIdTahunAjaran(Long idTahunAjaran) {
        this.tahunAjaran = new TahunAjaran();
        this.tahunAjaran.setIdTahunAjaran(idTahunAjaran);
    }

    public Long getIdStatus() {
        return status != null
                ? status.getIdStatus()
                : null;
    }

    public void setIdStatus(Long idStatus) {
        this.status = new StatusAbsensi();
        this.status.setIdStatus(idStatus);
    }
}
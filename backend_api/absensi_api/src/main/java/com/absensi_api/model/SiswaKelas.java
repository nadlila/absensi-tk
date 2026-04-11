package com.absensi_api.model;

import jakarta.persistence.*;

@Entity
@Table(name = "siswa_kelas")
public class SiswaKelas {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idSiswaKelas;

    private Long idSiswa;

    private String idKelas;

    private Long idTahunAjaran;

    public Long getIdSiswaKelas() {
        return idSiswaKelas;
    }

    public void setIdSiswaKelas(Long idSiswaKelas) {
        this.idSiswaKelas = idSiswaKelas;
    }

    public Long getIdSiswa() {
        return idSiswa;
    }

    public void setIdSiswa(Long idSiswa) {
        this.idSiswa = idSiswa;
    }

    public String getIdKelas() {
        return idKelas;
    }

    public void setIdKelas(String idKelas) {
        this.idKelas = idKelas;
    }

    public Long getIdTahunAjaran() {
        return idTahunAjaran;
    }

    public void setIdTahunAjaran(Long idTahunAjaran) {
        this.idTahunAjaran = idTahunAjaran;
    }
    
}
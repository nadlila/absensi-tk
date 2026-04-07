package com.absensi_api.model;

import jakarta.persistence.*;

@Entity
@Table(name = "siswa")
public class Siswa {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idSiswa;

    private String namaSiswa;

    private String nisn;

    @ManyToOne
    @JoinColumn(name = "id_kelas")
    private Kelas kelas;

    public Long getIdSiswa() {
        return idSiswa;
    }

    public void setIdSiswa(Long idSiswa) {
        this.idSiswa = idSiswa;
    }

    public String getNamaSiswa() {
        return namaSiswa;
    }

    public void setNamaSiswa(String namaSiswa) {
        this.namaSiswa = namaSiswa;
    }

    public String getNisn() {
        return nisn;
    }

    public void setNisn(String nisn) {
        this.nisn = nisn;
    }

    public Kelas getKelas() {
        return kelas;
    }

    public void setKelas(Kelas kelas) {
        this.kelas = kelas;
    }
}
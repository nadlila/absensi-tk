package com.absensi_api.dto;

public class SiswaDetailDTO {

    private Long idSiswa;
    private String namaSiswa;
    private String nisn;
    private String kelas;
    private String tahun;
    private String semester;

    public SiswaDetailDTO(Long idSiswa, String namaSiswa, String nisn,
                          String kelas, String tahun, String semester) {
        this.idSiswa = idSiswa;
        this.namaSiswa = namaSiswa;
        this.nisn = nisn;
        this.kelas = kelas;
        this.tahun = tahun;
        this.semester = semester;
    }

    public Long getIdSiswa() {
        return idSiswa;
    }

    public String getNamaSiswa() {
        return namaSiswa;
    }

    public String getNisn() {
        return nisn;
    }

    public String getKelas() {
        return kelas;
    }

    public String getTahun() {
        return tahun;
    }

    public String getSemester() {
        return semester;
    }
}
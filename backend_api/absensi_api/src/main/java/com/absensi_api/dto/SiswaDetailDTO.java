package com.absensi_api.dto;

public class SiswaDetailDTO {

    private Long idSiswa;
    private String namaSiswa;
    private String nisn;

    private String tempatLahir;
    private String tanggalLahir;
    private String alamat;

    private String namaKelas;
    private String tahun;
    private String semester;

    public SiswaDetailDTO(
        Long idSiswa,
        String namaSiswa,
        String nisn,
        String tempatLahir,
        String tanggalLahir,
        String alamat,
        String namaKelas,
        String tahun,
        String semester
    ) {
        this.idSiswa = idSiswa;
        this.namaSiswa = namaSiswa;
        this.nisn = nisn;
        this.tempatLahir = tempatLahir;
        this.tanggalLahir = tanggalLahir;
        this.alamat = alamat;
        this.namaKelas = namaKelas;
        this.tahun = tahun;
        this.semester = semester;
    }

    // GETTER
    public Long getIdSiswa() { return idSiswa; }
    public String getNamaSiswa() { return namaSiswa; }
    public String getNisn() { return nisn; }

    public String getTempatLahir() { return tempatLahir; }
    public String getTanggalLahir() { return tanggalLahir; }
    public String getAlamat() { return alamat; }

    public String getNamaKelas() { return namaKelas; }
    public String getTahun() { return tahun; }
    public String getSemester() { return semester; }
}
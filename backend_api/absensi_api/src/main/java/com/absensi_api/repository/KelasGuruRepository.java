package com.absensi_api.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.absensi_api.dto.KelasDetailDTO;
import com.absensi_api.model.KelasGuru;
import com.absensi_api.model.TahunAjaran;

import java.util.List;

public interface KelasGuruRepository extends JpaRepository<KelasGuru, Long> {

    // =========================
    // BASIC QUERY METHODS
    // =========================
    boolean existsByIdKelasAndIdTahunAjaran(String idKelas, Long idTahunAjaran);

    void deleteByIdKelasAndIdTahunAjaran(String idKelas, Long idTahunAjaran);

    List<KelasGuru> findByIdKelas(String idKelas);

    List<KelasGuru> findByIdGuru(Long idGuru);

    List<KelasGuru> findByIdTahunAjaran(Long idTahunAjaran);

    // =========================
    // AMBIL TAHUN AJARAN AKTIF
    // =========================
    @Query("SELECT t FROM TahunAjaran t WHERE t.status = 'aktif'")
    TahunAjaran getTahunAktif();

    // =========================
    // DETAIL SEMUA KELAS AKTIF
    // =========================
    @Query("""
    SELECT new com.absensi_api.dto.KelasDetailDTO(
        kg.id,
        k.idKelas,
        k.namaKelas,
        g.namaGuru,
        t.tahun,
        t.semester,
        g.idGuru,
        kg.idTahunAjaran
    )
    FROM KelasGuru kg
    JOIN Kelas k ON kg.idKelas = k.idKelas
    JOIN Guru g ON kg.idGuru = g.idGuru
    JOIN TahunAjaran t ON kg.idTahunAjaran = t.idTahunAjaran
    WHERE t.status = 'aktif'
    """)
    List<KelasDetailDTO> getDetailKelasAktif();

    // =========================
    // DETAIL PER GURU
    // =========================
    @Query("""
    SELECT new com.absensi_api.dto.KelasDetailDTO(
        kg.id,
        k.idKelas,
        k.namaKelas,
        g.namaGuru,
        t.tahun,
        t.semester,
        g.idGuru,
        kg.idTahunAjaran
    )
    FROM KelasGuru kg
    JOIN Kelas k ON kg.idKelas = k.idKelas
    JOIN Guru g ON kg.idGuru = g.idGuru
    JOIN TahunAjaran t ON kg.idTahunAjaran = t.idTahunAjaran
    WHERE g.idGuru = :idGuru
    AND t.status = 'aktif'
    """)
    KelasDetailDTO getDetailKelasGuruAktif(@Param("idGuru") Long idGuru);

    // =========================
    // KELAS GURU AKTIF (FIXED)
    // =========================
    @Query("""
    SELECT kg
    FROM KelasGuru kg
    JOIN TahunAjaran t ON kg.idTahunAjaran = t.idTahunAjaran
    WHERE kg.idGuru = :idGuru
    AND t.status = 'aktif'
    """)
    List<KelasGuru> getKelasGuruAktif(@Param("idGuru") Long idGuru);

}
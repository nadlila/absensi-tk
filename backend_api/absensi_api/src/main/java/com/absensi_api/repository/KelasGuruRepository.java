package com.absensi_api.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.absensi_api.dto.KelasDetailDTO;
import com.absensi_api.model.KelasGuru;
import com.absensi_api.model.TahunAjaran;

import java.util.List;

public interface KelasGuruRepository extends JpaRepository<KelasGuru, Long> {

    boolean existsByIdKelasAndIdTahunAjaran(String idKelas, Long idTahunAjaran);
    void deleteByIdKelasAndIdTahunAjaran(String idKelas, Long idTahunAjaran);

    List<KelasGuru> findByIdKelas(String idKelas);
    List<KelasGuru> findByIdGuru(Long idGuru);
    List<KelasGuru> findByIdTahunAjaran(Long idTahunAjaran);

    // 🔥 SEMUA DATA
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
    @Query("SELECT t FROM TahunAjaran t WHERE t.status = 'aktif'")
        TahunAjaran getTahunAktif();

    // 🔥 DATA PER GURU
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

}
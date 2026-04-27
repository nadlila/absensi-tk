package com.absensi_api.repository;

import com.absensi_api.model.SiswaKelas;
import com.absensi_api.dto.SiswaDetailDTO;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.repository.query.Param;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;


public interface SiswaKelasRepository extends JpaRepository<SiswaKelas, Long> {

    List<SiswaKelas> findByIdKelas(String idKelas);

    List<SiswaKelas> findByIdTahunAjaran(Long idTahunAjaran);

    Optional<SiswaKelas> findByIdSiswaAndIdTahunAjaran(Long idSiswa, Long idTahunAjaran);

    @Modifying
    @Transactional
    @Query("DELETE FROM SiswaKelas sk WHERE sk.idSiswa = :id")
    void deleteByIdSiswa(@Param("id") Long id);

    // 🔥 DTO
    @Query("""
    SELECT new com.absensi_api.dto.SiswaDetailDTO(
    s.idSiswa,
    s.namaSiswa,
    s.nisn,
    s.tempatLahir,
    s.tanggalLahir,
    s.alamat,
    k.namaKelas,
    t.tahun,
    t.semester
    )
    FROM SiswaKelas sk
    JOIN Siswa s ON sk.idSiswa = s.idSiswa
    JOIN Kelas k ON sk.idKelas = k.idKelas
    JOIN TahunAjaran t ON sk.idTahunAjaran = t.idTahunAjaran
    """)
    List<SiswaDetailDTO> getSiswaDetail();

    @Query("""
    SELECT new com.absensi_api.dto.SiswaDetailDTO(
    s.idSiswa,
    s.namaSiswa,
    s.nisn,
    s.tempatLahir,
    s.tanggalLahir,
    s.alamat,
    k.namaKelas,
    t.tahun,
    t.semester
    )
    FROM SiswaKelas sk
    JOIN Siswa s ON sk.idSiswa = s.idSiswa
    JOIN Kelas k ON sk.idKelas = k.idKelas
    JOIN TahunAjaran t ON sk.idTahunAjaran = t.idTahunAjaran
    WHERE sk.idKelas = :idKelas
    AND sk.idTahunAjaran = :idTahun
    """)
    List<SiswaDetailDTO> getByKelasDanTahun(String idKelas, Long idTahun);
}
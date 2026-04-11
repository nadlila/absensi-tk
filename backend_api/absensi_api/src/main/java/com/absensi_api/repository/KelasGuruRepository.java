package com.absensi_api.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.absensi_api.dto.KelasDetailDTO;
import com.absensi_api.model.KelasGuru;

import java.util.List;

public interface KelasGuruRepository extends JpaRepository<KelasGuru, Long> {

    List<KelasGuru> findByIdKelas(String idKelas);

    List<KelasGuru> findByIdGuru(Long idGuru);

    List<KelasGuru> findByIdTahunAjaran(Long idTahunAjaran);

    @Query("""
SELECT new com.absensi_api.dto.KelasDetailDTO(
    k.idKelas,
    k.namaKelas,
    g.namaGuru,
    t.tahun,
    t.semester
)
FROM KelasGuru kg
JOIN Kelas k ON kg.idKelas = k.idKelas
JOIN Guru g ON kg.idGuru = g.idGuru
JOIN TahunAjaran t ON kg.idTahunAjaran = t.idTahunAjaran
WHERE t.status = 'aktif'
""")
List<KelasDetailDTO> getDetailKelasAktif();
@Query("""
SELECT kg
FROM KelasGuru kg
JOIN TahunAjaran t ON kg.idTahunAjaran = t.idTahunAjaran
WHERE kg.idGuru = :idGuru
AND t.status = 'aktif'
""")
KelasGuru getKelasGuruAktif(Long idGuru);
}
package com.absensi_api.repository;

import com.absensi_api.model.SiswaKelas;
import com.absensi_api.dto.SiswaDetailDTO;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface SiswaKelasRepository extends JpaRepository<SiswaKelas, Long> {

    List<SiswaKelas> findByIdKelas(String idKelas);

    List<SiswaKelas> findByIdTahunAjaran(Long idTahunAjaran);

    @Query("""
    SELECT new com.absensi_api.dto.SiswaDetailDTO(
    s.idSiswa,
    s.namaSiswa,
    s.nisn,
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
// @Query("""
// SELECT sk
// FROM SiswaKelas sk
// WHERE sk.idTahunAjaran = (
//     SELECT MAX(s2.idTahunAjaran)
//     FROM SiswaKelas s2
// )
// """)
// List<SiswaKelas> getSiswaTahunTerakhir();
}
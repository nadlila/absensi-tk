package com.absensi_api.repository;

import com.absensi_api.dto.SiswaDetailDTO;
import com.absensi_api.model.Siswa;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface SiswaRepository extends JpaRepository<Siswa, Long> {
    // List<Siswa> findByIdKelas(String idKelas);
    void deleteByIdSiswa(Long idSiswa);

  @Query("""
SELECT new com.absensi_api.dto.SiswaDetailDTO(
    s.idSiswa,
    s.namaSiswa,
    s.nisn,
    s.tempatLahir,
    s.tanggalLahir,
    s.alamat,
    k.namaKelas,
    ta.tahun,
    ta.semester
)
FROM SiswaKelas sk
JOIN Siswa s ON sk.idSiswa = s.idSiswa
JOIN Kelas k ON sk.idKelas = k.idKelas
JOIN TahunAjaran ta ON sk.idTahunAjaran = ta.idTahunAjaran
WHERE s.idSiswa = :id
""")
SiswaDetailDTO getDetailById(@Param("id") Long id);

}
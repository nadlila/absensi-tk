package com.absensi_api.repository;

import com.absensi_api.dto.DetailAbsensiDTO;
import com.absensi_api.dto.RekapAbsensiDTO;
import com.absensi_api.model.AbsensiSiswa;
import com.absensi_api.model.Siswa;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface AbsensiSiswaRepository extends JpaRepository<AbsensiSiswa, Long> {

    List<AbsensiSiswa> findBySiswa(Siswa siswa);
    boolean existsByIdSiswaAndTanggal(Long idSiswa, LocalDate tanggal);

    @Query("""
SELECT new com.absensi_api.dto.RekapAbsensiDTO(
    s.idSiswa,
    s.namaSiswa,

    SUM(CASE WHEN st.namaStatus = 'Hadir' THEN 1 ELSE 0 END),
    SUM(CASE WHEN st.namaStatus = 'Izin' THEN 1 ELSE 0 END),
    SUM(CASE WHEN st.namaStatus = 'Sakit' THEN 1 ELSE 0 END),
    SUM(CASE WHEN st.namaStatus = 'Alfa' THEN 1 ELSE 0 END)

)
FROM AbsensiSiswa a
JOIN a.siswa s
JOIN a.status st
WHERE a.tanggal BETWEEN :start AND :end
AND a.idKelas = :idKelas
GROUP BY s.idSiswa, s.namaSiswa
""")
List<RekapAbsensiDTO> getRekap(
    @Param("idKelas") String idKelas,
    @Param("start") LocalDate start,
    @Param("end") LocalDate end
);

@Query("""
SELECT new com.absensi_api.dto.DetailAbsensiDTO(
    a.tanggal,
    st.namaStatus,
    a.keterangan
)
FROM AbsensiSiswa a
JOIN a.status st
WHERE a.siswa.idSiswa = :idSiswa
AND a.tahunAjaran.idTahunAjaran = :idTahun
ORDER BY a.tanggal DESC
""")
List<DetailAbsensiDTO> getDetailSiswa(
    @Param("idSiswa") Long idSiswa,
    @Param("idTahun") Long idTahun
);

}

 
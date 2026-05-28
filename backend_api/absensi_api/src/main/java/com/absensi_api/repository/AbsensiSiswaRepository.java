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

public interface AbsensiSiswaRepository extends JpaRepository<AbsensiSiswa, java.lang.Long> {

    java.util.List<AbsensiSiswa> findBySiswa(Siswa siswa);

    java.util.List<AbsensiSiswa> findByKelas_IdKelasAndTanggal(java.lang.String idKelas, LocalDate tanggal);

    boolean existsBySiswa_IdSiswaAndTanggal(java.lang.Long idSiswa, LocalDate tanggal);

    boolean existsByKelas_IdKelasAndTanggal(java.lang.String idKelas, LocalDate tanggal);

    @Query("""
    SELECT new com.absensi_api.dto.RekapAbsensiDTO(
        s.idSiswa,
        s.namaSiswa,
        SUM(CASE WHEN st.namaStatus = 'Hadir' THEN 1 ELSE 0 END),
        SUM(CASE WHEN st.namaStatus = 'Izin' THEN 1 ELSE 0 END),
        SUM(CASE WHEN st.namaStatus = 'Sakit' THEN 1 ELSE 0 END),
        SUM(CASE WHEN st.namaStatus = 'Alpa' THEN 1 ELSE 0 END)
    )
    FROM AbsensiSiswa a
    JOIN a.siswa s
    JOIN a.status st
    WHERE a.kelas.idKelas = :idKelas
    AND a.tahunAjaran.idTahunAjaran = :idTahun
    GROUP BY s.idSiswa, s.namaSiswa
    """)
    java.util.List<RekapAbsensiDTO> getRekapByTahun(
            @Param("idKelas") java.lang.String idKelas,
            @Param("idTahun") java.lang.Long idTahun
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
    java.util.List<DetailAbsensiDTO> getDetailSiswa(
            @Param("idSiswa") java.lang.Long idSiswa,
            @Param("idTahun") java.lang.Long idTahun
    );

    @Query("""
        SELECT new com.absensi_api.dto.DetailAbsensiDTO(
            a.tanggal,
            a.status.namaStatus,
            a.keterangan
        )
        FROM AbsensiSiswa a
        WHERE a.siswa.idSiswa = :idSiswa
        AND a.tanggal BETWEEN :start AND :end
        ORDER BY a.tanggal ASC
    """)
    java.util.List<DetailAbsensiDTO> getDetailByTanggal(
            @Param("idSiswa") java.lang.Long idSiswa,
            @Param("start") LocalDate start,
            @Param("end") LocalDate end
    );

    @Query("SELECT a.status.namaStatus, COUNT(a) FROM AbsensiSiswa a " +
            "WHERE a.kelas.idKelas = :idKelas AND a.tanggal = :tanggal " +
            "GROUP BY a.status.namaStatus")
    java.util.List<java.lang.Object[]> countStatusByKelasAndTanggal(
            @Param("idKelas") java.lang.String idKelas,
            @Param("tanggal") LocalDate tanggal
    );
}
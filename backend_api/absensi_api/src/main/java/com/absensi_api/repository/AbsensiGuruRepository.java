package com.absensi_api.repository;

import com.absensi_api.dto.RekapGuruDTO;
import com.absensi_api.model.AbsensiGuru;
import com.absensi_api.model.Guru;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface AbsensiGuruRepository
        extends JpaRepository<AbsensiGuru, Long> {

    List<AbsensiGuru> findByGuru(Guru guru);

    boolean existsByGuruAndTanggal(
        Guru guru,
        LocalDate tanggal
    );

    List<AbsensiGuru> findByTahunAjaran_IdTahunAjaran(
            Long idTahunAjaran
    );

    @Query("""
    SELECT new com.absensi_api.dto.RekapGuruDTO(

        g.idGuru,
        g.namaGuru,

        SUM(CASE WHEN st.namaStatus = 'Hadir' THEN 1 ELSE 0 END),
        SUM(CASE WHEN st.namaStatus = 'Izin' THEN 1 ELSE 0 END),
        SUM(CASE WHEN st.namaStatus = 'Sakit' THEN 1 ELSE 0 END),
        SUM(CASE WHEN st.namaStatus = 'Alfa' THEN 1 ELSE 0 END)

    )
    FROM AbsensiGuru a
    JOIN a.guru g
    JOIN a.status st

    WHERE a.tahunAjaran.idTahunAjaran = :idTahun

    GROUP BY g.idGuru, g.namaGuru
""")
    List<RekapGuruDTO> getRekapGuru(
            @Param("idTahun") Long idTahun
    );
}
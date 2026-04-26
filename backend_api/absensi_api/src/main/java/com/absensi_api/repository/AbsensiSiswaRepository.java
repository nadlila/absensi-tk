package com.absensi_api.repository;

import com.absensi_api.model.AbsensiSiswa;
import com.absensi_api.model.Siswa;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.List;

public interface AbsensiSiswaRepository extends JpaRepository<AbsensiSiswa, Long> {

    List<AbsensiSiswa> findBySiswa(Siswa siswa);
    boolean existsByIdSiswaAndTanggal(Long idSiswa, LocalDate tanggal);

}


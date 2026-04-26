package com.absensi_api.repository;

import com.absensi_api.model.Siswa;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SiswaRepository extends JpaRepository<Siswa, Long> {
    // List<Siswa> findByIdKelas(String idKelas);
    void deleteByIdSiswa(Long idSiswa);

}
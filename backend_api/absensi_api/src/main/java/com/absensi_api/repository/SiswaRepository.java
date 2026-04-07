package com.absensi_api.repository;

import com.absensi_api.model.Siswa;
import com.absensi_api.model.Kelas;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface SiswaRepository extends JpaRepository<Siswa, Long> {

    List<Siswa> findByKelas(Kelas kelas);

}
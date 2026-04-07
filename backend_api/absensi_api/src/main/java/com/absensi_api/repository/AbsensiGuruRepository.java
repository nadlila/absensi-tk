package com.absensi_api.repository;

import com.absensi_api.model.AbsensiGuru;
import com.absensi_api.model.Guru;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AbsensiGuruRepository extends JpaRepository<AbsensiGuru, Long> {

    List<AbsensiGuru> findByGuru(Guru guru);

}
package com.absensi_api.repository;

import com.absensi_api.model.HariLibur;
import org.springframework.data.jpa.repository.JpaRepository;
import java.time.LocalDate;

public interface HariLiburRepository extends JpaRepository<HariLibur, Long> {
    boolean existsByTanggal(LocalDate tanggal);
}

package com.absensi_api.repository;

import com.absensi_api.model.StatusAbsensi;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StatusAbsensiRepository extends JpaRepository<StatusAbsensi, Long> {
}
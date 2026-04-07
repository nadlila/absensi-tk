package com.absensi_api.repository;

import com.absensi_api.model.Guru;
import org.springframework.data.jpa.repository.JpaRepository;

public interface GuruRepository extends JpaRepository<Guru, Long> {
}
package com.absensi_api.repository;

import com.absensi_api.model.TahunAjaran;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TahunAjaranRepository extends JpaRepository<TahunAjaran, Long> {

    TahunAjaran findByStatus(String status);

}
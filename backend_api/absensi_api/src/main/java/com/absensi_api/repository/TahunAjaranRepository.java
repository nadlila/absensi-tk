package com.absensi_api.repository;

import com.absensi_api.model.TahunAjaran;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface TahunAjaranRepository extends JpaRepository<TahunAjaran, Long> {

    Optional<TahunAjaran> findByStatus(String status);

}

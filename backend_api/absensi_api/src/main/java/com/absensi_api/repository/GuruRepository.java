package com.absensi_api.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.absensi_api.model.Guru;

public interface GuruRepository extends JpaRepository<Guru, Long> {

    Guru findByIdUser(Long idUser);

}
package com.absensi_api.repository;

import com.absensi_api.model.Notifikasi;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface NotifikasiRepository extends JpaRepository<Notifikasi, Long> {
    List<Notifikasi> findByIdUserOrderByWaktuDesc(Long idUser);
}

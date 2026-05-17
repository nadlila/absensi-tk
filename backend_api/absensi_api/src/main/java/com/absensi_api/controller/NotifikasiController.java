package com.absensi_api.controller;

import com.absensi_api.model.Notifikasi;
import com.absensi_api.repository.NotifikasiRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/notifikasi")
@CrossOrigin
public class NotifikasiController {

    @Autowired
    private NotifikasiRepository notifikasiRepository;

    @GetMapping("/user/{idUser}")
    public List<Notifikasi> getByUser(@PathVariable Long idUser) {
        return notifikasiRepository.findByIdUserOrderByWaktuDesc(idUser);
    }

    @PutMapping("/read-all/{idUser}")
    public void readAll(@PathVariable Long idUser) {
        List<Notifikasi> list = notifikasiRepository.findByIdUserOrderByWaktuDesc(idUser);
        for (Notifikasi n : list) {
            if (!n.isDibaca()) {
                n.setDibaca(true);
                notifikasiRepository.save(n);
            }
        }
    }

    @PutMapping("/read/{id}")
    public void markAsRead(@PathVariable Long id) {
        notifikasiRepository.findById(id).ifPresent(n -> {
            n.setDibaca(true);
            notifikasiRepository.save(n);
        });
    }
}

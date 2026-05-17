package com.absensi_api.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
public class Notifikasi {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Long idUser; // Ke siapa notif ini ditujukan (null jika untuk semua/admin)
    private String judul;
    private String isi;
    private LocalDateTime waktu;
    private boolean dibaca = false;

    // Getter dan Setter...
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getIdUser() { return idUser; }
    public void setIdUser(Long idUser) { this.idUser = idUser; }
    public String getJudul() { return judul; }
    public void setJudul(String judul) { this.judul = judul; }
    public String getIsi() { return isi; }
    public void setIsi(String isi) { this.isi = isi; }
    public LocalDateTime getWaktu() { return waktu; }
    public void setWaktu(LocalDateTime waktu) { this.waktu = waktu; }
    public boolean isDibaca() { return dibaca; }
    public void setDibaca(boolean dibaca) { this.dibaca = dibaca; }
}

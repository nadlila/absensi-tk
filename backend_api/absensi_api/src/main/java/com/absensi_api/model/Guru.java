package com.absensi_api.model;

import jakarta.persistence.*;

@Entity
@Table(name = "guru")
public class Guru {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idGuru;

    private String namaGuru;

    private String nip;

    @OneToOne
    @JoinColumn(name = "id_user")
    private User user;

    public Long getIdGuru() {
        return idGuru;
    }

    public void setIdGuru(Long idGuru) {
        this.idGuru = idGuru;
    }

    public String getNamaGuru() {
        return namaGuru;
    }

    public void setNamaGuru(String namaGuru) {
        this.namaGuru = namaGuru;
    }

    public String getNip() {
        return nip;
    }

    public void setNip(String nip) {
        this.nip = nip;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
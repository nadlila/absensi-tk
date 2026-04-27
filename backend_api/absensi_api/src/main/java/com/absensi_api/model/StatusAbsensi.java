package com.absensi_api.model;

import jakarta.persistence.*;

@Entity
@Table(name = "status_absensi")
public class StatusAbsensi {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idStatus;

    private String namaStatus;

    public Long getIdStatus() {
        return idStatus;
    }

    public void setIdStatus(Long idStatus) {
        this.idStatus = idStatus;
    }

    public String getNamaStatus() {
        return namaStatus;
    }

    public void setNamaStatus(String namaStatus) {
        this.namaStatus = namaStatus;
    }
}
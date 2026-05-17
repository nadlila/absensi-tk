package com.absensi_api.service;

import com.absensi_api.model.*;
import com.absensi_api.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

@Component
public class AbsensiService {

    @Autowired
    private GuruRepository guruRepository;
    @Autowired
    private AbsensiGuruRepository absensiGuruRepository;
    @Autowired
    private AbsensiSiswaRepository absensiSiswaRepository;
    @Autowired
    private KelasGuruRepository kelasGuruRepository;
    @Autowired
    private TahunAjaranRepository tahunRepo;
    @Autowired
    private StatusAbsensiRepository statusRepo;
    @Autowired
    private HariLiburRepository hariLiburRepository;
    @Autowired
    private NotifikasiRepository notifikasiRepository;

    // 1. PENGINGAT ABSEN GURU (Setiap Jam 07:31)
    @Scheduled(cron = "0 31 7 * * MON-SAT")
    public void notifGuruBelumAbsen() {
        LocalDate today = LocalDate.now();
        if (hariLiburRepository.existsByTanggal(today)) return;

        List<Guru> allGuru = guruRepository.findAll();
        for (Guru guru : allGuru) {
            if (!absensiGuruRepository.existsByGuruAndTanggal(guru, today)) {
                sendNotif(guru.getIdUser(), "Peringatan Absensi",
                        "Anda belum melakukan absensi hari ini. Silakan segera absen sebelum jam 11:00.");
            }
        }
    }

    // 2. PENGINGAT ABSEN SISWA (Setiap Jam 11:01)
    @Scheduled(cron = "0 1 11 * * MON-SAT")
    public void notifWaliKelasBelumAbsenSiswa() {
        LocalDate today = LocalDate.now();
        if (hariLiburRepository.existsByTanggal(today)) return;

        TahunAjaran tahunAktif = tahunRepo.findByStatus("aktif").orElse(null);
        if (tahunAktif == null) return;

        List<KelasGuru> listKelas = kelasGuruRepository.findByIdTahunAjaran(tahunAktif.getIdTahunAjaran());
        for (KelasGuru kg : listKelas) {
            boolean sudahAbsen = absensiSiswaRepository.existsByKelas_IdKelasAndTanggal(kg.getIdKelas(), today);

            if (!sudahAbsen) {
                Guru guru = guruRepository.findById(kg.getIdGuru()).orElse(null);
                if (guru != null && guru.getIdUser() != null) {
                    sendNotif(guru.getIdUser(), "Peringatan Absensi Siswa",
                            "Anda belum mengabsen siswa hari ini untuk kelas " + kg.getIdKelas() + ".");
                    sendNotif(1L, "Laporan Kelas", "Kelas " + kg.getIdKelas() + " belum melakukan absensi.");
                    }
                }
            }
        }
    }

    //3. Proses Otomatis Alpha setiap hari jam 11:05
    @Scheduled(cron = "0 5 11 * * MON-SAT")
    public void prosesOtomatisAlfa() {
        LocalDate hariIni = LocalDate.now();

        // 1. Cek Libur
        if (hariLiburRepository.existsByTanggal(hariIni)) {
            System.out.println("Sistem: Hari ini libur, proses Alpha dibatalkan.");
            return;
        }

        // 2. Ambil Tahun Ajaran Aktif
        TahunAjaran tahunAktif = tahunRepo.findByStatus("aktif").orElse(null);
        if (tahunAktif == null) return;

        // 3. Ambil Status "Alfa" (Asumsi ID 4 adalah Alfa)
        StatusAbsensi statusAlfa = statusRepo.findById(4L).orElse(null);
        if (statusAlfa == null) return;

        // 4. Ambil semua Guru & Proses
        List<Guru> allGuru = guruRepository.findAll();
        for (Guru guru : allGuru) {
            boolean sudahAbsen = absensiGuruRepository.existsByGuruAndTanggal(guru, hariIni);

            if (!sudahAbsen) {
                AbsensiGuru alfaRecord = new AbsensiGuru();
                alfaRecord.setGuru(guru);
                alfaRecord.setTanggal(hariIni);
                alfaRecord.setJam(LocalTime.of(11, 0));
                alfaRecord.setStatus(statusAlfa);
                alfaRecord.setTahunAjaran(tahunAktif);
                alfaRecord.setKeterangan("Otomatis oleh Sistem");

                absensiGuruRepository.save(alfaRecord);
                System.out.println("Sistem: Guru " + guru.getNamaGuru() + " diset ALFA.");
            }
        }
    }

    // Helper untuk simpan notifikasi
    private void sendNotif(Long idUser, String judul, String isi) {
        if (idUser == null) return;
        Notifikasi n = new Notifikasi();
        n.setIdUser(idUser);
        n.setJudul(judul);
        n.setIsi(isi);
        n.setWaktu(LocalDateTime.now());
        n.setDibaca(false);
        notifikasiRepository.save(n);
    }
}

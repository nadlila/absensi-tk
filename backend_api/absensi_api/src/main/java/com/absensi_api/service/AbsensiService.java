package com.absensi_api.service;

import com.absensi_api.model.*;
import com.absensi_api.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;

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

    @EventListener(ApplicationReadyEvent.class)
    public void runOnStartup() {
        System.out.println("Sistem: Menjalankan pengecekan otomatis saat startup...");
        notifGuruBelumAbsen(); // Pengingat Guru (Hadir/Alfa)
        notifWaliKelasBelumAbsenSiswa(); // Pengingat Absen Siswa
        prosesOtomatisAlfa(); // Eksekusi Alfa jika sudah lewat batas
    }

    // 1. PENGINGAT ABSEN GURU (Setiap Jam 07:31)
    @Scheduled(cron = "0 31 7 * * MON-SAT")
    public void notifGuruBelumAbsen() {
        LocalDate today = LocalDate.now();
        if (hariLiburRepository.existsByTanggal(today)) return;

        List<Guru> allGuru = guruRepository.findAll();
        for (Guru guru : allGuru) {
            if (!absensiGuruRepository.existsByGuruAndTanggal(guru, today)) {
                sendNotif(guru.getIdUser(), "Peringatan Absensi Diri",
                        "Anda belum melakukan absensi hari ini. Silakan segera absen.");
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
                // Notif ke Wali Kelas
                Guru guru = guruRepository.findById(kg.getIdGuru()).orElse(null);
                if (guru != null && guru.getIdUser() != null) {
                    sendNotif(guru.getIdUser(), "Peringatan Absensi Siswa",
                            "Anda belum mengabsen siswa hari ini untuk kelas " + kg.getIdKelas() + ".");
                }
                // Notif ke Admin (User ID 1)
                sendNotif(1L, "Laporan Absensi Kelas", "Kelas " + kg.getIdKelas() + " belum melakukan absensi siswa hari ini.");
            }
        }
    }

    // 3. Proses Otomatis Alpha (Jam 08:35)
    @Scheduled(cron = "0 35 8 * * MON-SAT")
    public void prosesOtomatisAlfa() {
        LocalDate hariIni = LocalDate.now();
        if (hariLiburRepository.existsByTanggal(hariIni)) return;

        TahunAjaran tahunAktif = tahunRepo.findByStatus("aktif").orElse(null);
        if (tahunAktif == null) return;

        StatusAbsensi statusAlfa = statusRepo.findById(4L).orElse(null);
        if (statusAlfa == null) return;

        List<Guru> allGuru = guruRepository.findAll();
        for (Guru guru : allGuru) {
            boolean sudahAbsen = absensiGuruRepository.existsByGuruAndTanggal(guru, hariIni);
            if (!sudahAbsen) {
                AbsensiGuru alfaRecord = new AbsensiGuru();
                alfaRecord.setGuru(guru);
                alfaRecord.setTanggal(hariIni);
                alfaRecord.setJam(LocalTime.of(8, 30));
                alfaRecord.setStatus(statusAlfa);
                alfaRecord.setTahunAjaran(tahunAktif);
                alfaRecord.setKeterangan("Otomatis Alfa oleh Sistem");
                absensiGuruRepository.save(alfaRecord);
                
                sendNotif(guru.getIdUser(), "Sistem Absensi", "Batas waktu berakhir. Anda dicatat 'Alfa' hari ini.");
            }
        }
    }

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

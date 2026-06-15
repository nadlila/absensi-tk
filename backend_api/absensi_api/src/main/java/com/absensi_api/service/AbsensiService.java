package com.absensi_api.service;

import com.absensi_api.model.*;
import com.absensi_api.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;

import java.time.DayOfWeek;
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
        LocalDate today = LocalDate.now();
        LocalTime now = LocalTime.now();

        System.out.println("Sistem: Menjalankan pengecekan otomatis saat startup...");

        for (int i = 0; i <= 7; i++) {
            LocalDate checkDate = today.minusDays(i);

            // Lewati jika hari Minggu atau hari Libur terdaftar
            if (isLiburAtauMinggu(checkDate)) {
                continue;
            }

            // Jika mengecek hari ini, pastikan sudah lewat jam batas (08:35)
            if (checkDate.equals(today)) {
                if (now.isAfter(LocalTime.of(8, 35))) {
                    prosesOtomatisAlfaPerTanggal(checkDate, false);
                }
            } else {
                // Untuk hari-hari sebelumnya, langsung proses Alpa jika belum ada catatan
                prosesOtomatisAlfaPerTanggal(checkDate, false);
            }
        }

        if (isLiburAtauMinggu(today)) {
            System.out.println("Sistem: Hari ini libur atau Minggu. Melewati notifikasi harian.");
            return;
        }

        if (now.isAfter(LocalTime.of(7, 31))) {
            notifGuruBelumAbsen();
        }

        if (now.isAfter(LocalTime.of(11, 1))) {
            notifWaliKelasBelumAbsenSiswa();
        }
    }

    private boolean isLiburAtauMinggu(LocalDate date) {
        if (date.getDayOfWeek() == DayOfWeek.SUNDAY) return true;
        return hariLiburRepository.existsByTanggal(date);
    }

    @Scheduled(cron = "0 31 7 * * MON-SAT")
    public void notifGuruBelumAbsen() {
        LocalDate today = LocalDate.now();
        if (isLiburAtauMinggu(today)) return;

        java.util.List<Guru> allGuru = guruRepository.findAll();
        for (Guru guru : allGuru) {
            if (!absensiGuruRepository.existsByGuruAndTanggal(guru, today)) {
                sendNotif(guru.getIdUser(), "Peringatan Absensi Diri",
                        "Anda belum melakukan absensi hari ini. Silakan segera absen.");
            }
        }
    }

    @Scheduled(cron = "0 1 11 * * MON-SAT")
    public void notifWaliKelasBelumAbsenSiswa() {
        LocalDate today = LocalDate.now();
        if (isLiburAtauMinggu(today)) return;

        TahunAjaran tahunAktif = tahunRepo.findByStatus("aktif").orElse(null);
        if (tahunAktif == null) return;

        java.util.List<KelasGuru> listKelas = kelasGuruRepository.findByIdTahunAjaran(tahunAktif.getIdTahunAjaran());
        for (KelasGuru kg : listKelas) {
            boolean sudahAbsen = absensiSiswaRepository.existsByKelas_IdKelasAndTanggal(kg.getIdKelas(), today);

            if (!sudahAbsen) {
                Guru guru = guruRepository.findById(kg.getIdGuru()).orElse(null);
                if (guru != null && guru.getIdUser() != null) {
                    sendNotif(guru.getIdUser(), "Peringatan Absensi Siswa",
                            "Anda belum mengabsen siswa hari ini untuk kelas " + kg.getIdKelas() + ".");
                }
                sendNotif(1L, "Laporan Absensi Kelas", "Kelas " + kg.getIdKelas() + " belum melakukan absensi siswa hari ini.");
            }
        }
    }

    @Scheduled(cron = "0 35 8 * * MON-SAT")
    public void prosesOtomatisAlfa() {
        prosesOtomatisAlfaPerTanggal(LocalDate.now(), true);
    }

    public void prosesOtomatisAlfaPerTanggal(LocalDate tanggal, boolean kirimNotif) {
        if (isLiburAtauMinggu(tanggal)) return;

        TahunAjaran tahunAktif = tahunRepo.findByStatus("aktif").orElse(null);
        if (tahunAktif == null) return;

        StatusAbsensi statusAlpa = statusRepo.findById(4L).orElse(null);
        if (statusAlpa == null) return;

        java.util.List<Guru> allGuru = guruRepository.findAll();
        for (Guru guru : allGuru) {
            boolean sudahAdaCatatan = absensiGuruRepository.existsByGuruAndTanggal(guru, tanggal);
            if (!sudahAdaCatatan) {
                AbsensiGuru alpaRecord = new AbsensiGuru();
                alpaRecord.setGuru(guru);
                alpaRecord.setTanggal(tanggal);
                alpaRecord.setJam(LocalTime.of(8, 30));
                alpaRecord.setStatus(statusAlpa);
                alpaRecord.setTahunAjaran(tahunAktif);
                alpaRecord.setKeterangan("Otomatis Alpa oleh Sistem");
                absensiGuruRepository.save(alpaRecord);

                if (kirimNotif && guru.getIdUser() != null) {
                    sendNotif(guru.getIdUser(), "Sistem Absensi", "Batas waktu berakhir. Anda dicatat 'Alpa' hari ini.");
                }
            }
        }
    }

    private void sendNotif(java.lang.Long idUser, java.lang.String judul, java.lang.String isi) {
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
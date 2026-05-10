class AppRoutes {

  static const String login = "/login";
  static const String dashboard = "/dashboard";

  // ================= ADMIN =================
  static const String adminDashboard = "/admin/dashboard";

  // ADMIN - GURU
  static const String dataGuru = "/admin/guru";
  static const String tambahGuru = "/admin/guru/tambah";
  static const String detailGuru = "/admin/guru/detail";
  static const String editGuru = "/admin/guru/edit";

  // ADMIN - SISWA
  static const String dataSiswaAdmin = "/admin/siswa";
  static const String detailSiswaAdmin = "/admin/siswa/detail";
  static const String tambahSiswa = "/admin/siswa/tambah";
  static const String editSiswa = "/admin/siswa/edit";
  static const String mutasiSiswa = "/admin/siswa/mutasi";

  // ADMIN - KELAS
  static const String dataKelas = "/admin/kelas";
  static const String detailKelas = "/admin/kelas/detail";
  static const String editWaliKelas = "/admin/kelas/edit-wali";
  static const String setupKelasTahun = "/admin/kelas/setup-tahun";
  static const String tambahKelas = "/admin/kelas/tambah";

  // ADMIN - REKAP
  static const String rekapAbsensi = "/admin/rekap";
  static const String rekapGuruAdmin = "/admin/rekap/guru";
  static const String rekapSiswaAdmin = "/admin/rekap/siswa";

  // ADMIN - USER
  static const String kelolaUser = "/admin/user";

  // ADMIN - TAHUN AJARAN
  static const String tahunAjaran = "/admin/tahun-ajaran";
  static const String tambahTahunAjaran = "/admin/tahun-ajaran/tambah";

  // ================= GURU =================
  static const String absenGuru = "/guru/absen";
   static const String menuGuru = "/guru/menu";
  static const String rekapAbsenGuru = "/guru/rekap";

  // ================= SISWA (GURU VIEW) =================
  static const String menuSiswa = "/siswa/menu";
  static const String absenSiswa = "/siswa/absen";
  static const String rekapSiswa = "/siswa/rekap";

  static const String dataSiswaGuru = "/siswa/data";          // list
  static const String detailDataSiswa = "/siswa/detail";      // biodata
  static const String detailAbsensiSiswa = "/siswa/histori";  // histori
  static const String detailRekapSiswa = "/siswa/rekap/detail";

  // ================= UMUM =================
  static const String profil = "/profil";
  static const String notifikasi = "/notifikasi";
}
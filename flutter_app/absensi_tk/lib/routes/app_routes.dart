class AppRoutes {

  static const String login = "/login";
  static const String dashboard = "/dashboard";

  // ADMIN
static const String adminDashboard = "/admin/dashboard";

// ADMIN - GURU
static const String dataGuru = "/admin/guru";
static const String tambahGuru = "/admin/guru/tambah-guru";
static const String detailGuru = "/admin/guru/detail-guru";
static const String editGuru = "/admin/guru/edit";

// ADMIN - SISWA
static const String dataSiswa = "/admin/siswa";
static const String detailSiswa = "/admin/siswa/detail";
static const String tambahSiswa = "/admin/siswa/tambah";
static const String editSiswa = "/admin/siswa/edit";
static const String mutasiSiswa = "/admin/siswa/mutasi";

// ADMIN - KELAS
static const String dataKelas = "/admin/kelas";
static const String detailKelas = "/admin/kelas/detail";
static const String editWaliKelas = "/admin/kelas/edit-wali";

// ADMIN - REKAP
static const String rekapAbsensi = "/admin/rekap";

// ADMIN - USER
static const String kelolaUser = "/admin/user";

// ADMIN - TAHUN AJARAN
static const String tahunAjaran = "/admin/tahun-ajaran";
static const String tambahTahunAjaran ="/admin/tahun-ajaran/tambah";

  // GURU
  static const String absenGuru = "/absen-guru";
  static const String rekapAbsenGuru = "/rekap-absen-guru";

  // SISWA
  static const String absenSiswa = "/absen-siswa";
  static const String rekapAbsenSiswa = "/rekap-absen-siswa";

  // UMUM
  static const String profil = "/profil";
  static const String notifikasi = "/notifikasi";

}
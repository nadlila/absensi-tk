import 'package:flutter/material.dart';

import '../models/guru_model.dart';

import '../screens/auth/login_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';

import '../screens/admin/admin_dashboard.dart';

//Admin - Guru
import '../screens/admin/guru/data_guru_screen.dart';
import '../screens/admin/guru/tambah_guru_screen.dart';
import '../screens/admin/guru/detail_guru_screen.dart';
import '../screens/admin/guru/edit_guru_screen.dart';

//Admin - Siswa
import '../screens/admin/siswa/data_siswa_screen.dart';
import '../models/siswa_detail_model.dart';
import '../screens/admin/siswa/detail_siswa_screen.dart';
import '../screens/admin/siswa/tambah_siswa_screen.dart';
import '../screens/admin/siswa/edit_siswa_screen.dart';
import '../screens/admin/siswa/mutasi_siswa_screen.dart';

//Admin - Kelas
import '../screens/admin/kelas/data_kelas_screen.dart';
import '../screens/admin/kelas/detail_kelas_screen.dart';
import '../screens/admin/kelas/edit_wali_kelas_screen.dart';
import '../models/kelas_detail_model.dart';

// Admin - Tahun Ajaran
import '../screens/admin/tahun_ajaran/tahun_ajaran_screen.dart';
import '../screens/admin/tahun_ajaran/tambah_tahun_ajaran_screen.dart';

//Admin - Rekap
import '../screens/admin/rekap/rekap_absensi_screen.dart';

//Admin - User
import '../screens/admin/user/kelola_user_screen.dart';

import '../screens/guru/absen_guru_screen.dart';
import '../screens/guru/rekap_absen_guru_screen.dart';

import '../screens/siswa/absen_siswa_screen.dart';
import '../screens/siswa/rekap_absen_siswa_screen.dart';

import '../screens/profil/profil_screen.dart';
import '../screens/notifikasi/notifikasi_screen.dart';

import 'app_routes.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case AppRoutes.dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());

//Admin
      case AppRoutes.adminDashboard:
        return MaterialPageRoute(builder: (_) => const AdminDashboard());

//Admin - Guru
      case AppRoutes.dataGuru:
        return MaterialPageRoute(builder: (_) => const DataGuruScreen());

      case AppRoutes.tambahGuru:
        return MaterialPageRoute(builder: (_) => const TambahGuruScreen());

      case AppRoutes.detailGuru:

        final args = settings.arguments;

        if (args is Guru) {
         return MaterialPageRoute(
            builder: (_) => DetailGuruScreen(guru: args),
          );
        }

        return MaterialPageRoute(
         builder: (_) => const Scaffold(
            body: Center(child: Text("Data guru tidak ditemukan")),
          ),
        );

      case AppRoutes.editGuru:

        final guru = settings.arguments as Guru;

        return MaterialPageRoute(
          builder: (_) => EditGuruScreen(guru: guru),
        );

//Admin - Siswa
      case AppRoutes.dataSiswa:
        return MaterialPageRoute(
          builder: (_) => const DataSiswaScreen(),
      );

      case AppRoutes.detailSiswa:

        final siswa = settings.arguments as SiswaDetail;

        return MaterialPageRoute(
        builder: (_) => DetailSiswaScreen(siswa: siswa),
      );

      case AppRoutes.tambahSiswa:
        return MaterialPageRoute(
        builder: (_) => const TambahSiswaScreen(),
      );

      case AppRoutes.editSiswa:

        final siswa = settings.arguments as SiswaDetail;

        return MaterialPageRoute(
          builder: (_) => EditSiswaScreen(siswa: siswa),
      );

      case AppRoutes.mutasiSiswa:

        final siswa = settings.arguments as SiswaDetail;

        return MaterialPageRoute(
          builder: (_) => MutasiSiswaScreen(siswa: siswa),
      );

// Admin - Kelas
      case AppRoutes.dataKelas:
        return MaterialPageRoute(builder: (_) => const DataKelasScreen());

      case AppRoutes.detailKelas:

        final kelas = settings.arguments as KelasDetail;

        return MaterialPageRoute(
          builder: (_) => DetailKelasScreen(kelas: kelas),
      );

      case AppRoutes.editWaliKelas:

        final kelas = settings.arguments as KelasDetail;

        return MaterialPageRoute(
          builder: (_) => EditWaliKelasScreen(kelas: kelas),
      );

// Admin - Tahun Ajaran
      case AppRoutes.tahunAjaran:
        return MaterialPageRoute(
        builder: (_) => const TahunAjaranScreen(),
      );

      case AppRoutes.tambahTahunAjaran:
        return MaterialPageRoute(
        builder: (_) => const TambahTahunAjaranScreen(),
      );

      case AppRoutes.rekapAbsensi:
        return MaterialPageRoute(builder: (_) => const RekapAbsensiScreen());

      case AppRoutes.kelolaUser:
        return MaterialPageRoute(builder: (_) => const KelolaUserScreen());

      case AppRoutes.absenGuru:
        return MaterialPageRoute(builder: (_) => const AbsenGuruScreen());

      case AppRoutes.rekapAbsenGuru:
        return MaterialPageRoute(builder: (_) => const RekapAbsenGuruScreen());

      case AppRoutes.absenSiswa:
        return MaterialPageRoute(builder: (_) => const AbsenSiswaScreen());

      case AppRoutes.rekapAbsenSiswa:
        return MaterialPageRoute(builder: (_) => const RekapAbsenSiswaScreen());

      case AppRoutes.profil:
        return MaterialPageRoute(builder: (_) => const ProfilScreen());

      case AppRoutes.notifikasi:
        return MaterialPageRoute(builder: (_) => const NotifikasiScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text("Page not found"),
            ),
          ),
        );

    }

  }

}
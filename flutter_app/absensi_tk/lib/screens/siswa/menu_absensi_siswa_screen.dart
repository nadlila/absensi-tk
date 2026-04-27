import 'package:flutter/material.dart';

import '../../models/kelas_detail_model.dart';
import '../../routes/app_routes.dart';

class MenuAbsensiSiswaScreen extends StatelessWidget {
  final KelasDetail kelas;

  const MenuAbsensiSiswaScreen({super.key, required this.kelas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Absensi ${kelas.namaKelas}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            menu(
              icon: Icons.check_circle,
              title: "Absen Siswa",
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.absenSiswa,
                  arguments: kelas,
                );
              },
            ),
            menu(
              icon: Icons.bar_chart,
              title: "Rekap Absensi",
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.rekapSiswa,
                  arguments: kelas,
                );
              },
            ),
            menu(
              icon: Icons.people,
              title: "Data Siswa",
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.dataSiswaGuru,
                  arguments: kelas,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget menu({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: onTap,
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 12),
            Text(title),
          ],
        ),
      ),
    );
  }
}
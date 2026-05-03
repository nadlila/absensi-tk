import 'package:flutter/material.dart';
import '../../models/kelas_detail_model.dart';
import '../../routes/app_routes.dart';

class DashboardScreen extends StatelessWidget {
  final KelasDetail? kelas;

  const DashboardScreen({super.key, this.kelas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kelas?.namaKelas ?? "Dashboard"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== INFO KELAS =====
            if (kelas != null) ...[
              Text(
                "Kelas: ${kelas!.namaKelas}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 5),
              Text("Wali Kelas: ${kelas!.waliKelas}"),
              const SizedBox(height: 25),
            ],

            if (kelas == null)
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  "Anda belum memiliki kelas",
                  style: TextStyle(fontSize: 16),
                ),
              ),

            // ===== MENU =====
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [

                  // ===== ABSEN GURU =====
                  _menuCard(
                    context,
                    title: "Absensi Guru",
                    icon: Icons.badge,
                    color: Colors.blue,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.absenGuru,
                      );
                    },
                  ),

                  // ===== ABSEN SISWA =====
                  _menuCard(
                    context,
                    title: "Absensi Siswa",
                    icon: Icons.school,
                    color: Colors.green,
                    onTap: () {
                      if (kelas != null) {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.absenSiswa,
                          arguments: kelas,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Tidak ada kelas"),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== WIDGET CARD MENU =====
  Widget _menuCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            )
          ],
        ),
      ),
    );
  }
}
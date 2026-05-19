import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../routes/app_routes.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  bool showNotification = false;

  @override
  void initState() {
    super.initState();
    _checkNotifications();
  }

  Future<void> _checkNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final idUser = prefs.getInt("idUser");

    if (idUser == null) return;

    try {
      final res = await http.get(
        Uri.parse("http://10.0.2.2:8080/api/notifikasi/user/$idUser"),
      );

      if (res.statusCode == 200) {
        List data = jsonDecode(res.body);
        setState(() {
          // Titik merah muncul jika ada notif (laporan kelas) yang belum dibaca
          showNotification = data.any((n) => n["judul"] == "Laporan Absensi Kelas" && n["dibaca"] == false);
        });
      }
    } catch (e) {
      print("Error check notif: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_active_outlined),
              tooltip: "Laporan Absensi Kelas",
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.laporanBelumAbsen).then((_) {
                  _checkNotifications();
                });
              },
            ),
            if (showNotification)
              Positioned(
                right: 12,
                top: 12,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
        title: const Text("Dashboard Admin TK IT Alif"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "Logout",
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.login,
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1,
          children: [
            _menuCard(
              context,
              icon: Icons.person,
              title: "Data Guru",
              route: AppRoutes.dataGuru,
            ),
            _menuCard(
              context,
              icon: Icons.school,
              title: "Data Siswa",
              route: AppRoutes.dataSiswaAdmin,
            ),
            _menuCard(
              context,
              icon: Icons.class_,
              title: "Data Kelas",
              route: AppRoutes.dataKelas,
            ),
            _menuCard(
              context,
              icon: Icons.bar_chart,
              title: "Rekap Absensi",
              route: AppRoutes.rekapAbsensi,
            ),
            _menuCard(
              context,
              icon: Icons.manage_accounts,
              title: "Kelola User",
              route: AppRoutes.kelolaUser,
            ),
            _menuCard(
              context,
              icon: Icons.calendar_month,
              title: "Tahun Ajaran",
              route: AppRoutes.tahunAjaran,
            ),
            _menuCard(
              context,
              icon: Icons.event_busy,
              title: "Hari Libur",
              route: AppRoutes.hariLibur,
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: const Color(0xFFF58220),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

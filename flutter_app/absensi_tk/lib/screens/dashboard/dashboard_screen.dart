import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/kelas_detail_model.dart';
import '../../routes/app_routes.dart';

class DashboardScreen extends StatefulWidget {
  final KelasDetail? kelas;
  const DashboardScreen({super.key, this.kelas});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String namaGuru = "Guru";
  bool showNotification = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Pastikan saat login, username disimpan ke prefs
      String? savedNama = prefs.getString("namaGuru");

      if (savedNama != null && savedNama.isNotEmpty) {
        namaGuru = savedNama;
      } else if (widget.kelas != null) {
        namaGuru = widget.kelas!.waliKelas;
      } else {
        namaGuru = prefs.getString("username") ?? "Guru";
      }
      
      // Logika Notifikasi: Jika sudah lewat 08:30 dan guru belum absen
      final now = DateTime.now();
      if (now.hour > 8 || (now.hour == 8 && now.minute >= 30)) {
         showNotification = true; 
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            // ===== TOP BAR / GREETING =====
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Selamat Datang,",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      Text(
                        namaGuru,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications_outlined, size: 30),
                        onPressed: () => Navigator.pushNamed(context, AppRoutes.notifikasi),
                      ),
                      if (showNotification)
                        Positioned(
                          right: 12,
                          top: 12,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                            constraints: const BoxConstraints(minWidth: 8, minHeight: 8),
                          ),
                        )
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // ===== MENU GRID =====
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: [
                    _menuCard(
                      context,
                      title: "Absensi Guru",
                      subtitle: "07:00 - 11:00",
                      icon: Icons.badge,
                      color: Colors.blue,
                      onTap: () => Navigator.pushNamed(context, AppRoutes.absenGuru),
                    ),
                    _menuCard(
                      context,
                      title: "Absensi Siswa",
                      subtitle: widget.kelas?.namaKelas ?? "Tidak ada Kelas",
                      icon: Icons.school,
                      color: Colors.green,
                      onTap: () {
                        if (widget.kelas != null) {
                          Navigator.pushNamed(context, AppRoutes.absenSiswa, arguments: widget.kelas);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Menu ini tidak tersedia")),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuCard(BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 45, color: color),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}

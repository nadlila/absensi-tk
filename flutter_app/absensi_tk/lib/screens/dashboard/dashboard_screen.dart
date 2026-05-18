import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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
    _checkNotifications();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      namaGuru = prefs.getString("namaGuru") ?? prefs.getString("username") ?? "Guru";
    });
  }

  Future<void> _checkNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final idUser = prefs.getInt("idUser");
    if (idUser == null) return;

    try {
      final res = await http.get(Uri.parse("http://10.0.2.2:8080/api/notifikasi/user/$idUser"));
      if (res.statusCode == 200) {
        List data = jsonDecode(res.body);
        setState(() {
          showNotification = data.any((n) => n["dibaca"] == false);
        });
      }
    } catch (e) {
      print("Error check notif: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ===== TOP BAR / HEADER (Biru Muda B6DEE8) =====
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              color: const Color(0xFFB6DEE8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, color: Color(0xFFF58220)),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            namaGuru,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const Text("Guru / Wali Kelas", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.email_outlined, size: 28),
                        onPressed: () => Navigator.pushNamed(context, AppRoutes.notifikasi).then((_) => _checkNotifications()),
                      ),
                      if (showNotification)
                        Positioned(
                          right: 12,
                          top: 12,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                          ),
                        )
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ===== BANNER IMAGE (Gambar Anak TK) =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/gambar.png',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ===== MENU CARDS (Oranye F58220) =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: _menuCard(
                      title: "Absen guru",
                      icon: Icons.menu_book_rounded,
                      onTap: () => Navigator.pushNamed(context, AppRoutes.absenGuru),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _menuCard(
                      title: "Absen siswa",
                      icon: Icons.person_search_rounded,
                      onTap: () {
                        if (widget.kelas != null) {
                          Navigator.pushNamed(context, AppRoutes.absenSiswa, arguments: widget.kelas);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Anda tidak memiliki kelas")),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuCard({required String title, required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: const Color(0xFFF58220), // 🔥 Warna Oranye F58220
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 60, color: Colors.white.withOpacity(0.9)),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
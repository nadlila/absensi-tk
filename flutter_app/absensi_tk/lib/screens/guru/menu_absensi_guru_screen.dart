import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_top_bar.dart';

class MenuAbsensiGuruScreen extends StatefulWidget {
  final Map<String, String>? profileData;
  const MenuAbsensiGuruScreen({super.key, this.profileData});

  @override
  State<MenuAbsensiGuruScreen> createState() => _MenuAbsensiGuruScreenState();
}

class _MenuAbsensiGuruScreenState extends State<MenuAbsensiGuruScreen> {
  int alpha = 0, hadir = 0, izin = 0, sakit = 0;
  String? namaGuru;
  String? nuptk;
  bool isProfileLoaded = false;
  bool showNotification = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
    fetchRekapData();
    _checkNotifications();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();

    namaGuru = prefs.getString("namaGuru") ??
        prefs.getString("username");

    nuptk = prefs.getString("nuptk");

    setState(() {
      isProfileLoaded = true;
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

  Future<void> fetchRekapData() async {
    final prefs = await SharedPreferences.getInstance();
    final idGuru = prefs.getInt("idGuru");
    if (idGuru == null) return;

    try {
      final res = await http.get(Uri.parse("http://10.0.2.2:8080/api/absensi-guru/guru/$idGuru"));
      if (res.statusCode == 200) {
        List data = jsonDecode(res.body);
        int a = 0, h = 0, i = 0, s = 0;
        for (var item in data) {
          String status = item["status"]["namaStatus"];
          if (status == "Alfa") a++;
          else if (status == "Hadir") h++;
          else if (status == "Izin") i++;
          else if (status == "Sakit") s++;
        }
        setState(() {
          alpha = a; hadir = h; izin = i; sakit = s;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ===== CUSTOM TOP BAR =====
            if (isProfileLoaded)
              CustomTopBar(
                nama: namaGuru ?? "",
                nuptk: nuptk ?? "",
                showNotification: showNotification,
                onNotificationTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.notifikasi,
                ).then((_) => _checkNotifications()),
              ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // ===== CARD GRAFIK =====
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade200),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Grafik kehadiran anda.", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              _buildBar("Hadir", hadir, const Color(0xFFF58220)),
                              _buildBar("Izin", izin, const Color(0xFF29B6F6)),
                              _buildBar("Sakit", sakit, const Color(0xFF66BB6A)),
                              _buildBar("Alpha", alpha, const Color(0xFFEF5350)),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // ===== TOMBOL ABSEN =====
                    _buildActionCard(
                      "Isi kehadiran anda hari ini.",
                      "Absen Sekarang",
                          () => Navigator.pushNamed(context, AppRoutes.absenGuru, arguments: {
                            'nama': namaGuru,
                            'nuptk': nuptk
                          }).then((_) => fetchRekapData()),
                    ),

                    const SizedBox(height: 15),

                    // ===== TOMBOL REKAP =====
                    _buildActionCard(
                      "Lihat rekapan absensi anda.",
                      "Lihat Rekap",
                          () => Navigator.pushNamed(context, AppRoutes.rekapAbsenGuru),
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

  Widget _buildBar(String label, int value, Color color) {
    double maxHeight = 120.0;
    double height = (value / 20).clamp(0.1, 1.0) * maxHeight;

    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: 45,
              height: maxHeight,
              decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(25)),
            ),
            Container(
              width: 45,
              height: height,
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(25)),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildActionCard(String title, String btnText, VoidCallback onTap) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 12),
          SizedBox(
            height: 45,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF58220),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 0,
              ),
              child: Text(btnText, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/kelas_detail_model.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_top_bar.dart';

class DashboardScreen extends StatefulWidget {
  final KelasDetail? kelas;

  const DashboardScreen({
    super.key,
    this.kelas,
  });

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState
    extends State<DashboardScreen> {

  String? namaGuru;
  String? nuptk;

  bool isProfileLoaded = false;
  bool showNotification = false;

  @override
  void initState() {
    super.initState();
    _loadData();
    _checkNotifications();
  }

  Future<void> _loadData() async {
    final prefs =
    await SharedPreferences.getInstance();

    final idUser = prefs.getInt("idUser");

    // ===== AMBIL DARI LOCAL =====
    namaGuru = prefs.getString("namaGuru") ??
        prefs.getString("username");

    nuptk = prefs.getString("nuptk");

    // ===== FETCH API =====
    if (idUser != null) {
      try {
        final res = await http.get(
          Uri.parse(
            "http://10.0.2.2:8080/api/guru/user/$idUser",
          ),
        );

        if (res.statusCode == 200) {
          final data = jsonDecode(res.body);

          namaGuru =
              data["namaGuru"] ?? namaGuru;

          nuptk =
              data["nuptk"]?.toString() ??
                  nuptk;

          // update storage
          await prefs.setString(
            "namaGuru",
            namaGuru ?? "",
          );

          await prefs.setString(
            "nuptk",
            nuptk ?? "",
          );
        }
      } catch (e) {
        print("Error fetch guru profile: $e");
      }
    }

    setState(() {
      isProfileLoaded = true;
    });
  }

  Future<void> _checkNotifications() async {
    final prefs =
    await SharedPreferences.getInstance();

    final idUser = prefs.getInt("idUser");

    if (idUser == null) return;

    try {
      final res = await http.get(
        Uri.parse(
          "http://10.0.2.2:8080/api/notifikasi/user/$idUser",
        ),
      );

      if (res.statusCode == 200) {
        List data = jsonDecode(res.body);

        setState(() {
          showNotification = data.any(
                (n) => n["dibaca"] == false,
          );
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

            // ===== TOP BAR =====
            if (isProfileLoaded)
              CustomTopBar(
                nama: namaGuru ?? "",
                nuptk: nuptk ?? "",
                showNotification:
                showNotification,
                onNotificationTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.notifikasi,
                  ).then(
                        (_) => _checkNotifications(),
                  );
                },
              ),

            const SizedBox(height: 20),

            // ===== BANNER =====
            Padding(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: ClipRRect(
                borderRadius:
                BorderRadius.circular(20),
                child: Image.asset(
                  'assets/gambar.png',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 18),

            // ===== MENU =====
            Padding(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                children: [

                  Expanded(
                    child: _menuCard(
                      title: "Absen guru",
                      icon:
                      Icons.menu_book_rounded,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.absenGuru,
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: _menuCard(
                      title: "Absen siswa",
                      icon: Icons
                          .person_search_rounded,
                      onTap: () {
                        if (widget.kelas !=
                            null) {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.absenSiswa,
                            arguments:
                            widget.kelas,
                          );
                        } else {
                          ScaffoldMessenger.of(
                              context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Anda tidak memiliki kelas",
                              ),
                            ),
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

  Widget _menuCard({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,

      child: Container(
        height: 150,

        decoration: BoxDecoration(
          color: const Color(0xFFF58220),
          borderRadius:
          BorderRadius.circular(20),
        ),

        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [
            Icon(
              icon,
              size: 60,
              color:
              Colors.white.withOpacity(0.9),
            ),

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
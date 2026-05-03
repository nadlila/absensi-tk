import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/login_screen.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  int? idUser;
  Map<String, dynamic>? guru;

  @override
  void initState() {
    super.initState();
    initData();
  }

  // ================= INIT =================
  Future<void> initData() async {
    await getUser();
    await fetchGuru();
  }

  // ================= GET ID USER =================
  Future<void> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    idUser = prefs.getInt("idUser");

    print("ID USER PROFIL: $idUser");
  }

  // ================= FETCH DATA GURU =================
  Future<void> fetchGuru() async {
    if (idUser == null) return;

    final res = await http.get(
      Uri.parse("http://10.0.2.2:8080/api/guru/user/$idUser"),
    );

    if (res.statusCode == 200) {
      setState(() {
        guru = jsonDecode(res.body);
      });
    }
  }

  // ================= LOGOUT =================
  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // 🔥 hapus semua session

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
      ),
      body: guru == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // ===== FOTO =====
                  const CircleAvatar(
                    radius: 40,
                    child: Icon(Icons.person, size: 40),
                  ),

                  const SizedBox(height: 15),

                  // ===== NAMA =====
                  Text(
                    guru!["namaGuru"] ?? "-",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "NUPTK: ${guru!["nuptk"] ?? "-"}",
                    style: const TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 20),

                  // ===== DETAIL =====
                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text("Status"),
                          subtitle: Text(guru!["status"] ?? "-"),
                        ),
                        ListTile(
                          title: const Text("Tempat Lahir"),
                          subtitle: Text(guru!["tempatLahir"] ?? "-"),
                        ),
                        ListTile(
                          title: const Text("Tanggal Lahir"),
                          subtitle: Text(guru!["tanggalLahir"] ?? "-"),
                        ),
                        ListTile(
                          title: const Text("Alamat"),
                          subtitle: Text(guru!["alamat"] ?? "-"),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // ===== LOGOUT =====
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.logout),
                      label: const Text("Logout"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () => logout(context),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
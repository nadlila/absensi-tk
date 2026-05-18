import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../routes/app_routes.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  Map<String, dynamic>? guru;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProfil();
  }

  Future<void> fetchProfil() async {
    final prefs = await SharedPreferences.getInstance();
    final idUser = prefs.getInt("idUser");

    try {
      final res = await http.get(Uri.parse("http://10.0.2.2:8080/api/guru/user/$idUser"));
      if (res.statusCode == 200) {
        setState(() {
          guru = jsonDecode(res.body);
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
      appBar: AppBar(
        backgroundColor: const Color(0xFFB6DEE8),
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text("Profil", style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings, color: Color(0xFFF58220))),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          // Background Oranye atas
          Container(height: 120, decoration: const BoxDecoration(
              color: Color(0xFFF58220),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
          )),

          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 60), // Spasi agar foto overlap

                // Card Putih Utama
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.fromLTRB(20, 70, 20, 30),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F7F7),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Text(guru?["namaGuru"] ?? "-", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            Text(guru?["nuptk"] ?? "-", style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      _infoItem("Status", guru?["status"] ?? "-"),
                      _infoItem("Tempat Tanggal Lahir", "${guru?["tempatLahir"]}, ${guru?["tanggalLahir"]}"),
                      _infoItem("Alamat", guru?["alamat"] ?? "-"),
                      _infoItem("Username", "-"), // Contoh sesuai gambar

                      const SizedBox(height: 40),
                      Center(
                        child: Column(
                          children: [
                            const Text("Logout dari akun", style: TextStyle(fontSize: 13)),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (r) => false),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFF58220),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10)
                              ),
                              child: const Text("Logout", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Foto Profil (CircleAvatar mengambang)
          Positioned(
            top: 20,
            left: MediaQuery.of(context).size.width / 2 - 50,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: const CircleAvatar(
                radius: 45,
                backgroundImage: NetworkImage("https://cdn-icons-png.flaticon.com/512/6840/6840478.png"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 5),
          Text(value, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}
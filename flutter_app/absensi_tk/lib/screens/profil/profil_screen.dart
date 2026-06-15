import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../routes/app_routes.dart';
import '../../services/api_config.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  Map<String, dynamic>? guru;
  bool isLoading = true;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    fetchProfil();
  }

  Future<void> fetchProfil() async {
    final prefs = await SharedPreferences.getInstance();
    final idUser = prefs.getInt("idUser");

    try {
      final res = await http.get(Uri.parse("${ApiConfig.baseUrl}/guru/user/$idUser"));
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

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50, 
    );

    if (image != null) {
      File file = File(image.path);
      String base64Image = base64Encode(file.readAsBytesSync());
      _updateFoto(base64Image);
    }
  }

  Future<void> _updateFoto(String base64String) async {
    if (guru == null) return;

    setState(() => isLoading = true);

    try {
      final body = Map<String, dynamic>.from(guru!);
      body['foto'] = base64String;

      final res = await http.put(
        Uri.parse("${ApiConfig.baseUrl}/guru/${guru!['idGuru']}"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (res.statusCode == 200) {
        setState(() {
          guru = jsonDecode(res.body);
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Foto profil berhasil diperbarui"), backgroundColor: Colors.green),
        );
      } else {
        setState(() => isLoading = false);
        _showError("Gagal memperbarui foto");
      }
    } catch (e) {
      setState(() => isLoading = false);
      _showError("Terjadi kesalahan koneksi");
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red));
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Konfirmasi"),
          content: const Text("Apakah anda yakin ingin keluar dari akun?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); 
                _logout();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF58220),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("Keluar", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasPhoto = guru != null && 
                          guru!["foto"] != null && 
                          guru!["foto"].toString().isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFB6DEE8),
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text("Profil", style: TextStyle(color: Colors.black)),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          Container(
            height: 120,
            decoration: const BoxDecoration(
                color: Color(0xFFF58220),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 60),
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
                            Text(guru?["namaGuru"] ?? "-",
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            Text(guru?["nuptk"] ?? "-", style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      _infoItem("Status", guru?["status"] ?? "-"),
                      _infoItem("Tempat Tanggal Lahir", "${guru?["tempatLahir"]}, ${guru?["tanggalLahir"]}"),
                      _infoItem("Alamat", guru?["alamat"] ?? "-"),
                      const SizedBox(height: 40),
                      Center(
                        child: ElevatedButton(
                          onPressed: _confirmLogout, 
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF58220),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10)),
                          child: const Text("Logout",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 20,
            left: MediaQuery.of(context).size.width / 2 - 50,
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.grey[200], 
                    backgroundImage: hasPhoto 
                        ? MemoryImage(base64Decode(guru!["foto"])) 
                        : null,
                    child: !hasPhoto 
                        ? Icon(Icons.person_3, size: 55, color: Colors.grey[500]) 
                        : null,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(color: Color(0xFFF58220), shape: BoxShape.circle),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ],
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

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AbsensiGuruScreen extends StatefulWidget {
  const AbsensiGuruScreen({super.key});

  @override
  State<AbsensiGuruScreen> createState() => _AbsensiGuruScreenState();
}

class _AbsensiGuruScreenState extends State<AbsensiGuruScreen> {
  int? idUser;
  Map<String, dynamic>? guruLogin;
  List statusList = [];
  Map<String, dynamic>? selectedStatus;
  int? idTahunAjaran;

  @override
  void initState() {
    super.initState();
    initData();
  }

  // 🔥 INIT SEMUA DATA (BIAR TIDAK RACE CONDITION)
  Future<void> initData() async {
    await getUser();
    await fetchGuruLogin();
    await fetchStatus();
    await fetchTahunAjaranAktif();
  }

  // ================= AMBIL ID USER DARI STORAGE =================
  Future<void> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    idUser = prefs.getInt("idUser");

    print("ID USER LOGIN: $idUser");
  }

  // ================= AMBIL DATA GURU =================
  Future<void> fetchGuruLogin() async {
    if (idUser == null) return;

    final res = await http.get(
      Uri.parse("http://10.0.2.2:8080/api/guru/user/$idUser"),
    );

    if (res.statusCode == 200) {
      setState(() {
        guruLogin = jsonDecode(res.body);
      });
    }
  }

  // ================= AMBIL STATUS =================
  Future<void> fetchStatus() async {
    final res = await http.get(
      Uri.parse("http://10.0.2.2:8080/api/status-absensi"),
    );

    if (res.statusCode == 200) {
      setState(() {
        statusList = jsonDecode(res.body);
      });
    }
  }

  // Tahun Ajaran
  Future<void> fetchTahunAjaranAktif() async {
    try {
      final res = await http.get(
        Uri.parse("http://10.0.2.2:8080/api/tahun-ajaran/aktif"),
      );
      if (res.statusCode == 200 && res.body.isNotEmpty) {
        final data = jsonDecode(res.body);
        setState(() {
          idTahunAjaran = data['idTahunAjaran'];
        });
      } else {
        print("Tahun ajaran aktif tidak ada di database");
      }
    } catch (e) {
      print("Error koneksi saat ambil tahun ajaran: $e");
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  // ================= SUBMIT ABSENSI (UNIFIED) =================
  Future<void> submitAbsensi() async {
    // 1. Validasi Input Dasar
    if (guruLogin == null) {
      _showError("Data Guru belum dimuat");
      return;
    }
    if (selectedStatus == null) {
      _showError("Silakan pilih status (Hadir/Izin/Sakit)");
      return;
    }
    if (idTahunAjaran == null) {
      _showError("Admin belum menentukan Tahun Ajaran Aktif");
      return;
    }

    // 2. Cek Batasan Waktu di Sisi Client
    final now = DateTime.now();
    final hour = now.hour;
    final minute = now.minute;
    final currentTime = hour + (minute / 60.0);

    if (currentTime < 7.0) {
      _showError("Absensi belum dibuka. Silakan kembali pukul 07:00.");
      return;
    }
    if (currentTime > 11.0) {
      _showError("Batas waktu absensi sudah berakhir (jam 11:00).");
      return;
    }

    try {
      final res = await http.post(
        Uri.parse("http://10.0.2.2:8080/api/absensi-guru"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "guru": {"idGuru": guruLogin!["idGuru"]},
          "tanggal": DateTime.now().toIso8601String().substring(0, 10),
          "status": {"idStatus": selectedStatus!["idStatus"]},
          "idTahunAjaran": idTahunAjaran
        }),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Absensi Berhasil Disimpan"), backgroundColor: Colors.green),
        );
        Navigator.pop(context);
      } else {
        // Cek pesan error dari backend
        final errorData = jsonDecode(res.body);
        _showError(errorData['message'] ?? "Gagal menyimpan absensi");
      }
    } catch (e) {
      _showError("Terjadi kesalahan koneksi ke server");
    }
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Absensi Guru")),
      body: guruLogin == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===== INFO GURU =====
                  Text(
                    "Nama: ${guruLogin!["namaGuru"]}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text("NUPTK: ${guruLogin!["nuptk"]}"),

                  const SizedBox(height: 20),

                  // ===== DROPDOWN STATUS =====
                  DropdownButtonFormField<Map<String, dynamic>>(
                    hint: const Text("Pilih Status"),
                    value: selectedStatus,
                    items: statusList.map((s) {
                      return DropdownMenuItem<Map<String, dynamic>>(
                        value: s,
                        child: Text(s["namaStatus"]),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedStatus = val;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ===== BUTTON =====
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: submitAbsensi,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("SIMPAN ABSENSI", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),

              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.amber),
                ),
                child: Row(
                    children: [
                    const Icon(Icons.info_outline, color: Colors.orange),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Penting: Batas waktu absensi adalah pukul 11:00 WIB. Lewat dari jam tersebut, sistem akan mencatat Anda sebagai 'Alfa' secara otomatis.",
                    style: TextStyle(fontSize: 12, color: Colors.orange[900], height: 1.4),
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
}

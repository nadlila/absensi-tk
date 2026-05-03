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

  // ================= SUBMIT ABSENSI =================
  Future<void> submitAbsensi() async {
    if (guruLogin == null || selectedStatus == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Status belum dipilih")),
      );
      return;
    }

    final res = await http.post(
      Uri.parse("http://10.0.2.2:8080/api/absensi-guru"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "guru": {"idGuru": guruLogin!["idGuru"]},
        "tanggal": DateTime.now().toString().substring(0, 10),
        "status": {"idStatus": selectedStatus!["idStatus"]}
      }),
    );

    if (res.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Absensi berhasil")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal absen")),
      );
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
                  ),

                  const SizedBox(height: 20),

                  // ===== BUTTON =====
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: submitAbsensi,
                      child: const Text("Simpan Absensi"),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
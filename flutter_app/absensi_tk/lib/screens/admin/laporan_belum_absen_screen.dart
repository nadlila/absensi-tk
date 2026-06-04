import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/api_config.dart';

class LaporanBelumAbsenScreen extends StatefulWidget {
  const LaporanBelumAbsenScreen({super.key});

  @override
  State<LaporanBelumAbsenScreen> createState() => _LaporanBelumAbsenScreenState();
}

class _LaporanBelumAbsenScreenState extends State<LaporanBelumAbsenScreen> {
  List laporan = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLaporan();
  }

  Future<void> fetchLaporan() async {
    final prefs = await SharedPreferences.getInstance();
    final idUser = prefs.getInt("idUser");

    try {
      final res = await http.get(Uri.parse("${ApiConfig.baseUrl}/notifikasi/user/$idUser"));
      if (res.statusCode == 200) {
        List allNotif = jsonDecode(res.body);
        setState(() {
          // 🔥 Filter hanya yang berupa laporan absensi kelas
          laporan = allNotif.where((n) => n["judul"] == "Laporan Absensi Kelas").toList();
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
      appBar: AppBar(title: const Text("Kelas Belum Absen")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : laporan.isEmpty
          ? const Center(child: Text("Semua kelas sudah melakukan absensi hari ini."))
          : ListView.builder(
        itemCount: laporan.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            color: Colors.red[50],
            child: ListTile(
              leading: const Icon(Icons.warning_amber_rounded, color: Colors.red),
              title: Text(laporan[index]["isi"]),
              subtitle: Text("Waktu: ${laporan[index]["waktu"].toString().substring(11, 16)} WIB"),
            ),
          );
        },
      ),
    );
  }
}
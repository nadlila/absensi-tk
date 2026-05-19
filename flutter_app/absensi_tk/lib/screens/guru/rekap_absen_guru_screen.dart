import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class RekapAbsensiGuruScreen extends StatefulWidget {
  const RekapAbsensiGuruScreen({super.key});

  @override
  State<RekapAbsensiGuruScreen> createState() => _RekapAbsensiGuruScreenState();
}

class _RekapAbsensiGuruScreenState extends State<RekapAbsensiGuruScreen> {
  List data = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final idGuru = prefs.getInt("idGuru");

      if (idGuru == null) {
        setState(() => isLoading = false);
        return;
      }

      // Panggil endpoint spesifik untuk guru tersebut
      final res = await http.get(
        Uri.parse("http://10.0.2.2:8080/api/absensi-guru/guru/$idGuru"),
      );

      if (res.statusCode == 200) {
        List fetchedData = jsonDecode(res.body);

        // Urutkan berdasarkan tanggal terbaru
        fetchedData.sort((a, b) => b["tanggal"].compareTo(a["tanggal"]));

        setState(() {
          data = fetchedData;
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetch rekap: $e");
      setState(() => isLoading = false);
    }
  }

  // Fungsi untuk refresh data
  Future<void> onRefresh() async {
    setState(() => isLoading = true);
    await fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Riwayat Absensi Saya",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color(0xFFB6DEE8),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: onRefresh,
        child: data.isEmpty
            ? const Center(child: Text("Belum ada riwayat absensi"))
            : ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: data.length,
          itemBuilder: (context, i) {
            final d = data[i];
            final status = d["status"]["namaStatus"];
            final jam = d["jam"] ?? "--:--";
            final ket = d["keterangan"] ?? "";

            // Beri warna berbeda untuk tiap status
            Color statusColor = Colors.grey;
            if (status == "Hadir") statusColor = Colors.green;
            if (status == "Izin") statusColor = Colors.orange;
            if (status == "Sakit") statusColor = Colors.red;
            if (status == "Alfa") statusColor = Colors.black;

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        jam.toString().substring(0, 5), // Ambil HH:mm saja
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                      const Text("WIB", style: TextStyle(fontSize: 9)),
                    ],
                  ),
                ),
                title: Text(
                  d["tanggal"],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Status: $status ${ket.isNotEmpty ? '($ket)' : ''}",
                  style: TextStyle(
                    color: ket == "Terlambat" ? Colors.red : Colors.black87,
                  ),
                ),
                trailing: Icon(
                  Icons.check_circle,
                  color: statusColor,
                  size: 20,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
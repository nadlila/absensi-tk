import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../services/api_config.dart';

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

      final res = await http.get(
        Uri.parse("${ApiConfig.baseUrl}/absensi-guru/guru/$idGuru"),
      );

      if (res.statusCode == 200) {
        List fetchedData = jsonDecode(res.body);
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

  Future<void> onRefresh() async {
    setState(() => isLoading = true);
    await fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Absensi Saya", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: const Color(0xFFB6DEE8),
        elevation: 0,
        centerTitle: true,
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

            String displayKet = d["keterangan"] ?? "";
            String alasanUser = d["alasan"] ?? "";
            
            if ((displayKet == "-" || displayKet.isEmpty) && alasanUser.isNotEmpty) {
              displayKet = alasanUser;
            }

            Color statusColor = Colors.grey;
            if (status == "Hadir") statusColor = Colors.green;
            if (status == "Izin") statusColor = Colors.orange;
            if (status == "Sakit") statusColor = Colors.red;
            if (status == "Alpa") statusColor = Colors.black;

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                      Text(jam.toString().substring(0, 5), style: TextStyle(fontWeight: FontWeight.bold, color: statusColor)),
                      const Text("WIB", style: TextStyle(fontSize: 9)),
                    ],
                  ),
                ),
                title: Text(d["tanggal"], style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text("Status: $status ($displayKet)"),
                trailing: Icon(Icons.check_circle, color: statusColor, size: 20),
              ),
            );
          },
        ),
      ),
    );
  }
}

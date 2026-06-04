import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../services/api_config.dart';

class DetailRekapGuruAdminScreen extends StatefulWidget {
  final int idGuru;
  final String namaGuru;
  final int idTahun;

  const DetailRekapGuruAdminScreen({
    super.key,
    required this.idGuru,
    required this.namaGuru,
    required this.idTahun,
  });

  @override
  State<DetailRekapGuruAdminScreen> createState() => _DetailRekapGuruAdminScreenState();
}

class _DetailRekapGuruAdminScreenState extends State<DetailRekapGuruAdminScreen> {
  List data = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDetailRekap();
  }

  Future<void> fetchDetailRekap() async {
    try {
      // Kita panggil endpoint per guru
      final res = await http.get(
        Uri.parse("${ApiConfig.baseUrl}/absensi-guru/guru/${widget.idGuru}"),
      );

      if (res.statusCode == 200) {
        List allData = jsonDecode(res.body);
        // Filter di sisi client berdasarkan idTahun agar akurat sesuai pilihan admin
        setState(() {
          data = allData.where((item) => item["tahunAjaran"]["idTahunAjaran"] == widget.idTahun).toList();
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetch detail rekap guru: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Riwayat: ${widget.namaGuru}"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : data.isEmpty
              ? const Center(child: Text("Tidak ada riwayat absensi di tahun ini"))
              : ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: data.length,
                  itemBuilder: (context, i) {
                    final d = data[i];
                    final status = d["status"]["namaStatus"];
                    final jam = d["jam"] ?? "--:--";
                    
                    // LOGIKA: Ambil 'alasan' jika 'keterangan' berisi '-' (karena dipaksa backend)
                    String displayKet = d["keterangan"] ?? "";
                    String alasanUser = d["alasan"] ?? "";
                    
                    if ((displayKet == "-" || displayKet.isEmpty) && alasanUser.isNotEmpty) {
                      displayKet = alasanUser;
                    }

                    Color statusColor = Colors.grey;
                    if (status == "Hadir") statusColor = Colors.green;
                    if (status == "Izin") statusColor = Colors.orange;
                    if (status == "Sakit") statusColor = Colors.red;

                    return Card(
                      child: ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(jam.toString().substring(0, 5), style: const TextStyle(fontWeight: FontWeight.bold)),
                            const Text("WIB", style: TextStyle(fontSize: 10)),
                          ],
                        ),
                        title: Text(d["tanggal"], style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text("Status: $status ($displayKet)"),
                        trailing: Icon(Icons.circle, color: statusColor, size: 12),
                      ),
                    );
                  },
                ),
    );
  }
}
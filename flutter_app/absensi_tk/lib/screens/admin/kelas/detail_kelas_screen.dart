import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../models/kelas_detail_model.dart';
import '../../../routes/app_routes.dart';

class DetailKelasScreen extends StatelessWidget {

  final KelasDetail kelas;

  const DetailKelasScreen({
    super.key,
    required this.kelas,
  });

  Widget item(String title, String value){

    return Padding(
      padding: const EdgeInsets.only(bottom:15),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height:5),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),

            child: Text(value),
          )

        ],
      ),
    );

  }

  // 🔥 DELETE FUNCTION
  Future<void> deleteKelas(BuildContext context) async {

    final response = await http.delete(
      Uri.parse("http://10.0.2.2:8080/api/kelas-guru/${kelas.id}"),
    );

    if(response.statusCode == 200 || response.statusCode == 204){
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Data berhasil dihapus")),
        );

        Navigator.pop(context, true); // 🔥 trigger refresh
      }

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal menghapus data")),
      );
    }
  }

  // 🔥 Fungsi untuk mengambil daftar Tahun Ajaran
  Future<List<dynamic>> fetchTahun() async {
    final response = await http.get(Uri.parse("http://10.0.2.2:8080/api/tahun-ajaran"));
    return response.statusCode == 200 ? jsonDecode(response.body) : [];
  }

  Future<List<dynamic>> fetchDaftarKelas() async {
    final response = await http.get(Uri.parse("http://10.0.2.2:8080/api/kelas"));
    return response.statusCode == 200 ? jsonDecode(response.body) : [];
  }

  // 🔥 Dialog Naik Kelas Massal
  void showNaikKelasMassal(BuildContext context) async {
    String? selectedKelasBaru = kelas.namaKelas; // Default ke nama kelas yang sama (misal A1 ke A1 di tahun baru)
    int? selectedTahunId;
    final listTahun = await fetchTahun();
    final listKelas = await fetchDaftarKelas();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text("Naik Kelas / Lanjut Semester"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 1. Pilih Tahun Ajaran Baru
              DropdownButtonFormField<int>(
                items: listTahun.map<DropdownMenuItem<int>>((t) => DropdownMenuItem(
                  value: t["idTahunAjaran"],
                  child: Text("${t["tahun"]} - ${t["semester"]}"),
                )).toList(),
                onChanged: (v) => setState(() => selectedTahunId = v),
                decoration: const InputDecoration(labelText: "Tahun Ajaran Baru", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 15),
              // 2. Pilih Kelas Baru (Fleksibel: bisa tetap atau pindah)
              DropdownButtonFormField<String>(
                value: selectedKelasBaru,
                items: listKelas.map<DropdownMenuItem<String>>((k) => DropdownMenuItem(
                  value: k["idKelas"],
                  child: Text(k["namaKelas"]),
                )).toList(),
                onChanged: (v) => setState(() => selectedKelasBaru = v),
                decoration: const InputDecoration(labelText: "Pilih Kelas Tujuan", border: OutlineInputBorder()),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
            ElevatedButton(
              onPressed: () async {
                if (selectedTahunId == null) return;
                await eksekusiNaikKelasMassal(context, selectedTahunId!, selectedKelasBaru!);
                Navigator.pop(context);
              },
              child: const Text("Proses Sekarang"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> eksekusiNaikKelasMassal(BuildContext context, int idTahunBaru, String idKelasBaru) async {
    final response = await http.post(
      Uri.parse("http://10.0.2.2:8080/api/siswa-kelas/naik-kelas-massal"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "idKelasAsal": kelas.idKelas, // Gunakan idKelas (misal: "A1")
        "idTahunLama": kelas.idTahunAjaran,
        "idTahunBaru": idTahunBaru,
        "idKelasBaru": idKelasBaru // Kelas tujuan (bisa B1)
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Berhasil memindahkan siswa ke tahun ajaran baru")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Gagal memproses data")));
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Detail Kelas"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: ListView(

          children: [

            item("Nama Kelas", kelas.namaKelas),
            item("Wali Kelas", kelas.waliKelas),
            item("Tahun Ajaran", kelas.tahun),
            item("Semester", kelas.semester),

            const SizedBox(height:20),

            // 🔵 EDIT BUTTON
            ElevatedButton.icon(

              onPressed: () async {

                final result = await Navigator.pushNamed(
                  context,
                  AppRoutes.editWaliKelas,
                  arguments: kelas,
                );

                if(result == true){
                  Navigator.pop(context, true); // refresh ke list
                }

              },

              icon: const Icon(Icons.edit),
              label: const Text("Edit Wali Kelas"),

            ),

            const SizedBox(height:10),

            // 🔴 DELETE BUTTON
            ElevatedButton.icon(

              onPressed: () async {

                final confirm = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Konfirmasi"),
                    content: const Text("Yakin ingin menghapus data ini?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text("Batal"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text(
                          "Hapus",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );

                if(confirm == true){
                  deleteKelas(context);
                }

              },

              icon: const Icon(Icons.delete),
              label: const Text("Hapus"),

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),

            ),

            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => showNaikKelasMassal(context),
              icon: const Icon(Icons.group_add),
              label: const Text("Naik Kelas / Lanjut Semester (Massal)"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),

          ],

        ),

      ),

    );

  }

}
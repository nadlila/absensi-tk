import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../models/siswa_detail_model.dart';
import '../../../routes/app_routes.dart';

class DetailSiswaScreen extends StatelessWidget {
  final SiswaDetail siswa;

  const DetailSiswaScreen({
    super.key,
    required this.siswa,
  });

  Widget buildRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
          const Text(
            ":",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔥 KONFIRMASI HAPUS
  void confirmHapus(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: const Text("Yakin ingin menghapus siswa ini?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              hapusSiswa(context);
            },
            child: const Text(
              "Hapus",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  // 🔥 HAPUS SISWA
  Future<void> hapusSiswa(BuildContext context) async {
    try {
      final response = await http.delete(
        Uri.parse("http://10.0.2.2:8080/api/siswa/${siswa.idSiswa}"),
      );

      if (response.statusCode == 200) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Siswa berhasil dihapus")),
          );
          Navigator.pop(context, true);
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Gagal menghapus siswa")),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Terjadi kesalahan koneksi")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Detail Siswa",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color(0xFFB6DEE8),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Student Info Card
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  buildRow("Nama", siswa.namaSiswa),
                  buildRow("NISN", siswa.nisn ?? "-"),
                  buildRow("Tempat Lahir", siswa.tempatLahir ?? "-"),
                  buildRow("Tanggal Lahir", siswa.tanggalLahir ?? "-"),
                  buildRow("Alamat", siswa.alamat ?? "-"),
                  buildRow("Kelas", siswa.namaKelas ?? "-"),
                  buildRow("Tahun", siswa.tahun ?? "-"),
                  buildRow("Semester", siswa.semester ?? "-"),
                ],
              ),
            ),
            const SizedBox(height: 25),
            // Action Buttons
            Row(
              children: [
                // 🔵 EDIT
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () async {
                      final result = await Navigator.pushNamed(
                        context,
                        AppRoutes.editSiswa,
                        arguments: siswa,
                      );
                      if (result == true) {
                        Navigator.pop(context, true);
                      }
                    },
                    icon: const Icon(Icons.edit, size: 20),
                    label: const Text("Edit"),
                  ),
                ),
                const SizedBox(width: 8),
                // 🟠 MUTASI
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () async {
                      final result = await Navigator.pushNamed(
                        context,
                        AppRoutes.mutasiSiswa,
                        arguments: siswa,
                      );
                      if (result == true) {
                        Navigator.pop(context, true);
                      }
                    },
                    icon: const Icon(Icons.swap_horiz, size: 20),
                    label: const Text("Mutasi"),
                  ),
                ),
                const SizedBox(width: 8),
                // 🔴 HAPUS
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      confirmHapus(context);
                    },
                    icon: const Icon(Icons.delete, size: 20),
                    label: const Text("Hapus"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

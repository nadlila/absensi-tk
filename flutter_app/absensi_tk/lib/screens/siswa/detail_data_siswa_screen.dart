import 'package:flutter/material.dart';
import '../../models/siswa_detail_model.dart';

class DetailDataSiswaScreen extends StatelessWidget {
  final SiswaDetail siswa;

  const DetailDataSiswaScreen({super.key, required this.siswa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(siswa.namaSiswa),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            item("Nama", siswa.namaSiswa),
            item("NISN", siswa.nisn ?? "-"),
            item("Tempat Lahir", siswa.tempatLahir ?? "-"),
            item("Tanggal Lahir", siswa.tanggalLahir ?? "-"),
            item("Alamat", siswa.alamat ?? "-"),
          ],
        ),
      ),
    );
  }

  Widget item(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        "$label: $value",
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
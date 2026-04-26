import 'package:flutter/material.dart';
import '../../models/kelas_detail_model.dart';

class AbsenGuruScreen extends StatelessWidget {
  final KelasDetail? kelas;

  const AbsenGuruScreen({super.key, this.kelas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          kelas != null
              ? "Absen Guru - ${kelas!.namaKelas}"
              : "Absen Guru",
        ),
      ),

      body: Center(
        child: kelas != null
            ? Text("Guru di kelas ${kelas!.namaKelas}")
            : const Text("Anda tidak memiliki kelas untuk absen"),
      ),
    );
  }
}
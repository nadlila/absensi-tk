import 'package:flutter/material.dart';

class RekapAbsenSiswaScreen extends StatelessWidget {
  const RekapAbsenSiswaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rekap Absen Siswa"),
      ),
      body: const Center(
        child: Text(
          "Halaman Rekap Absen Siswa",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
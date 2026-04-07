import 'package:flutter/material.dart';

class RekapAbsenGuruScreen extends StatelessWidget {
  const RekapAbsenGuruScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rekap Absen Guru"),
      ),
      body: const Center(
        child: Text(
          "Halaman Rekap Absen Guru",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class RekapAbsensiScreen extends StatelessWidget {
  const RekapAbsensiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rekap Absensi"),
      ),
      body: const Center(
        child: Text(
          "Halaman Rekap Absensi",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
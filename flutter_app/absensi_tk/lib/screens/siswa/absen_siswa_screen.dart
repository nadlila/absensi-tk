import 'package:flutter/material.dart';

class AbsenSiswaScreen extends StatelessWidget {
  const AbsenSiswaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Menu Absen Siswa")),
      body: const Center(child: Text("Menu Siswa")),
    );
  }
}
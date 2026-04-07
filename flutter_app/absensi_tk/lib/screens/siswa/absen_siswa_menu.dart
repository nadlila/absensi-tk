import 'package:flutter/material.dart';

class AbsenSiswaMenu extends StatelessWidget {
  const AbsenSiswaMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Menu Absen Siswa")),
      body: const Center(child: Text("Menu Siswa")),
    );
  }
}
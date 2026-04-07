import 'package:flutter/material.dart';

class AbsenGuruMenu extends StatelessWidget {
  const AbsenGuruMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Menu Absen Guru")),
      body: const Center(child: Text("Menu Guru")),
    );
  }
}
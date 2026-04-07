import 'package:flutter/material.dart';

class DataKelasScreen extends StatelessWidget {
  const DataKelasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Kelas"),
      ),
      body: const Center(
        child: Text(
          "Halaman Data Kelas",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class DataSiswaScreen extends StatelessWidget {
  const DataSiswaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Siswa"),
      ),
      body: const Center(
        child: Text(
          "Halaman Data Siswa",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
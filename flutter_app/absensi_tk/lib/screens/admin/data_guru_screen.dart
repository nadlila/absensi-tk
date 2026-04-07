import 'package:flutter/material.dart';

class DataGuruScreen extends StatelessWidget {
  const DataGuruScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Guru"),
      ),
      body: const Center(
        child: Text(
          "Halaman Data Guru",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
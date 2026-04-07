import 'package:flutter/material.dart';

class KelolaUserScreen extends StatelessWidget {
  const KelolaUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kelola User"),
      ),
      body: const Center(
        child: Text(
          "Halaman Kelola User",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
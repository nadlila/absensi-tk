import 'package:flutter/material.dart';
import '../../models/kelas_detail_model.dart';

class DashboardScreen extends StatelessWidget {
  final KelasDetail? kelas;

  const DashboardScreen({super.key, this.kelas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          kelas?.namaKelas ?? "Dashboard",
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: kelas != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kelas: ${kelas!.namaKelas}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text("Wali Kelas: ${kelas!.waliKelas}"),
                ],
              )
            : const Center(
                child: Text(
                  "Anda belum memiliki kelas",
                  style: TextStyle(fontSize: 16),
                ),
              ),
      ),
    );
  }
}
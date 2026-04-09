import 'package:flutter/material.dart';
import '../../../models/guru_model.dart';

class DetailGuruScreen extends StatelessWidget {

  final Guru guru;

  const DetailGuruScreen({super.key, required this.guru});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Detail Guru"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text("Nama : ${guru.namaGuru}"),
            const SizedBox(height: 10),

            Text("NUPTK : ${guru.nuptk}"),
            const SizedBox(height: 10),

            Text("Status : ${guru.status}"),
            const SizedBox(height: 10),

            Text("Tempat Lahir : ${guru.tempatLahir}"),
            const SizedBox(height: 10),

            Text("Tanggal Lahir : ${guru.tanggalLahir}"),
            const SizedBox(height: 10),

            Text("Alamat : ${guru.alamat}"),

          ],
        ),
      ),
    );
  }
}
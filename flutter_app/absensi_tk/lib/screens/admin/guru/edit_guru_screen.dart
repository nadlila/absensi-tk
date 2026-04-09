import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../models/guru_model.dart';

class EditGuruScreen extends StatefulWidget {
  const EditGuruScreen({super.key});

  @override
  State<EditGuruScreen> createState() => _EditGuruScreenState();
}

class _EditGuruScreenState extends State<EditGuruScreen> {

  final TextEditingController namaController = TextEditingController();
  final TextEditingController nuptkController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController tempatLahirController = TextEditingController();
  final TextEditingController tanggalLahirController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();

  late Guru guru;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    guru = ModalRoute.of(context)!.settings.arguments as Guru;

    namaController.text = guru.namaGuru;
    nuptkController.text = guru.nuptk;
    statusController.text = guru.status;
    tempatLahirController.text = guru.tempatLahir;
    tanggalLahirController.text = guru.tanggalLahir;
    alamatController.text = guru.alamat;
  }

  Future<void> updateGuru() async {

    final response = await http.put(
      Uri.parse("http://10.0.2.2:8080/api/guru/${guru.idGuru}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "namaGuru": namaController.text,
        "nuptk": nuptkController.text,
        "status": statusController.text,
        "tempatLahir": tempatLahirController.text,
        "tanggalLahir": tanggalLahirController.text,
        "alamat": alamatController.text,
        "idUser": guru.idUser
      }),
    );

    if (response.statusCode == 200) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Data guru berhasil diupdate")),
      );

      Navigator.pop(context);

    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal update data")),
      );

    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Edit Guru"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: ListView(

          children: [

            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                labelText: "Nama Guru",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: nuptkController,
              decoration: const InputDecoration(
                labelText: "NUPTK",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: statusController,
              decoration: const InputDecoration(
                labelText: "Status",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: tempatLahirController,
              decoration: const InputDecoration(
                labelText: "Tempat Lahir",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: tanggalLahirController,
              decoration: const InputDecoration(
                labelText: "Tanggal Lahir",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: alamatController,
              decoration: const InputDecoration(
                labelText: "Alamat",
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: updateGuru,
              child: const Text("Update Guru"),
            )

          ],

        ),

      ),

    );

  }

}
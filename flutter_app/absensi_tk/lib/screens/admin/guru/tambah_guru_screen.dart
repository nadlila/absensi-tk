import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TambahGuruScreen extends StatefulWidget {
  const TambahGuruScreen({super.key});

  @override
  State<TambahGuruScreen> createState() => _TambahGuruScreenState();
}

class _TambahGuruScreenState extends State<TambahGuruScreen> {

  final namaController = TextEditingController();
  final nuptkController = TextEditingController();
  final statusController = TextEditingController();
  final tempatLahirController = TextEditingController();
  final tanggalLahirController = TextEditingController();
  final alamatController = TextEditingController();
  final idUserController = TextEditingController();

  bool isLoading = false;

  Future<void> tambahGuru() async {

    setState(() {
      isLoading = true;
    });

    final response = await http.post(
      Uri.parse("http://10.0.2.2:8080/api/guru"),
      headers: {
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "namaGuru": namaController.text,
        "nuptk": nuptkController.text,
        "status": statusController.text,
        "tempatLahir": tempatLahirController.text,
        "tanggalLahir": tanggalLahirController.text,
        "alamat": alamatController.text,
        "idUser": int.tryParse(idUserController.text)
      }),
    );

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200 || response.statusCode == 201) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Guru berhasil ditambahkan")),
      );

      Navigator.pop(context); // kembali ke DataGuruScreen

    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal menambahkan guru")),
      );

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Tambah Guru"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                labelText: "Nama Guru",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: nuptkController,
              decoration: const InputDecoration(
                labelText: "NUPTK",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: statusController,
              decoration: const InputDecoration(
                labelText: "Status Guru",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: tempatLahirController,
              decoration: const InputDecoration(
                labelText: "Tempat Lahir",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: tanggalLahirController,
              decoration: const InputDecoration(
                labelText: "Tanggal Lahir",
                border: OutlineInputBorder(),
                hintText: "YYYY-MM-DD",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: alamatController,
              decoration: const InputDecoration(
                labelText: "Alamat",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: idUserController,
              decoration: const InputDecoration(
                labelText: "ID User",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton(
                onPressed: isLoading ? null : tambahGuru,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("SIMPAN"),
              ),
            )

          ],
        ),
      ),

    );
  }
}
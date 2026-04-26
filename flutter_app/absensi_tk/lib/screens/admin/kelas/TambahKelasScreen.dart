import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TambahKelasScreen extends StatefulWidget {
  const TambahKelasScreen({super.key});

  @override
  State<TambahKelasScreen> createState() => _TambahKelasScreenState();
}

class _TambahKelasScreenState extends State<TambahKelasScreen> {

  final TextEditingController namaController = TextEditingController();

  Future<void> simpan() async {

    final nama = namaController.text;

    if(nama.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Nama kelas wajib diisi")),
      );
      return;
    }

    final response = await http.post(
      Uri.parse("http://10.0.2.2:8080/api/kelas"),
      headers: {"Content-Type":"application/json"},
      body: jsonEncode({
        "idKelas": nama,
        "namaKelas": nama
      }),
    );

    if(response.statusCode == 200 || response.statusCode == 201){

      if(context.mounted){
        Navigator.pop(context, true);
      }

    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Tambah Kelas"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                labelText: "Nama Kelas",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height:20),

            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton(
                onPressed: simpan,
                child: const Text("SIMPAN"),
              ),
            )

          ],

        ),

      ),

    );

  }
}
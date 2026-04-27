import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../models/siswa_detail_model.dart';

class EditSiswaScreen extends StatefulWidget {

  final SiswaDetail siswa;

  const EditSiswaScreen({
    super.key,
    required this.siswa,
  });

  @override
  State<EditSiswaScreen> createState() => _EditSiswaScreenState();
}

class _EditSiswaScreenState extends State<EditSiswaScreen> {

  final namaController = TextEditingController();
  final nisnController = TextEditingController();
  final tempatLahirController = TextEditingController();
  final tanggalLahirController = TextEditingController();
  final alamatController = TextEditingController();

  @override
  void initState() {
    super.initState();

    namaController.text = widget.siswa.namaSiswa;
    nisnController.text = widget.siswa.nisn ?? "-";
  }

  Future<void> updateSiswa() async {

    final response = await http.put(

      Uri.parse(
        "http://10.0.2.2:8080/api/siswa/${widget.siswa.idSiswa}",
      ),

      headers: {
        "Content-Type": "application/json"
      },

      body: jsonEncode({

        "namaSiswa": namaController.text,
        "nisn": nisnController.text,
        "tempatLahir": tempatLahirController.text,
        "tanggalLahir": tanggalLahirController.text,
        "alamat": alamatController.text,

      }),

    );

    if(response.statusCode == 200){

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Data berhasil diupdate")),
      );

      Navigator.pop(context);

    }

  }

  Widget field(String label, TextEditingController controller){

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),

      child: TextField(

        controller: controller,

        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),

      ),

    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Edit Siswa"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: ListView(

          children: [

            field("Nama Siswa", namaController),
            field("NISN", nisnController),
            field("Tempat Lahir", tempatLahirController),
            field("Tanggal Lahir", tanggalLahirController),
            field("Alamat", alamatController),

            const SizedBox(height: 20),

            ElevatedButton(

              onPressed: updateSiswa,

              child: const Text("UPDATE"),

            )

          ],

        ),

      ),

    );

  }

}
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../models/guru_model.dart';

class EditGuruScreen extends StatefulWidget {

  final Guru guru;

  const EditGuruScreen({
    super.key,
    required this.guru,
  });

  @override
  State<EditGuruScreen> createState() => _EditGuruScreenState();
}

class _EditGuruScreenState extends State<EditGuruScreen> {

  final namaController = TextEditingController();
  final nuptkController = TextEditingController();
  final statusController = TextEditingController();
  final tempatLahirController = TextEditingController();
  final tanggalLahirController = TextEditingController();
  final alamatController = TextEditingController();

  List users = [];
  int? selectedUserId;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    namaController.text = widget.guru.namaGuru;
    nuptkController.text = widget.guru.nuptk;
    statusController.text = widget.guru.status;
    tempatLahirController.text = widget.guru.tempatLahir;
    tanggalLahirController.text = widget.guru.tanggalLahir;
    alamatController.text = widget.guru.alamat;

    selectedUserId = widget.guru.idUser;

    fetchUsers();
  }

  Future<void> fetchUsers() async {

    try {

      final response = await http.get(
        Uri.parse("http://10.0.2.2:8080/api/users"),
      );

      if (response.statusCode == 200) {

        setState(() {
          users = jsonDecode(response.body);
        });

      }

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal mengambil data user")),
      );

    }

  }

  Future<void> updateGuru() async {

    setState(() {
      isLoading = true;
    });

    final response = await http.put(
      Uri.parse("http://10.0.2.2:8080/api/guru/${widget.guru.idGuru}"),

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
        "idUser": selectedUserId

      }),

    );

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Data berhasil diupdate")),
      );

      Navigator.pop(context);

    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Update gagal")),
      );

    }

  }

  Widget field(String label, TextEditingController controller) {

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
        title: const Text("Edit Guru"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: ListView(

          children: [

            field("Nama Guru", namaController),
            field("NUPTK", nuptkController),
            field("Status", statusController),
            field("Tempat Lahir", tempatLahirController),
            field("Tanggal Lahir", tanggalLahirController),
            field("Alamat", alamatController),

            const SizedBox(height: 15),

            DropdownButtonFormField<int>(

              value: selectedUserId,

              items: users.map<DropdownMenuItem<int>>((user) {

                return DropdownMenuItem<int>(
                  value: user["idUser"],
                  child: Text(user["username"]),
                );

              }).toList(),

              onChanged: (value) {

                setState(() {
                  selectedUserId = value;
                });

              },

              decoration: const InputDecoration(
                labelText: "Pilih User",
                border: OutlineInputBorder(),
              ),

            ),

            const SizedBox(height: 25),

            ElevatedButton(

              onPressed: isLoading ? null : updateGuru,

              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Update"),

            )

          ],

        ),
      ),

    );

  }

}
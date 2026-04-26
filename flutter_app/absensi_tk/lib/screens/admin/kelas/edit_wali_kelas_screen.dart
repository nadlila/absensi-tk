import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../models/kelas_detail_model.dart';
import '../../../models/guru_model.dart';

class EditWaliKelasScreen extends StatefulWidget {

  final KelasDetail kelas;

  const EditWaliKelasScreen({
    super.key,
    required this.kelas,
  });

  @override
  State<EditWaliKelasScreen> createState() => _EditWaliKelasScreenState();
}

class _EditWaliKelasScreenState extends State<EditWaliKelasScreen> {

  List<Guru> listGuru = [];
  int? selectedGuru;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchGuru();
  }

  Future<void> fetchGuru() async {

    final response = await http.get(
      Uri.parse("http://10.0.2.2:8080/api/guru"),
    );

    if(response.statusCode == 200){

      List data = jsonDecode(response.body);

      setState(() {

        listGuru =
            data.map((e) => Guru.fromJson(e)).toList();

        // ✅ default wali kelas sekarang
        selectedGuru = widget.kelas.idGuru;

        isLoading = false;

      });

    }

  }

  Future<void> updateWaliKelas() async {

    final response = await http.put(

      Uri.parse("http://10.0.2.2:8080/api/kelas-guru/${widget.kelas.id}"),

      headers: {
        "Content-Type":"application/json"
      },

      body: jsonEncode({

        "idKelas": widget.kelas.idKelas,
        "idGuru": selectedGuru,
        "idTahunAjaran": 1

      }),

    );

    if(response.statusCode == 200){

      if(context.mounted){

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Wali kelas berhasil diubah")),
        );

        Navigator.pop(context, true); // 🔥 kirim signal refresh

      }

    }

  }

  // 🔥 WAJIB ADA (ini yang bikin error kamu hilang)
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Edit Wali Kelas"),
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(

              padding: const EdgeInsets.all(20),

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(
                    "Kelas : ${widget.kelas.namaKelas}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height:20),

                  DropdownButtonFormField<int>(

                    value: selectedGuru,

                    items: listGuru.map((guru){

                      return DropdownMenuItem(

                        value: guru.idGuru,

                        child: Text(guru.namaGuru),

                      );

                    }).toList(),

                    onChanged: (value){
                      setState(() {
                        selectedGuru = value;
                      });
                    },

                    decoration: const InputDecoration(
                      labelText: "Pilih Guru",
                      border: OutlineInputBorder(),
                    ),

                  ),

                  const SizedBox(height:30),

                  SizedBox(

                    width: double.infinity,
                    height: 50,

                    child: ElevatedButton(

                      onPressed: updateWaliKelas,

                      child: const Text("SIMPAN"),

                    ),

                  )

                ],

              ),

            ),

    );

  }
}
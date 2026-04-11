import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../models/kelas_model.dart';
import '../../../models/tahun_ajaran_model.dart';

class TambahSiswaScreen extends StatefulWidget {
  const TambahSiswaScreen({super.key});

  @override
  State<TambahSiswaScreen> createState() => _TambahSiswaScreenState();
}

class _TambahSiswaScreenState extends State<TambahSiswaScreen> {

  final namaController = TextEditingController();
  final nisnController = TextEditingController();
  final tempatLahirController = TextEditingController();
  final tanggalLahirController = TextEditingController();
  final alamatController = TextEditingController();

  List<Kelas> listKelas = [];
  TahunAjaran? tahunAktif;

  String? selectedKelas;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {

    final tahunResponse = await http.get(
      Uri.parse("http://10.0.2.2:8080/api/tahun-ajaran/aktif"),
    );

    if(tahunResponse.statusCode == 200){

      tahunAktif = TahunAjaran.fromJson(
        jsonDecode(tahunResponse.body),
      );

    }

    final kelasResponse = await http.get(
      Uri.parse("http://10.0.2.2:8080/api/kelas"),
    );

    if(kelasResponse.statusCode == 200){

      List data = jsonDecode(kelasResponse.body);

      setState(() {

        listKelas = data.map((e) => Kelas.fromJson(e)).toList();

        if(listKelas.isNotEmpty){
          selectedKelas = listKelas.first.idKelas;
        }

      });

    }

  }

  Future<void> tambahSiswa() async {

    if(selectedKelas == null || tahunAktif == null){
      return;
    }

    setState(() {
      isLoading = true;
    });

    /// 1️⃣ simpan siswa
    final siswaResponse = await http.post(

      Uri.parse("http://10.0.2.2:8080/api/siswa"),

      headers: {
        "Content-Type":"application/json"
      },

      body: jsonEncode({

        "namaSiswa": namaController.text,
        "nisn": nisnController.text,
        "tempatLahir": tempatLahirController.text,
        "tanggalLahir": tanggalLahirController.text,
        "alamat": alamatController.text

      }),

    );

    if(siswaResponse.statusCode == 200 || siswaResponse.statusCode == 201){

      final siswa = jsonDecode(siswaResponse.body);

      int idSiswa = siswa["idSiswa"];

      /// 2️⃣ simpan siswa_kelas
      await http.post(

        Uri.parse("http://10.0.2.2:8080/api/siswa-kelas"),

        headers: {
          "Content-Type":"application/json"
        },

        body: jsonEncode({

          "idSiswa": idSiswa,
          "idKelas": selectedKelas,
          "idTahunAjaran": tahunAktif!.idTahunAjaran

        }),

      );

      if(context.mounted){

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Siswa berhasil ditambahkan")),
        );

        Navigator.pop(context);

      }

    }

    setState(() {
      isLoading = false;
    });

  }

  Widget field(String label, TextEditingController controller){

    return Padding(
      padding: const EdgeInsets.only(bottom:15),

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
        title: const Text("Tambah Siswa"),
      ),

      body: ListView(

        padding: const EdgeInsets.all(20),

        children: [

          field("Nama Siswa", namaController),
          field("NISN", nisnController),
          field("Tempat Lahir", tempatLahirController),
          field("Tanggal Lahir", tanggalLahirController),
          field("Alamat", alamatController),

          const SizedBox(height:10),

          DropdownButtonFormField<String>(

            value: selectedKelas,

            items: listKelas.map((kelas){

              return DropdownMenuItem(
                value: kelas.idKelas,
                child: Text(kelas.namaKelas),
              );

            }).toList(),

            onChanged: (value){
              setState(() {
                selectedKelas = value;
              });
            },

            decoration: const InputDecoration(
              labelText: "Pilih Kelas",
              border: OutlineInputBorder(),
            ),

          ),

          const SizedBox(height:30),

          SizedBox(

            height:50,

            child: ElevatedButton(

              onPressed: isLoading ? null : tambahSiswa,

              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("SIMPAN"),

            ),

          )

        ],

      ),

    );

  }

}
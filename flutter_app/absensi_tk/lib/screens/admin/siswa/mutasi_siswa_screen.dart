import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../models/siswa_detail_model.dart';
import '../../../models/kelas_model.dart';
import '../../../models/tahun_ajaran_model.dart';

class MutasiSiswaScreen extends StatefulWidget {

  final SiswaDetail siswa;

  const MutasiSiswaScreen({
    super.key,
    required this.siswa,
  });

  @override
  State<MutasiSiswaScreen> createState() => _MutasiSiswaScreenState();
}

class _MutasiSiswaScreenState extends State<MutasiSiswaScreen> {

  List<Kelas> listKelas = [];
  TahunAjaran? tahunAktif;

  String? selectedKelas;

  bool isLoading = true;

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

        isLoading = false;

      });

    }

  }

  Future<void> mutasiSiswa() async {

    if(selectedKelas == null || tahunAktif == null) return;

    final response = await http.post(

      Uri.parse("http://10.0.2.2:8080/api/siswa-kelas"),

      headers: {
        "Content-Type":"application/json"
      },

      body: jsonEncode({

        "idSiswa": widget.siswa.idSiswa,
        "idKelas": selectedKelas,
        "idTahunAjaran": tahunAktif!.idTahunAjaran

      }),

    );

    if(response.statusCode == 200 || response.statusCode == 201){

      if(context.mounted){

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Mutasi siswa berhasil")),
        );

        Navigator.pop(context);

      }

    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Mutasi Siswa"),
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(

              padding: const EdgeInsets.all(20),

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(
                    widget.siswa.namaSiswa,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height:5),

                  Text("Kelas sekarang : ${widget.siswa.kelas}"),

                  const SizedBox(height:20),

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
                      labelText: "Pilih Kelas Baru",
                      border: OutlineInputBorder(),
                    ),

                  ),

                  const SizedBox(height:30),

                  SizedBox(

                    width: double.infinity,
                    height: 50,

                    child: ElevatedButton(

                      onPressed: mutasiSiswa,

                      child: const Text("PINDAH KELAS"),

                    ),

                  )

                ],

              ),

            ),

    );

  }

}
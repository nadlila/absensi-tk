import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../models/kelas_model.dart';
import '../../../models/tahun_ajaran_model.dart';
import '../../../models/siswa_detail_model.dart';
import '../../../routes/app_routes.dart';

class DataSiswaScreen extends StatefulWidget {
  const DataSiswaScreen({super.key});

  @override
  State<DataSiswaScreen> createState() => _DataSiswaScreenState();
}

class _DataSiswaScreenState extends State<DataSiswaScreen> {

  List<Kelas> listKelas = [];
  List<SiswaDetail> listSiswa = [];

  TahunAjaran? tahunAktif;
  String? selectedKelas;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {

    setState(() {
      isLoading = true;
    });

    await fetchTahunAktif();
    await fetchKelas();
    await fetchSiswa();

  }

  Future<void> fetchTahunAktif() async {

    final response = await http.get(
      Uri.parse("http://10.0.2.2:8080/api/tahun-ajaran/aktif"),
    );

    if(response.statusCode == 200){

      final data = jsonDecode(response.body);

      tahunAktif = TahunAjaran.fromJson(data);

    }

  }

  Future<void> fetchKelas() async {

    final response = await http.get(
      Uri.parse("http://10.0.2.2:8080/api/kelas"),
    );

    if(response.statusCode == 200){

      List data = jsonDecode(response.body);

      listKelas = data.map((e) => Kelas.fromJson(e)).toList();

      if(listKelas.isNotEmpty){
        selectedKelas = listKelas.first.idKelas;
      }

    }

  }

  Future<void> fetchSiswa() async {

    if(selectedKelas == null || tahunAktif == null) return;

    final response = await http.get(
      Uri.parse(
        "http://10.0.2.2:8080/api/siswa-kelas/filter?idKelas=$selectedKelas&idTahun=${tahunAktif!.idTahunAjaran}",
      ),
    );

    if(response.statusCode == 200){

      List data = jsonDecode(response.body);

      setState(() {

        listSiswa = data.map((e) => SiswaDetail.fromJson(e)).toList();
        isLoading = false;

      });

    } else {

      setState(() {
        isLoading = false;
      });

    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Data Siswa"),
      ),

      body: Column(

        children: [

          if(tahunAktif != null)
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text(
                  "Tahun : ${tahunAktif!.tahun}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                Text(
                  "Semester : ${tahunAktif!.semester}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )

              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),

            child: DropdownButtonFormField<String>(

              value: selectedKelas,

              items: listKelas.map((kelas) {

                return DropdownMenuItem<String>(
                  value: kelas.idKelas,
                  child: Text(kelas.namaKelas),
                );

              }).toList(),

              onChanged: (value){

                setState(() {
                  selectedKelas = value;
                });

                fetchSiswa();

              },

              decoration: const InputDecoration(
                labelText: "Pilih Kelas",
                border: OutlineInputBorder(),
              ),

            ),

          ),

          const SizedBox(height: 10),

          Expanded(

            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : listSiswa.isEmpty
                    ? const Center(child: Text("Tidak ada siswa"))
                    : RefreshIndicator(

                        onRefresh: fetchSiswa,

                        child: ListView.builder(

                          itemCount: listSiswa.length,

                          itemBuilder: (context, index){

                            final siswa = listSiswa[index];

                            return Card(

                              margin: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 8,
                              ),

                              child: ListTile(

                                leading: const CircleAvatar(
                                  child: Icon(Icons.school),
                                ),

                                title: Text(siswa.namaSiswa),

                                subtitle: Text("NISN : ${siswa.nisn}"),

                                trailing: const Icon(Icons.arrow_forward_ios),

                                onTap: (){

                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.detailSiswa,
                                    arguments: siswa,
                                  );

                                },

                              ),

                            );

                          },

                        ),

                      ),

          )

        ],

      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.tambahSiswa);
        },
        child: const Icon(Icons.add),
      ),

    );

  }

}
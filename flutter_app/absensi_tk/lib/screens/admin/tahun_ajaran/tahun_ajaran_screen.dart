import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../routes/app_routes.dart';

import '../../../models/tahun_ajaran_model.dart';

class TahunAjaranScreen extends StatefulWidget {
  const TahunAjaranScreen({super.key});

  @override
  State<TahunAjaranScreen> createState() => _TahunAjaranScreenState();
}

class _TahunAjaranScreenState extends State<TahunAjaranScreen> {

  List<TahunAjaran> listTahun = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTahun();
  }

  Future<void> fetchTahun() async {

    final response = await http.get(
      Uri.parse("http://10.0.2.2:8080/api/tahun-ajaran"),
    );

    if(response.statusCode == 200){

      List data = jsonDecode(response.body);

      setState(() {

        listTahun =
            data.map((e) => TahunAjaran.fromJson(e)).toList();

        isLoading = false;

      });

    }

  }

  Future<void> aktifkanTahun(int id) async {

    await http.put(
      Uri.parse("http://10.0.2.2:8080/api/tahun-ajaran/aktif/$id"),
    );

    fetchTahun();

  }

  //Future<void> naikKelas() async {

  //await http.post(
    //Uri.parse(
      //"http://10.0.2.2:8080/api/siswa-kelas/naik-kelas/${tahunAktif.idTahunAjaran}"
    //),
  //);

  //if(context.mounted){

    //ScaffoldMessenger.of(context).showSnackBar(
      //const SnackBar(
        //content: Text("Siswa berhasil dinaikkan kelas"),
      //),
    //);

  //}

//}



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Tahun Ajaran"),
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(

              itemCount: listTahun.length,

              itemBuilder: (context,index){

                final tahun = listTahun[index];

                return Card(

                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),

                  child: ListTile(

                    title: Text(
                      "${tahun.tahun} - Semester ${tahun.semester}",
                    ),

                    subtitle: Text(
                      tahun.status == "aktif"
                          ? "Aktif"
                          : "Tidak Aktif",
                    ),

                    trailing: tahun.status == "aktif"
                        ? const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          )
                        : ElevatedButton(

                            onPressed: (){
                              aktifkanTahun(tahun.idTahunAjaran);
                            },

                            child: const Text("Aktifkan"),

                          ),

                  ),

                );

              },

            ),

      floatingActionButton: FloatingActionButton(

      onPressed: (){

        Navigator.pushNamed(
          context,
          AppRoutes.tambahTahunAjaran,
        ).then((_) {

          fetchTahun();
        });
      },
      child: const Icon(Icons.add),

    ),
    
    );
    

  }

}
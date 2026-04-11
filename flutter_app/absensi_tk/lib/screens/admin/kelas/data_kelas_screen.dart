import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../models/kelas_detail_model.dart';
import '../../../routes/app_routes.dart';

class DataKelasScreen extends StatefulWidget {
  const DataKelasScreen({super.key});

  @override
  State<DataKelasScreen> createState() => _DataKelasScreenState();
}

class _DataKelasScreenState extends State<DataKelasScreen> {

  List<KelasDetail> listKelas = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchKelas();
  }

  Future<void> fetchKelas() async {

    final response = await http.get(
      Uri.parse("http://10.0.2.2:8080/api/kelas-guru/detail"),
    );

    if(response.statusCode == 200){

      List data = jsonDecode(response.body);

      setState(() {

        listKelas =
            data.map((e) => KelasDetail.fromJson(e)).toList();

        isLoading = false;

      });

    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Data Kelas"),
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(

              itemCount: listKelas.length,

              itemBuilder: (context,index){

                final kelas = listKelas[index];

                return Card(

                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),

                  child: ListTile(

                    leading: const CircleAvatar(
                      child: Icon(Icons.class_),
                    ),

                    title: Text(kelas.namaKelas),

                    subtitle: Text(
                      "Wali Kelas : ${kelas.waliKelas}",
                    ),

                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),

                    onTap: (){

                      Navigator.pushNamed(
                        context,
                        AppRoutes.detailKelas,
                        arguments: kelas,
                      );

                    },

                  ),

                );

              },

            ),

    );

  }

}
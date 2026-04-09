import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../models/guru_model.dart';
import '../../../routes/app_routes.dart';

class DataGuruScreen extends StatefulWidget {
  const DataGuruScreen({super.key});

  @override
  State<DataGuruScreen> createState() => _DataGuruScreenState();
}

class _DataGuruScreenState extends State<DataGuruScreen> {

  List<Guru> listGuru = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchGuru();
  }

  Future<void> fetchGuru() async {

    try {

      final response = await http.get(
        Uri.parse("http://10.0.2.2:8080/api/guru"),
      );

      if (response.statusCode == 200) {

        List data = jsonDecode(response.body);

        setState(() {
          listGuru = data.map((e) => Guru.fromJson(e)).toList();
          isLoading = false;
        });

      }

    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Data Guru"),
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : listGuru.isEmpty
              ? const Center(
                  child: Text("Belum ada data guru"),
                )
              : ListView.builder(
                  itemCount: listGuru.length,
                  itemBuilder: (context, index) {

                    final guru = listGuru[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),

                      child: ListTile(

                        leading: const CircleAvatar(
                          child: Icon(Icons.person),
                        ),

                        title: Text(guru.namaGuru),

                        subtitle: Text("NUPTK: ${guru.nuptk}"),

                        trailing: const Icon(Icons.arrow_forward_ios),

                        onTap: () {

                          Navigator.pushNamed(
                            context,
                            AppRoutes.detailGuru,
                            arguments: guru,
                          );

                        },

                      ),
                    );
                  },
                ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Navigator.pushNamed(
            context,
            AppRoutes.tambahGuru,
          );

        },
        child: const Icon(Icons.add),
      ),

    );

  }

}
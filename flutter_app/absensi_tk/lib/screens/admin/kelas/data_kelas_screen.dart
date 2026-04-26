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

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse("http://10.0.2.2:8080/api/kelas-guru/detail"),
      );

      if (response.statusCode == 200) {

        List data = jsonDecode(response.body);

        setState(() {
          listKelas =
              data.map((e) => KelasDetail.fromJson(e)).toList();

          // 🔥 SORT A-Z
          listKelas.sort((a, b) => a.namaKelas.compareTo(b.namaKelas));

          isLoading = false;
        });

      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }

  }

  // 🔥 Pull to refresh
  Future<void> refreshData() async {
    await fetchKelas();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Data Kelas"),
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(

              onRefresh: refreshData,

              child: listKelas.isEmpty
                  ? const Center(child: Text("Tidak ada data"))
                  : ListView.builder(

                      itemCount: listKelas.length,

                      itemBuilder: (context, index) {

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

                            onTap: () async {

                              final result = await Navigator.pushNamed(
                                context,
                                AppRoutes.detailKelas,
                                arguments: kelas,
                              );

                              if (result == true) {
                                fetchKelas();
                              }

                            },

                          ),

                        );

                      },

                    ),

            ),

      // ✅ FIX: gabungkan 2 FAB
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          FloatingActionButton(
            heroTag: "setupKelas",
            onPressed: () async {
              final result = await Navigator.pushNamed(
                context,
                AppRoutes.setupKelasTahun,
              );

              if (result == true) {
                fetchKelas();
              }
            },
            child: const Icon(Icons.settings),
          ),

          const SizedBox(height: 10),

          FloatingActionButton(
            heroTag: "tambahKelas",
            onPressed: () async {
              final result = await Navigator.pushNamed(
                context,
                AppRoutes.tambahKelas,
              );

              if (result == true) {
                fetchKelas(); // refresh
              }
            },
            child: const Icon(Icons.add),
          ),

        ],
      ),

    );

  }

}
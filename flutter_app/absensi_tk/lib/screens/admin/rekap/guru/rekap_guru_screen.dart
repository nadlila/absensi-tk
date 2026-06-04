import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../routes/app_routes.dart';
import '../../../../services/api_config.dart';

class RekapGuruScreen extends StatefulWidget {
  const RekapGuruScreen({super.key});

  @override
  State<RekapGuruScreen> createState() => _RekapGuruScreenState();
}

class _RekapGuruScreenState extends State<RekapGuruScreen> {
  List tahunList = [];
  List rekapList = [];

  dynamic selectedTahun;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchTahunAjaran();
  }

  // ================= GET TAHUN AJARAN =================
  Future fetchTahunAjaran() async {
    final res = await http.get(
      Uri.parse(
        "${ApiConfig.baseUrl}/tahun-ajaran",
      ),
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);

      setState(() {
        tahunList = data;
      });
    }
  }

  // ================= GET REKAP =================
  Future fetchRekapGuru() async {
    if (selectedTahun == null) return;

    setState(() {
      isLoading = true;
    });

    final idTahun = selectedTahun["idTahunAjaran"];

    final res = await http.get(
      Uri.parse(
        "${ApiConfig.baseUrl}/absensi-guru/rekap/$idTahun",
      ),
    );

    if (res.statusCode == 200) {
      setState(() {
        rekapList = jsonDecode(res.body);
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rekap Guru"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ================= DROPDOWN TAHUN =================
            DropdownButtonFormField(
              value: selectedTahun,
              decoration: const InputDecoration(
                labelText: "Pilih Tahun Ajaran",
                border: OutlineInputBorder(),
              ),
              items: tahunList.map((tahun) {
                return DropdownMenuItem(
                  value: tahun,
                  child: Text(
                    "${tahun["tahun"]} - ${tahun["semester"]}",
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedTahun = value;
                });

                fetchRekapGuru();
              },
            ),

            const SizedBox(height: 20),

            // ================= LOADING =================
            if (isLoading)
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )

            // ================= DATA =================
            else if (rekapList.isEmpty)
              const Expanded(
                child: Center(
                  child: Text(
                    "Belum ada data rekap",
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: rekapList.length,
                  itemBuilder: (context, index) {
                    final data = rekapList[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.detailRekapGuruAdmin,
                            arguments: {
                              "idGuru": data["idGuru"],
                              "namaGuru": data["namaGuru"],
                              "idTahun": selectedTahun["idTahunAjaran"],
                            },
                          );
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    data["namaGuru"],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Icon(Icons.chevron_right, color: Colors.grey),
                                ],
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  buildItem(
                                    "Hadir",
                                    data["hadir"].toString(),
                                    Colors.green,
                                  ),
                                  buildItem(
                                    "Izin",
                                    data["izin"].toString(),
                                    Colors.orange,
                                  ),
                                  buildItem(
                                    "Sakit",
                                    data["sakit"].toString(),
                                    Colors.blue,
                                  ),
                                  buildItem(
                                    "Alpa",
                                    data["alpa"].toString(),
                                    Colors.red,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
          ],
        ),
      ),
    );
  }

  // ================= CARD ITEM =================
  Widget buildItem(
    String title,
    String value,
    Color color,
  ) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 5),
        Text(title),
      ],
    );
  }
}

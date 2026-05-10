import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
        "http://10.0.2.2:8080/api/tahun-ajaran",
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
        "http://10.0.2.2:8080/api/absensi-guru/rekap/$idTahun",
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

                      child: Padding(
                        padding: const EdgeInsets.all(16),

                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            Text(
                              data["namaGuru"],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const Divider(),

                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,

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
                                  "Alfa",
                                  data["alfa"].toString(),
                                  Colors.red,
                                ),

                              ],
                            )

                          ],
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
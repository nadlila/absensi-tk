import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../services/api_config.dart';

class RekapSiswaScreen extends StatefulWidget {
  const RekapSiswaScreen({super.key});

  @override
  State<RekapSiswaScreen> createState() => _RekapSiswaScreenState();
}

class _RekapSiswaScreenState extends State<RekapSiswaScreen> {

  List kelasList = [];
  List tahunList = [];
  List rekapList = [];

  dynamic selectedKelas;
  dynamic selectedTahun;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    fetchKelas();
    fetchTahunAjaran();
  }

  Future fetchKelas() async {

    final res = await http.get(
      Uri.parse(
        "${ApiConfig.baseUrl}/kelas",
      ),
    );

    if (res.statusCode == 200) {

      setState(() {
        kelasList = jsonDecode(res.body);
      });

    }

  }

  Future fetchTahunAjaran() async {

    final res = await http.get(
      Uri.parse(
        "${ApiConfig.baseUrl}/tahun-ajaran",
      ),
    );

    if (res.statusCode == 200) {

      setState(() {
        tahunList = jsonDecode(res.body);
      });

    }

  }

  Future fetchRekap() async {

    if (selectedKelas == null || selectedTahun == null) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    final idKelas = selectedKelas["idKelas"];
    final idTahun = selectedTahun["idTahunAjaran"];

    final res = await http.get(
      Uri.parse(
        "${ApiConfig.baseUrl}/absensi-siswa/rekap"
        "?idKelas=$idKelas"
        "&idTahun=$idTahun",
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Rekap Siswa"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            DropdownButtonFormField(

              value: selectedKelas,

              decoration: const InputDecoration(
                labelText: "Pilih Kelas",
                border: OutlineInputBorder(),
              ),

              items: kelasList.map((kelas) {

                return DropdownMenuItem(
                  value: kelas,
                  child: Text(
                    kelas["namaKelas"],
                  ),
                );

              }).toList(),

              onChanged: (value) {

                setState(() {
                  selectedKelas = value;
                });

                fetchRekap();

              },
            ),

            const SizedBox(height: 16),

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

                fetchRekap();

              },
            ),

            const SizedBox(height: 20),

            if (isLoading)

              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )

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
                              data["namaSiswa"],
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
                                  "Alpa",
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

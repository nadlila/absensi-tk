import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SetupKelasTahunScreen extends StatefulWidget {
  const SetupKelasTahunScreen({super.key});

  @override
  State<SetupKelasTahunScreen> createState() => _SetupKelasTahunScreenState();
}

class _SetupKelasTahunScreenState extends State<SetupKelasTahunScreen> {

  List kelasList = [];
  List guruList = [];

  Map<String, int?> selectedGuru = {}; // idKelas -> idGuru

  int? idTahunAjaran;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchTahunAjaranAktif();
  }

  Future<void> fetchData() async {

    final kelasRes = await http.get(
      Uri.parse("http://10.0.2.2:8080/api/kelas"),
    );

    final guruRes = await http.get(
      Uri.parse("http://10.0.2.2:8080/api/guru"),
    );

    if (kelasRes.statusCode == 200 && guruRes.statusCode == 200) {

      setState(() {

        kelasList = jsonDecode(kelasRes.body);
        guruList = jsonDecode(guruRes.body);

        for (var k in kelasList) {
          selectedGuru[k['idKelas']] = null;
        }

        isLoading = false;

      });

    }
  }

  Future<void> fetchTahunAjaranAktif() async {

    final response = await http.get(
      Uri.parse("http://10.0.2.2:8080/api/tahun-ajaran/aktif"),
    );

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      setState(() {
        idTahunAjaran = data['idTahunAjaran'];
      });

      print("🔥 Tahun aktif: $idTahunAjaran");

    }
  }

  Future<void> simpan() async {

    // 🔥 safety check supaya tidak error null
    if (idTahunAjaran == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Tahun ajaran aktif belum dimuat"),
        ),
      );
      return;
    }

    for (var k in kelasList) {

      final idKelas = k['idKelas'];
      final idGuru = selectedGuru[idKelas];

      if (idGuru != null) {

        await http.post(
          Uri.parse("http://10.0.2.2:8080/api/kelas-guru"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "idKelas": idKelas,
            "idGuru": idGuru,
            "idTahunAjaran": idTahunAjaran
          }),
        );

      }

    }

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Data berhasil disimpan")),
      );
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

  appBar: AppBar(
    title: const Text("Setup Kelas Tahun Ajaran"),
  ),

  body: isLoading
      ? const Center(child: CircularProgressIndicator())
      : Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              Expanded(
                child: ListView.builder(
                   padding: const EdgeInsets.only(bottom: 100),
                  itemCount: kelasList.length,
                  itemBuilder: (context, index) {
                    final kelas = kelasList[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              kelas['namaKelas'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            DropdownButtonFormField<int>(
                              value: selectedGuru[kelas['idKelas']],
                              items: guruList.map<DropdownMenuItem<int>>((g) {
                                return DropdownMenuItem(
                                  value: g['idGuru'],
                                  child: Text(g['namaGuru']),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedGuru[kelas['idKelas']] = value;
                                });
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Pilih Guru",
                              ),
                            )

                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

            ],
          ),
        ),

  // 🔥 INI BAGIAN FLOAT BUTTON
  floatingActionButton: Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 50,

      child: FloatingActionButton.extended(
        onPressed: simpan,
        label: const Text(
          "SIMPAN",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ),
  ),

  floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,
);

  }
}
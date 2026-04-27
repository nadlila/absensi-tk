import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/kelas_detail_model.dart';
import '../../models/siswa_detail_model.dart';

class AbsenSiswaScreen extends StatefulWidget {
  final KelasDetail? kelas;

  const AbsenSiswaScreen({super.key, this.kelas});

  @override
  State<AbsenSiswaScreen> createState() => _AbsenSiswaScreenState();
}

class _AbsenSiswaScreenState extends State<AbsenSiswaScreen> {
  List<SiswaDetail> listSiswa = [];
  Map<int, String> absensi = {};

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    if (widget.kelas != null) {
      fetchSiswa();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchSiswa() async {
  try {
    final kelas = widget.kelas;

    if (kelas == null) {
      setState(() => isLoading = false);
      return;
    }

    final url =
        "http://10.0.2.2:8080/api/siswa-kelas/filter"
        "?idKelas=${kelas.idKelas}"
        "&idTahun=${kelas.idTahunAjaran}";

    print("URL: $url");

    final response = await http.get(Uri.parse(url)); 

    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      setState(() {
        listSiswa =
            data.map((e) => SiswaDetail.fromJson(e)).toList();

        absensi.clear();
        for (var s in listSiswa) {
          absensi[s.idSiswa] = "hadir";
        }

        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
    }
  } catch (e) {
    print("ERROR: $e");
    setState(() => isLoading = false);
  }
}

  Future<void> simpanAbsensi() async {
    List data = absensi.entries.map((e) {
      return {
        "idSiswa": e.key,
        "idKelas": widget.kelas!.idKelas,
        "status": e.value,
        "tanggal": DateTime.now().toString().substring(0, 10),
        "idTahunAjaran": widget.kelas!.idTahunAjaran
      };
    }).toList();

    final response = await http.post(
      Uri.parse("http://10.0.2.2:8080/api/absensi-siswa"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Absensi berhasil disimpan")),
      );
    }
  }

  Widget radioItem(int idSiswa, String value, String label) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: absensi[idSiswa],
          onChanged: (val) {
            setState(() {
              absensi[idSiswa] = val!;
            });
          },
        ),
        Text(label),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.kelas == null) {
      return const Scaffold(
        body: Center(
          child: Text("Anda tidak memiliki kelas untuk absensi siswa"),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Absen ${widget.kelas!.namaKelas}"),
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: listSiswa.length,
                    itemBuilder: (context, index) {
                      final siswa = listSiswa[index];

                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          title: Text(siswa.namaSiswa),
                          subtitle: Row(
                            children: [
                              radioItem(siswa.idSiswa, "hadir", "Hadir"),
                              radioItem(siswa.idSiswa, "izin", "Izin"),
                              radioItem(siswa.idSiswa, "alfa", "Alfa"),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: simpanAbsensi,
                      child: const Text("SIMPAN ABSENSI"),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
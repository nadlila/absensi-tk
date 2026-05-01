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
      isLoading = false;
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

      final response = await http.get(Uri.parse(url));

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
        isLoading = false;
      }
    } catch (e) {
      print("ERROR FETCH: $e");
      isLoading = false;
    }
  }

  // 🔥 FIX: mapping status ke id
  int getStatusId(String status) {
    switch (status) {
      case "hadir":
        return 1;
      case "izin":
        return 2;
      case "sakit":
        return 3;
      case "alfa":
        return 4;
      default:
        return 1;
    }
  }

  Future<void> simpanAbsensi() async {
    List data = absensi.entries.map((e) {
      return {
        "idSiswa": e.key,
        "idKelas": widget.kelas!.idKelas,
        "idStatus": getStatusId(e.value), // ✅ FIX
        "tanggal": DateTime.now().toString().substring(0, 10),
        "idTahunAjaran": widget.kelas!.idTahunAjaran
      };
    }).toList();

    final response = await http.post(
      Uri.parse("http://10.0.2.2:8080/api/absensi-siswa"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    print("STATUS SIMPAN: ${response.statusCode}");
    print("BODY: ${response.body}");

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Absensi berhasil disimpan")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal simpan absensi")),
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
          child: Text("Anda tidak memiliki kelas"),
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
                  child: ElevatedButton(
                    onPressed: simpanAbsensi,
                    child: const Text("SIMPAN ABSENSI"),
                  ),
                ),
              ],
            ),
    );
  }
}
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

  // Mapping status ke id sesuai database
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

  String getFormatTanggal() {
    DateTime now = DateTime.now();
    List<String> hari = ["Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu", "Minggu"];
    List<String> bulan = [
      "Januari", "Februari", "Maret", "April", "Mei", "Juni",
      "Juli", "Agustus", "September", "Oktober", "November", "Desember"
    ];

    String namaHari = hari[now.weekday - 1];
    String namaBulan = bulan[now.month - 1];

    return "$namaHari, ${now.day} $namaBulan ${now.year}";
  }

  Future<void> simpanAbsensi() async {
    List data = absensi.entries.map((e) {
      return {
        "idSiswa": e.key,
        "idKelas": widget.kelas!.idKelas,
        "idStatus": getStatusId(e.value),
        "tanggal": DateTime.now().toString().substring(0, 10),
        "idTahunAjaran": widget.kelas!.idTahunAjaran
      };
    }).toList();

    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:8080/api/absensi-siswa"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (mounted) {
          if (responseData['skipped'] != null && responseData['skipped'] > 0) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Pemberitahuan"),
                content: const Text(
                    "Absensi untuk hari ini sudah pernah dilakukan. Data baru tidak dicatat."),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("OK"),
                  ),
                ],
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Absensi berhasil disimpan")),
            );
            Navigator.pop(context);
          }
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Gagal simpan absensi")),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Terjadi kesalahan: $e")),
        );
      }
    }
  }

  Widget radioItem(int idSiswa, String value, String label, Color activeColor) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio(
          value: value,
          groupValue: absensi[idSiswa],
          activeColor: activeColor,
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Absen ${widget.kelas!.namaKelas}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color(0xFFB6DEE8),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: Text(
                    getFormatTanggal(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: listSiswa.length,
                    itemBuilder: (context, index) {
                      final siswa = listSiswa[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        elevation: 1,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          title: Text(siswa.namaSiswa, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                radioItem(siswa.idSiswa, "hadir", "Hadir", const Color(0xFFF58220)),
                                radioItem(siswa.idSiswa, "izin", "Izin", Colors.blue),
                                radioItem(siswa.idSiswa, "sakit", "Sakit", Colors.green),
                                radioItem(siswa.idSiswa, "alfa", "Alfa", Colors.red),
                              ],
                            ),
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF58220),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: simpanAbsensi,
                      child: const Text("SIMPAN ABSENSI", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

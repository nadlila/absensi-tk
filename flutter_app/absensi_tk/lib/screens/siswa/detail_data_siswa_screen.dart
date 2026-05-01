import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/siswa_detail_model.dart';

class DetailDataSiswaScreen extends StatefulWidget {
  final int idSiswa;

  const DetailDataSiswaScreen({
    super.key,
    required this.idSiswa,
  });

  @override
  State<DetailDataSiswaScreen> createState() =>
      _DetailDataSiswaScreenState();
}

class _DetailDataSiswaScreenState
    extends State<DetailDataSiswaScreen> {

  SiswaDetail? siswa;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
     print("🔥 MASUK DETAIL SISWA ID: ${widget.idSiswa}");
    fetchDetail();
  }

  Future<void> fetchDetail() async {
    final url =
        "http://10.0.2.2:8080/api/siswa/detail/${widget.idSiswa}";

    print("URL DETAIL: $url");
    print("GET DETAIL: $url");

    final res = await http.get(Uri.parse(url));

    print("STATUS: ${res.statusCode}");
    print("BODY: ${res.body}");

    if (res.statusCode == 200) {
      setState(() {
        siswa = SiswaDetail.fromJson(jsonDecode(res.body));
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget item(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        "$label: $value",
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (siswa == null) {
      return const Scaffold(
        body: Center(child: Text("Data tidak ditemukan")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(siswa!.namaSiswa),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            item("Nama", siswa!.namaSiswa),
            item("NISN", siswa!.nisn ?? "-"),
            item("Tempat Lahir", siswa!.tempatLahir ?? "-"),
            item("Tanggal Lahir", siswa!.tanggalLahir ?? "-"),
            item("Alamat", siswa!.alamat ?? "-"),
            item("Kelas", siswa!.namaKelas ?? "-"),
            item("Tahun", siswa!.tahun ?? "-"),
            item("Semester", siswa!.semester ?? "-"),
          ],
        ),
      ),
    );
  }
}
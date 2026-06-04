import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/siswa_detail_model.dart';
import '../../services/api_config.dart';

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
    fetchDetail();
  }

  Future<void> fetchDetail() async {
    final url =
        "${ApiConfig.baseUrl}/siswa/detail/${widget.idSiswa}";

    final res = await http.get(Uri.parse(url));

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

  Widget buildRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),

          const Text(
            ":",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (siswa == null) {
      return const Scaffold(
        body: Center(
          child: Text("Data tidak ditemukan"),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text(
          "Detail Data Siswa",
          style: TextStyle(
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

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              buildRow("Nama", siswa!.namaSiswa),
              buildRow("NISN", siswa!.nisn ?? "-"),
              buildRow("Tempat Lahir", siswa!.tempatLahir ?? "-"),
              buildRow("Tanggal Lahir", siswa!.tanggalLahir ?? "-"),
              buildRow("Alamat", siswa!.alamat ?? "-"),
              buildRow("Kelas", siswa!.namaKelas ?? "-"),
              buildRow("Tahun", siswa!.tahun ?? "-"),
              buildRow("Semester", siswa!.semester ?? "-"),
            ],
          ),
        ),
      ),
    );
  }
}

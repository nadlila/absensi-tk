import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/detail_absensi_model.dart';
import '../../models/siswa_detail_model.dart';
import '../../models/kelas_detail_model.dart';

class DetailAbsenSiswaScreen extends StatefulWidget {
  final SiswaDetail siswa;
  final KelasDetail kelas;

  const DetailAbsenSiswaScreen({
    super.key,
    required this.siswa,
    required this.kelas,
  });

  @override
  State<DetailAbsenSiswaScreen> createState() =>
      _DetailAbsenSiswaScreenState();
}

class _DetailAbsenSiswaScreenState
    extends State<DetailAbsenSiswaScreen> {

  List<DetailAbsensi> list = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url =
        "http://10.0.2.2:8080/api/absensi-siswa/detail-siswa"
        "?idSiswa=${widget.siswa.idSiswa}"
        "&idTahun=${widget.kelas.idTahunAjaran}";

    final res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);

      setState(() {
        list = data.map((e) => DetailAbsensi.fromJson(e)).toList();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.siswa.namaSiswa),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, i) {
                final d = list[i];

                return Card(
                  child: ListTile(
                    title: Text(d.tanggal),
                    subtitle: Text(d.status),
                    trailing: Text(d.keterangan),
                  ),
                );
              },
            ),
    );
  }
} 
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../routes/app_routes.dart';

import '../../models/kelas_detail_model.dart';
import '../../models/siswa_detail_model.dart';

class DataSiswaGuruScreen extends StatefulWidget {
  final KelasDetail kelas;

  const DataSiswaGuruScreen({super.key, required this.kelas});

  @override
  State<DataSiswaGuruScreen> createState() =>
      _DataSiswaGuruScreenState();
}

class _DataSiswaGuruScreenState
    extends State<DataSiswaGuruScreen> {

  List<SiswaDetail> list = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSiswa();
  }

  Future<void> fetchSiswa() async {
    final url =
        "http://10.0.2.2:8080/api/siswa/kelas/${widget.kelas.idKelas}"
        "?idTahunAjaran=${widget.kelas.idTahunAjaran}";

    final res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);

      setState(() {
        list = data.map((e) => SiswaDetail.fromJson(e)).toList();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Data Siswa ${widget.kelas.namaKelas}",
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
          : ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, i) {
                final s = list[i];

                return Card(
                  child: ListTile(
                    title: Text(s.namaSiswa),
                    subtitle: Text("NISN: ${s.nisn}"),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.detailDataSiswa,
                        arguments: s.idSiswa,
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
} 
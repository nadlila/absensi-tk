import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RekapAbsensiGuruScreen extends StatefulWidget {
  const RekapAbsensiGuruScreen({super.key});

  @override
  State<RekapAbsensiGuruScreen> createState() =>
      _RekapAbsensiGuruScreenState();
}

class _RekapAbsensiGuruScreenState extends State<RekapAbsensiGuruScreen> {
  List data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    final res = await http.get(
      Uri.parse("http://10.0.2.2:8080/api/absensi-guru"),
    );

    setState(() {
      data = jsonDecode(res.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rekap Absensi Guru")),
      body: data.isEmpty
          ? const Center(child: Text("Belum ada data"))
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) {
                final d = data[i];

                return ListTile(
                  title: Text(d["guru"]["namaGuru"]),
                  subtitle: Text(
                    "${d["tanggal"]} - ${d["status"]["namaStatus"]}",
                  ),
                );
              },
            ),
    );
  }
}
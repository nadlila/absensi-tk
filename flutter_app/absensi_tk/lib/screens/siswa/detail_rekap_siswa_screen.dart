import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class DetailRekapSiswaScreen extends StatefulWidget {
  final int siswaId;
  final String namaSiswa;
  final DateTime startDate;
  final DateTime endDate;

  const DetailRekapSiswaScreen({
    super.key,
    required this.siswaId,
    required this.namaSiswa,
    required this.startDate,
    required this.endDate,
  });

  @override
  State<DetailRekapSiswaScreen> createState() =>
      _DetailRekapSiswaScreenState();
}

class _DetailRekapSiswaScreenState
    extends State<DetailRekapSiswaScreen> {

  List detail = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchDetail();
  }

  Future<void> fetchDetail() async {
    setState(() => isLoading = true);

    final url =
        "http://10.0.2.2:8080/api/absensi-siswa/detail"
        "?idSiswa=${widget.siswaId}"
        "&start=${widget.startDate.toString().substring(0, 10)}"
        "&end=${widget.endDate.toString().substring(0, 10)}";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        detail = jsonDecode(response.body);
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
    }
  }

  Future<void> exportPDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [

              pw.Text("REKAP ABSENSI SISWA",
                  style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold)),

              pw.SizedBox(height: 10),

              pw.Text("Nama: ${widget.namaSiswa}"),
              pw.Text(
                  "Periode: ${widget.startDate.toString().substring(0,10)} - ${widget.endDate.toString().substring(0,10)}"),

              pw.SizedBox(height: 15),

              pw.Table.fromTextArray(
                headers: ["Tanggal", "Status"],
                data: detail.map((e) {
                  return [
                    e['tanggal'],
                    e['status'],
                  ];
                }).toList(),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.namaSiswa),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: exportPDF,
          ),
        ],
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : detail.isEmpty
              ? const Center(child: Text("Tidak ada data"))
              : ListView.builder(
                  itemCount: detail.length,
                  itemBuilder: (context, index) {
                    final d = detail[index];

                    return Card(
                      child: ListTile(
                        title: Text(d['tanggal']),
                        subtitle: Text("Status: ${d['status']}"),
                      ),
                    );
                  },
                ),
    );
  }
}
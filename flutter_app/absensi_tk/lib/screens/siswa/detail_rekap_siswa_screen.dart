import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class DetailRekapSiswaScreen extends StatefulWidget {

  final int siswaId;
  final String namaSiswa;

  // 🔥 sekarang pakai tahun ajaran
  final int idTahun;

  const DetailRekapSiswaScreen({
    super.key,
    required this.siswaId,
    required this.namaSiswa,
    required this.idTahun,
  });

  @override
  State<DetailRekapSiswaScreen> createState() =>
      _DetailRekapSiswaScreenState();
}

class _DetailRekapSiswaScreenState
    extends State<DetailRekapSiswaScreen> {

  List detail = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDetail();
  }

  // ================= FETCH DETAIL =================
  Future<void> fetchDetail() async {

    setState(() {
      isLoading = true;
    });

    try {

      final url =
          "http://10.0.2.2:8080/api/absensi-siswa/detail-siswa"
          "?idSiswa=${widget.siswaId}"
          "&idTahun=${widget.idTahun}";

      final response = await http.get(Uri.parse(url));

      print("DETAIL STATUS: ${response.statusCode}");
      print("DETAIL BODY: ${response.body}");

      if (response.statusCode == 200) {

        setState(() {

          detail = jsonDecode(response.body);

          isLoading = false;

        });

      } else {

        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Gagal mengambil detail absensi"),
          ),
        );

      }

    } catch (e) {

      print("ERROR DETAIL: $e");

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Tidak dapat terhubung ke server"),
        ),
      );

    }

  }

  // ================= EXPORT PDF =================
  Future<void> exportPDF() async {

    final pdf = pw.Document();

    pdf.addPage(

      pw.Page(

        build: (context) {

          return pw.Column(

            crossAxisAlignment: pw.CrossAxisAlignment.start,

            children: [

              pw.Text(
                "DETAIL REKAP ABSENSI SISWA",
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 10),

              pw.Text("Nama: ${widget.namaSiswa}"),

              pw.Text("Tahun Ajaran ID: ${widget.idTahun}"),

              pw.SizedBox(height: 20),

              pw.Table.fromTextArray(

                headers: [
                  "Tanggal",
                  "Status",
                  "Keterangan",
                ],

                data: detail.map((e) {

                  return [

                    e["tanggal"] ?? "-",
                    e["status"] ?? "-",
                    e["keterangan"] ?? "-",

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

  // ================= UI =================
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

          ? const Center(
              child: CircularProgressIndicator(),
            )

          : detail.isEmpty

              ? const Center(
                  child: Text(
                    "Tidak ada data absensi",
                  ),
                )

              : ListView.builder(

                  padding: const EdgeInsets.all(12),

                  itemCount: detail.length,

                  itemBuilder: (context, index) {

                    final d = detail[index];

                    return Card(

                      child: ListTile(

                        leading: const Icon(Icons.calendar_month),

                        title: Text(
                          d["tanggal"] ?? "-",
                        ),

                        subtitle: Column(

                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            Text(
                              "Status: ${d["status"] ?? "-"}",
                            ),

                            if (d["keterangan"] != null)
                              Text(
                                "Keterangan: ${d["keterangan"]}",
                              ),

                          ],

                        ),

                      ),

                    );

                  },

                ),

    );

  }

}
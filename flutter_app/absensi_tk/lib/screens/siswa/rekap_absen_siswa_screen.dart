import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart'; 
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../models/kelas_detail_model.dart';
import '../../models/rekap_absensi_model.dart';
import '../../routes/app_routes.dart';
import '../../services/api_config.dart';

class RekapAbsenSiswaScreen extends StatefulWidget {
  final KelasDetail kelas;

  const RekapAbsenSiswaScreen({
    super.key,
    required this.kelas,
  });

  @override
  State<RekapAbsenSiswaScreen> createState() =>
      _RekapAbsenSiswaScreenState();
}

class _RekapAbsenSiswaScreenState
    extends State<RekapAbsenSiswaScreen> {

  List<RekapAbsensi> list = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRekap();
  }

  Future<void> fetchRekap() async {
    setState(() {
      isLoading = true;
    });

    try {
      final url =
          "${ApiConfig.baseUrl}/absensi-siswa/rekap"
          "?idKelas=${widget.kelas.idKelas}"
          "&idTahun=${widget.kelas.idTahunAjaran}";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        setState(() {
          list = data
              .map((e) => RekapAbsensi.fromJson(e))
              .toList();
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
        _showSnackBar("Gagal mengambil data rekap");
      }
    } catch (e) {
      setState(() => isLoading = false);
      _showSnackBar("Tidak dapat terhubung ke server");
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> exportPDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (context) {
          return [
            pw.Header(
              level: 0,
              child: pw.Center(
                child: pw.Text(
                  "REKAP ABSENSI SISWA",
                  style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
                ),
              ),
            ),
            pw.Center(
              child: pw.Text(
                "KELAS: ${widget.kelas.namaKelas.toUpperCase()}",
                style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Table.fromTextArray(
              headers: ["No", "Nama Siswa", "Hadir", "Izin", "Sakit", "Alfa"],
              data: list.asMap().entries.map((entry) {
                int index = entry.key + 1;
                RekapAbsensi d = entry.value;
                return [
                  index.toString(),
                  d.namaSiswa,
                  d.hadir.toString(),
                  d.izin.toString(),
                  d.sakit.toString(),
                  d.alpa.toString(),
                ];
              }).toList(),
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              cellAlignment: pw.Alignment.centerLeft,
              headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300), // Hapus prefix pw. di sini
              cellAlignments: {
                0: pw.Alignment.center,
                2: pw.Alignment.center,
                3: pw.Alignment.center,
                4: pw.Alignment.center,
                5: pw.Alignment.center,
              },
            ),
          ];
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
        title: Text(
          "Rekap ${widget.kelas.namaKelas}",
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: const Color(0xFFB6DEE8),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (!isLoading && list.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.picture_as_pdf, color: Colors.black),
              onPressed: exportPDF,
              tooltip: "Export PDF Satu Kelas",
            ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : list.isEmpty
          ? const Center(child: Text("Belum ada data absensi", style: TextStyle(fontSize: 16)))
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final d = list[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(child: Text(d.namaSiswa[0])),
              title: Text(d.namaSiswa, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text("Hadir: ${d.hadir}   Izin: ${d.izin}   Sakit: ${d.sakit}   Alpa: ${d.alpa}"),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.detailRekapSiswa,
                  arguments: {
                    "idSiswa": d.idSiswa,
                    "namaSiswa": d.namaSiswa,
                    "idTahun": widget.kelas.idTahunAjaran,
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

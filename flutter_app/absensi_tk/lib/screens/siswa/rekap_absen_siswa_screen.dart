import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/kelas_detail_model.dart';
import '../../models/rekap_absensi_model.dart';
import '../../routes/app_routes.dart';

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

  // ================= FETCH REKAP =================
  Future<void> fetchRekap() async {

    setState(() {
      isLoading = true;
    });

    try {

      final url =
          "http://10.0.2.2:8080/api/absensi-siswa/rekap"
          "?idKelas=${widget.kelas.idKelas}"
          "&idTahun=${widget.kelas.idTahunAjaran}";

      final response = await http.get(Uri.parse(url));

      print("REKAP STATUS: ${response.statusCode}");
      print("REKAP BODY: ${response.body}");

      if (response.statusCode == 200) {

        final List data = jsonDecode(response.body);

        setState(() {
          list = data
              .map((e) => RekapAbsensi.fromJson(e))
              .toList();

          isLoading = false;
        });

      } else {

        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Gagal mengambil data rekap"),
          ),
        );

      }

    } catch (e) {

      print("ERROR REKAP: $e");

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

  // ================= UI =================
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(
          "Rekap ${widget.kelas.namaKelas}",
        ),
      ),

      body: isLoading

          ? const Center(
              child: CircularProgressIndicator(),
            )

          : list.isEmpty

              ? const Center(
                  child: Text(
                    "Belum ada data absensi",
                    style: TextStyle(fontSize: 16),
                  ),
                )

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

                        leading: CircleAvatar(
                          child: Text(
                            d.namaSiswa[0],
                          ),
                        ),

                        title: Text(
                          d.namaSiswa,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            "Hadir: ${d.hadir}   "
                            "Izin: ${d.izin}   "
                            "Sakit: ${d.sakit}   "
                            "Alfa: ${d.alfa}",
                          ),
                        ),

                        trailing: const Icon(Icons.arrow_forward_ios),

                        onTap: () {

                          Navigator.pushNamed(

                            context,

                            AppRoutes.detailRekapSiswa,

                            arguments: {

                              "idSiswa": d.idSiswa,
                              "namaSiswa": d.namaSiswa,

                              // 🔥 sekarang pakai tahun ajaran
                              "idTahun":
                                  widget.kelas.idTahunAjaran,

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
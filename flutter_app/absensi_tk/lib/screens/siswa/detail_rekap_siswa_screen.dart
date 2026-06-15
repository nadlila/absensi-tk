import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../services/api_config.dart';

class DetailRekapSiswaScreen extends StatefulWidget {

  final int siswaId;
  final String namaSiswa;

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

  Future<void> fetchDetail() async {

    setState(() {
      isLoading = true;
    });

    try {

      final url =
          "${ApiConfig.baseUrl}/absensi-siswa/detail-siswa"
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.namaSiswa}",
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: const Color(0xFFB6DEE8),


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

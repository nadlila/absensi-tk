import 'dart:convert';
import 'package:flutter/material.dart'; 
import 'package:http/http.dart' as http;

import '../../models/kelas_detail_model.dart';
import '../../models/rekap_absensi_model.dart';
import '../../routes/app_routes.dart';

class RekapAbsenSiswaScreen extends StatefulWidget {
  final KelasDetail kelas;

  const RekapAbsenSiswaScreen({super.key, required this.kelas});

  @override
  State<RekapAbsenSiswaScreen> createState() =>
      _RekapAbsenSiswaScreenState();
}

class _RekapAbsenSiswaScreenState
    extends State<RekapAbsenSiswaScreen> {

  List<RekapAbsensi> list = [];

  DateTime startDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime endDate = DateTime.now();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchRekap();
  }

  Future<void> fetchRekap() async {
    setState(() => isLoading = true);

    final url =
        "http://10.0.2.2:8080/api/absensi-siswa/rekap"
        "?idKelas=${widget.kelas.idKelas}"
        "&start=${startDate.toString().substring(0, 10)}"
        "&end=${endDate.toString().substring(0, 10)}";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      setState(() {
        list = data.map((e) => RekapAbsensi.fromJson(e)).toList();
        isLoading = false;
      });
    }
  }

  Future<void> pickDate(bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? startDate : endDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });

      fetchRekap();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rekap ${widget.kelas.namaKelas}"),
      ),

      body: Column(
        children: [

          // 🔥 FILTER TANGGAL
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => pickDate(true),
                child: Text("Dari: ${startDate.toString().substring(0,10)}"),
              ),
              TextButton(
                onPressed: () => pickDate(false),
                child: Text("Sampai: ${endDate.toString().substring(0,10)}"),
              ),
            ],
          ),

          // 🔥 LIST
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final d = list[index];

                      return Card(
                      child: ListTile(
                        title: Text(d.namaSiswa),
                        subtitle: Text(
                          "H:${d.hadir}  I:${d.izin}  S:${d.sakit}  A:${d.alfa}",
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.detailRekapSiswa,
                            arguments: {
                              "idSiswa": d.idSiswa,
                              "namaSiswa": d.namaSiswa,
                              "startDate": startDate,
                              "endDate": endDate,
                            },
                          );
                        },
                      ),
                    );
                        
                      
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../models/siswa_detail_model.dart';
import '../../../routes/app_routes.dart';
import 'dart:convert';

class DetailSiswaScreen extends StatelessWidget {

  final SiswaDetail siswa;

  const DetailSiswaScreen({
    super.key,
    required this.siswa,
  });

  Widget item(String title, String value){
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 5),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),

            child: Text(value),
          )

        ],
      ),
    );
  }

  // 🔥 KONFIRMASI HAPUS
  void confirmHapus(BuildContext context){
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: const Text("Yakin ingin menghapus siswa ini?"),
        actions: [

          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),

          TextButton(
            onPressed: (){
              Navigator.pop(context);
              hapusSiswa(context);
            },
            child: const Text(
              "Hapus",
              style: TextStyle(color: Colors.red),
            ),
          ),

        ],
      ),
    );
  }

  // 🔥 HAPUS SISWA
  Future<void> hapusSiswa(BuildContext context) async {

    final response = await http.delete(
      Uri.parse("http://10.0.2.2:8080/api/siswa/${siswa.idSiswa}"),
    );

    if(response.statusCode == 200){

      if(context.mounted){

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Siswa berhasil dihapus")),
        );

        // 🔥 KIRIM SIGNAL KE HALAMAN SEBELUMNYA
        Navigator.pop(context, true);

      }

    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal menghapus siswa")),
      );

    }

  }

  // pindah kelas
  Future<List<dynamic>> fetchTahun() async {

  final response = await http.get(
    Uri.parse("http://10.0.2.2:8080/api/tahun-ajaran"),
  );

  if(response.statusCode == 200){
    return jsonDecode(response.body);
  }

  return [];
}

void showNaikKelasDialog(BuildContext context) async {

  String? selectedKelas;
  int? selectedTahun;

  final listTahun = await fetchTahun();

  if(!context.mounted) return;

  showDialog(
    context: context,
    builder: (_) => StatefulBuilder(
      builder: (context, setStateDialog){

        return AlertDialog(

          title: const Text("Naik Kelas"),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              /// 🔽 PILIH KELAS (KHUSUS TK B)
              DropdownButtonFormField<String>(

                items: ["B1","B2","B3","B4"].map((k){
                  return DropdownMenuItem(
                    value: k,
                    child: Text(k),
                  );
                }).toList(),

                onChanged: (value){
                  setStateDialog(() {
                    selectedKelas = value;
                  });
                },

                decoration: const InputDecoration(
                  labelText: "Pilih Kelas Baru",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              /// 🔽 PILIH TAHUN
              DropdownButtonFormField<int>(

                items: listTahun.map<DropdownMenuItem<int>>((t){
                  return DropdownMenuItem(
                    value: t["idTahunAjaran"],
                    child: Text("${t["tahun"]} - ${t["semester"]}"),
                  );
                }).toList(),

                onChanged: (value){
                  setStateDialog(() {
                    selectedTahun = value;
                  });
                },

                decoration: const InputDecoration(
                  labelText: "Pilih Tahun Ajaran",
                  border: OutlineInputBorder(),
                ),
              ),

            ],
          ),

          actions: [

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),

            TextButton(
              onPressed: () async {

                if(selectedKelas == null || selectedTahun == null){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Lengkapi data")),
                  );
                  return;
                }

                await naikKelas(context, selectedKelas!, selectedTahun!);

                Navigator.pop(context, true);

              },
              child: const Text("Naikkan"),
            ),

          ],

        );

      },
    ),
  );
}

Future<void> naikKelas(
  BuildContext context,
  String kelasBaru,
  int tahunBaru
) async {

  final response = await http.post(
    Uri.parse("http://10.0.2.2:8080/api/siswa-kelas/naik-kelas-siswa"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "idSiswa": siswa.idSiswa,
      "idKelas": kelasBaru,
      "idTahunAjaran": tahunBaru
    }),
  );

  if(response.statusCode == 200){

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response.body)),
    );

  } else {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Gagal naik kelas")),
    );

  }
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Detail Siswa"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: ListView(

          children: [

            item("Nama Siswa", siswa.namaSiswa),
            item("NISN", siswa.nisn ?? "-") ,
            item("Kelas", siswa.namaKelas ?? "-"),
            item("Tahun Ajaran", siswa.tahun ?? "-"),
            item("Semester", siswa.semester ?? "-"),

            const SizedBox(height: 20),

            Row(
              children: [

                // 🔵 EDIT
                Expanded(
                  child: ElevatedButton.icon(

                    onPressed: () async {

                      final result = await Navigator.pushNamed(
                        context,
                        AppRoutes.editSiswa,
                        arguments: siswa,
                      );

                      // 🔥 AUTO REFRESH SETELAH EDIT
                      if(result == true){
                        Navigator.pop(context, true);
                      }

                    },

                    icon: const Icon(Icons.edit),
                    label: const Text("Edit"),

                  ),
                ),

                const SizedBox(width: 10),

                // 🔴 HAPUS
                Expanded(
                  child: ElevatedButton.icon(

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),

                    onPressed: (){
                      confirmHapus(context);
                    },

                    icon: const Icon(Icons.delete),
                    label: const Text("Hapus"),

                  ), 
                ),

                const SizedBox(width: 10),

                // 🟠 MUTASI
                Expanded(
                  child: ElevatedButton.icon(

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),

                    onPressed: () async {

                      final result = await Navigator.pushNamed(
                        context,
                        AppRoutes.mutasiSiswa,
                        arguments: siswa,
                      );

                      // 🔥 AUTO REFRESH SETELAH MUTASI
                      if(result == true){
                        Navigator.pop(context, true);
                      }

                    },

                    icon: const Icon(Icons.swap_horiz),
                    label: const Text("Mutasi"),

                  ),
                  
                ),

                const SizedBox(width: 10),

// 🟢 NAIK KELAS
Expanded(
  child: ElevatedButton.icon(

    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green,
    ),

    onPressed: (){
      showNaikKelasDialog(context);
    },

    icon: const Icon(Icons.trending_up),
    label: const Text("Naik"),

  ),
),

              ],
            )

          ],

        ),

      ),

    );

  }

}
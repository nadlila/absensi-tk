import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../models/siswa_detail_model.dart';
import '../../../routes/app_routes.dart';

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

  Future<void> hapusSiswa(BuildContext context) async {

    final response = await http.delete(
      Uri.parse("http://10.0.2.2:8080/api/siswa/${siswa.idSiswa}"),
    );

    if(response.statusCode == 200){

      if(context.mounted){

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Siswa berhasil dihapus")),
        );

        Navigator.pop(context); // keluar detail
        Navigator.pop(context); // kembali ke data siswa

      }

    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal menghapus siswa")),
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
            item("NISN", siswa.nisn),
            item("Kelas", siswa.kelas),
            item("Tahun Ajaran", siswa.tahun),
            item("Semester", siswa.semester),

            const SizedBox(height: 20),

            Row(
              children: [

                Expanded(
                  child: ElevatedButton.icon(

                    onPressed: (){
                      Navigator.pushNamed(
                        context,
                        AppRoutes.editSiswa,
                        arguments: siswa,
                      );
                    },

                    icon: const Icon(Icons.edit),
                    label: const Text("Edit"),

                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton.icon(

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),

                    onPressed: (){
                      hapusSiswa(context);
                    },

                    icon: const Icon(Icons.delete),
                    label: const Text("Hapus"),

                  ), 
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton.icon(

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),

                    onPressed: (){
                      Navigator.pushNamed(
                      context,
                      AppRoutes.mutasiSiswa,
                      arguments: siswa,
                      );
                    },

                    icon: const Icon(Icons.swap_horiz),
                    label: const Text("Mutasi"),

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
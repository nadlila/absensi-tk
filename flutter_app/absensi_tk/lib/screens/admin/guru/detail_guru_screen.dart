import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../models/guru_model.dart';
import '../../../routes/app_routes.dart';

class DetailGuruScreen extends StatelessWidget {

  final Guru guru;

  const DetailGuruScreen({
    super.key,
    required this.guru,
  });

  Future<void> deleteGuru(BuildContext context) async {

    final response = await http.delete(
      Uri.parse("http://10.0.2.2:8080/api/guru/${guru.idGuru}"),
    );

    if (response.statusCode == 200) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Guru berhasil dihapus")),
      );

      Navigator.pop(context);

    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal menghapus guru")),
      );

    }

  }

  Widget item(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),

      child: Row(
        children: [

          SizedBox(
            width: 120,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(child: Text(value)),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Detail Guru"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Center(
              child: CircleAvatar(
                radius: 40,
                child: Text(
                  guru.namaGuru.isNotEmpty
                      ? guru.namaGuru[0]
                      : "?",
                  style: const TextStyle(fontSize: 28),
                ),
              ),
            ),

            const SizedBox(height: 30),

            item("Nama", guru.namaGuru),
            item("NUPTK", guru.nuptk),
            item("Status", guru.status),
            item("Tempat Lahir", guru.tempatLahir),
            item("Tanggal Lahir", guru.tanggalLahir),
            item("Alamat", guru.alamat),
            item("ID User", guru.idUser?.toString() ?? "-"),

            const SizedBox(height: 30),

            Row(
              children: [

                Expanded(
                  child: ElevatedButton.icon(

                    onPressed: () {

                      Navigator.pushNamed(
                        context,
                        AppRoutes.editGuru,
                        arguments: guru,
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

                    onPressed: () {
                      deleteGuru(context);
                    },

                    icon: const Icon(Icons.delete),
                    label: const Text("Hapus"),

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
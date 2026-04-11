import 'package:flutter/material.dart';

import '../../../models/kelas_detail_model.dart';
import '../../../routes/app_routes.dart';

class DetailKelasScreen extends StatelessWidget {

  final KelasDetail kelas;

  const DetailKelasScreen({
    super.key,
    required this.kelas,
  });

  Widget item(String title, String value){

    return Padding(
      padding: const EdgeInsets.only(bottom:15),

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

          const SizedBox(height:5),

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Detail Kelas"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: ListView(

          children: [

            item("Nama Kelas", kelas.namaKelas),

            item("Wali Kelas", kelas.waliKelas),

            item("Tahun Ajaran", kelas.tahun),

            item("Semester", kelas.semester),

            const SizedBox(height:20),

            ElevatedButton.icon(

              onPressed: (){
                Navigator.pushNamed(
                  context,
                  AppRoutes.editWaliKelas,
                  arguments: kelas,
                );
              },

              icon: const Icon(Icons.edit),

              label: const Text("Edit Wali Kelas"),

            )

          ],

        ),

      ),

    );

  }

}
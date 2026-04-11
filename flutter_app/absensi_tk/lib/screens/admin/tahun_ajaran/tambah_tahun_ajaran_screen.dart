import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TambahTahunAjaranScreen extends StatefulWidget {
  const TambahTahunAjaranScreen({super.key});

  @override
  State<TambahTahunAjaranScreen> createState() =>
      _TambahTahunAjaranScreenState();
}

class _TambahTahunAjaranScreenState
    extends State<TambahTahunAjaranScreen> {

  final tahunController = TextEditingController();

  String semester = "1";

  bool isLoading = false;

  Future<void> simpan() async {

    setState(() {
      isLoading = true;
    });

    final response = await http.post(

      Uri.parse("http://10.0.2.2:8080/api/tahun-ajaran"),

      headers: {
        "Content-Type":"application/json"
      },

      body: jsonEncode({

        "tahun": tahunController.text,
        "semester": semester,
        "status": "tidak"

      }),

    );

    setState(() {
      isLoading = false;
    });

    if(response.statusCode == 200 || response.statusCode == 201){

      if(context.mounted){

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Tahun ajaran berhasil ditambah"),
          ),
        );

        Navigator.pop(context);

      }

    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Tambah Tahun Ajaran"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(

              controller: tahunController,

              decoration: const InputDecoration(
                labelText: "Tahun Ajaran",
                hintText: "2026/2027",
                border: OutlineInputBorder(),
              ),

            ),

            const SizedBox(height:20),

            DropdownButtonFormField<String>(

              value: semester,

              items: const [

                DropdownMenuItem(
                  value: "1",
                  child: Text("Semester 1"),
                ),

                DropdownMenuItem(
                  value: "2",
                  child: Text("Semester 2"),
                ),

              ],

              onChanged: (value){
                setState(() {
                  semester = value!;
                });
              },

              decoration: const InputDecoration(
                labelText: "Semester",
                border: OutlineInputBorder(),
              ),

            ),

            const SizedBox(height:30),

            SizedBox(

              width: double.infinity,
              height: 50,

              child: ElevatedButton(

                onPressed: isLoading ? null : simpan,

                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text("SIMPAN"),

              ),

            )

          ],

        ),

      ),

    );

  }

}
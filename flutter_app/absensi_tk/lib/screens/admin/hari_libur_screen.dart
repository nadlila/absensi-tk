import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../services/api_config.dart';

class HariLiburScreen extends StatefulWidget {
  const HariLiburScreen({super.key});

  @override
  State<HariLiburScreen> createState() => _HariLiburScreenState();
}

class _HariLiburScreenState extends State<HariLiburScreen> {
  List listLibur = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHariLibur();
  }

  Future<void> fetchHariLibur() async {
    setState(() => isLoading = true);
    try {
      final res = await http.get(Uri.parse("${ApiConfig.baseUrl}/hari-libur"));
      if (res.statusCode == 200) {
        setState(() {
          listLibur = jsonDecode(res.body);
          listLibur.sort((a, b) => b["tanggal"].compareTo(a["tanggal"]));
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetch libur: $e");
      setState(() => isLoading = false);
    }
  }

  Future<void> tambahLibur() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) return;

    final TextEditingController ketController = TextEditingController();

    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Tambah Hari Libur"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Tanggal: ${DateFormat('yyyy-MM-dd').format(pickedDate)}"),
            const SizedBox(height: 10),
            TextField(
              controller: ketController,
              decoration: const InputDecoration(
                labelText: "Keterangan (misal: Libur Nasional)",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
          ElevatedButton(
            onPressed: () async {
              if (ketController.text.isEmpty) return;
              await simpanLibur(pickedDate, ketController.text);
              Navigator.pop(context);
              fetchHariLibur();
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }

  Future<void> simpanLibur(DateTime tanggal, String ket) async {
    try {
      await http.post(
        Uri.parse("${ApiConfig.baseUrl}/hari-libur"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "tanggal": DateFormat('yyyy-MM-dd').format(tanggal),
          "keterangan": ket,
        }),
      );
    } catch (e) {
      print("Error simpan libur: $e");
    }
  }

  Future<void> hapusLibur(int id) async {
    try {
      await http.delete(Uri.parse("${ApiConfig.baseUrl}/hari-libur/$id"));
      fetchHariLibur();
    } catch (e) {
      print("Error hapus libur: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pengaturan Hari Libur")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : listLibur.isEmpty
              ? const Center(child: Text("Belum ada daftar hari libur"))
              : ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: listLibur.length,
                  itemBuilder: (context, i) {
                    final item = listLibur[i];
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.calendar_today, color: Colors.red),
                        title: Text(item["tanggal"]),
                        subtitle: Text(item["keterangan"]),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => hapusLibur(item["idLibur"]),
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: tambahLibur,
        child: const Icon(Icons.add),
      ),
    );
  }
}

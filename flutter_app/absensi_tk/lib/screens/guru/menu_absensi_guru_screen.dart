import 'package:flutter/material.dart';


class MenuAbsensiGuruScreen extends StatelessWidget {
  const MenuAbsensiGuruScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Absensi Guru")),
      body: Column(
        children: [
          ListTile(
            title: const Text("Absensi"),
            onTap: () {
              Navigator.pushNamed(context, "/guru/absen");
            },
          ),
          ListTile(
            title: const Text("Rekap Absensi"),
            onTap: () {
              Navigator.pushNamed(context, "/guru/rekap");
            },
          ),
        ],
      ),
    );
  }
}
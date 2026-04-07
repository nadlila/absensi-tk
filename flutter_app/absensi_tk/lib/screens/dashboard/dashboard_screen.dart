import 'package:flutter/material.dart';
import '../../widgets/custom_appbar.dart';

import '../guru/absen_guru_screen.dart';
import '../siswa/absen_siswa_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: customAppBar(context, "Dashboard"),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,

          children: [

            menuCard(
              context,
              "Absen Guru",
              Icons.badge,
              const AbsenGuruScreen(),
            ),

            menuCard(
              context,
              "Absen Murid",
              Icons.school,
              const AbsenSiswaScreen(),
            ),

          ],
        ),
      ),
    );
  }

  Widget menuCard(
      BuildContext context,
      String title,
      IconData icon,
      Widget page,
      ) {
    return GestureDetector(

      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ),
        );
      },

      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Icon(icon, size: 50, color: Colors.blue),

            const SizedBox(height: 10),

            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )

          ],
        ),
      ),
    );
  }
}
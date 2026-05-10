import 'package:flutter/material.dart';

import '../../../routes/app_routes.dart';

class MenuRekapScreen extends StatelessWidget {
  const MenuRekapScreen({super.key});

  Widget buildMenuCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    required Color color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),

      child: Container(
        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3)),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              icon,
              size: 50,
              color: color,
            ),

            const SizedBox(height: 15),

            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),

          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Menu Rekap"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: GridView.count(

          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,

          children: [

            // ================= REKAP GURU =================
            buildMenuCard(
              context: context,
              title: "Rekap Guru",
              icon: Icons.badge,
              color: Colors.blue,

              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.rekapGuruAdmin,
                );
              },
            ),

            // ================= REKAP SISWA =================
            buildMenuCard(
              context: context,
              title: "Rekap Siswa",
              icon: Icons.school,
              color: Colors.green,

              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.rekapSiswaAdmin,
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}
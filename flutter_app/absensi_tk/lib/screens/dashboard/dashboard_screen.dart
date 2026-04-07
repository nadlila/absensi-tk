import 'package:flutter/material.dart';
import '../../widgets/custom_appbar.dart';

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
              "Absen Guru",
              Icons.badge,
            ),

            menuCard(
              "Absen Murid",
              Icons.school,
            ),

          ],
        ),
      ),
    );
  }

  Widget menuCard(String title, IconData icon) {
    return Card(
      elevation: 3,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          Icon(icon, size: 50),

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
    );
  }
}
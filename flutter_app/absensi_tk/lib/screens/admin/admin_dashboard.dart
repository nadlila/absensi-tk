import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        centerTitle: true,

        // TOMBOL LOGOUT
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "Logout",
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.login,
                (route) => false,
              );
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1,

          children: [

            _menuCard(
              context,
              icon: Icons.person,
              title: "Data Guru",
              route: AppRoutes.dataGuru,
            ),

            _menuCard(
              context,
              icon: Icons.school,
              title: "Data Siswa",
              route: AppRoutes.dataSiswa,
            ),

            _menuCard(
              context,
              icon: Icons.class_,
              title: "Data Kelas",
              route: AppRoutes.dataKelas,
            ),

            _menuCard(
              context,
              icon: Icons.bar_chart,
              title: "Rekap Absensi",
              route: AppRoutes.rekapAbsensi,
            ),

            _menuCard(
              context,
              icon: Icons.manage_accounts,
              title: "Kelola User",
              route: AppRoutes.kelolaUser,
            ),

            _menuCard(
              context,
              icon: Icons.calendar_month,
              title: "Tahun Ajaran",
              route: AppRoutes.tahunAjaran,
            ),

          ],
        ),
      ),
    );
  }

  Widget _menuCard(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String route,
      }) {

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, route);
      },

      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Icon(
              icon,
              size: 50,
              color: Colors.blue,
            ),

            const SizedBox(height: 10),

            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
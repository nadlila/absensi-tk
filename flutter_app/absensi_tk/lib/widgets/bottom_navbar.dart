import 'package:flutter/material.dart';

import '../models/kelas_detail_model.dart';

import '../screens/dashboard/dashboard_screen.dart';
import '../screens/guru/menu_absensi_guru_screen.dart';
import '../screens/profil/profil_screen.dart';
import '../screens/siswa/menu_absensi_siswa_screen.dart';

class BottomNavbar extends StatefulWidget {
  final KelasDetail? kelas;

  const BottomNavbar({
    super.key,
    this.kelas,
  });

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int currentIndex = 0;

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = [
      DashboardScreen(kelas: widget.kelas),

      const MenuAbsensiGuruScreen(),

      widget.kelas != null
          ? MenuAbsensiSiswaScreen(
        kelas: widget.kelas!,
      )
          : const Center(
        child: Text("Tidak ada kelas"),
      ),

      const ProfilScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      body: pages[currentIndex],

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),

        child: Container(
          height: 65,

          decoration: BoxDecoration(
            color: const Color(0xFFB6DEE8),

            borderRadius: BorderRadius.circular(30),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [

              _navItem(
                icon: Icons.home,
                label: "Home",
                index: 0,
              ),

              _navItem(
                icon: Icons.assignment,
                label: "Absen",
                index: 1,
              ),

              _navItem(
                icon: Icons.school,
                label: "Siswa",
                index: 2,
              ),

              _navItem(
                icon: Icons.person,
                label: "Profil",
                index: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },

      child: SizedBox(
        width: 70,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Icon(
              icon,
              size: isSelected ? 24 : 22,
              color: const Color(0xFFF58220),
            ),

            const SizedBox(height: 4),

            Text(
              label,

              style: TextStyle(
                fontSize: 10,
                fontWeight:
                isSelected
                    ? FontWeight.w600
                    : FontWeight.normal,
                color: const Color(0xFF000000),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
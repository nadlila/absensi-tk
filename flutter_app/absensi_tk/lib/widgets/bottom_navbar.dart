import 'package:flutter/material.dart';
import '../models/kelas_detail_model.dart';

import '../screens/dashboard/dashboard_screen.dart';
import '../screens/guru/absen_guru_screen.dart';
import '../screens/siswa/absen_siswa_screen.dart';
import '../screens/profil/profil_screen.dart';

class BottomNavbar extends StatefulWidget {
  final KelasDetail? kelas;

  const BottomNavbar({super.key, this.kelas});

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
      AbsenGuruScreen(kelas: widget.kelas),
      AbsenSiswaScreen(kelas: widget.kelas),
      const ProfilScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        type: BottomNavigationBarType.fixed,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.badge),
            label: "Guru",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: "Siswa",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}
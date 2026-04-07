import 'package:flutter/material.dart';
import '../screens/notifikasi/notifikasi_screen.dart';

AppBar customAppBar(BuildContext context, String title) {
  return AppBar(
    title: Text(title),

    actions: [

      const Padding(
        padding: EdgeInsets.only(right: 10),
        child: CircleAvatar(
          child: Icon(Icons.person),
        ),
      ),

      IconButton(
        icon: const Icon(Icons.notifications),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NotifikasiScreen(),
            ),
          );
        },
      ),

    ],
  );
}
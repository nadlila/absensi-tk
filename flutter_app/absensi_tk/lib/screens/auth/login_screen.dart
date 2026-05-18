import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/app_routes.dart';
import '../../models/kelas_detail_model.dart';
import '../../services/auth_service.dart';
import '../../services/kelas_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();
  final KelasService kelasService = KelasService();

  bool isPasswordHidden = true;

  Future<void> login() async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Username dan Password wajib diisi")),
      );
      return;
    }

    try {
      final data = await authService.login(
        username: username,
        password: password,
      );
      print("LOGIN RESPONSE: $data");

      if (data["status"] == true) {
        final prefs = await SharedPreferences.getInstance();

        await prefs.setInt("idUser", data["idUser"]);
        await prefs.setString("role", data["role"]);
        await prefs.setString("username", data["username"] ?? "");

        if (data["namaGuru"] != null) {
          await prefs.setString("namaGuru", data["namaGuru"]);
        }
        if (data["idGuru"] != null) {
          await prefs.setInt("idGuru", data["idGuru"]);
        }

        String role = data["role"].toString().toLowerCase();

        if (role.contains("admin")) {
          Navigator.pushReplacementNamed(context, AppRoutes.adminDashboard);
        } else if (role.contains("guru")) {
          int? idGuru = data["idGuru"];
          KelasDetail? kelas;

          if (idGuru != null) {
            try {
              kelas = await kelasService.getKelasAktif(idGuru);
            } catch (e) {
              print("Info: Guru tidak memiliki kelas aktif");
            }
          }

          Navigator.pushReplacementNamed(
            context,
            AppRoutes.dashboard,
            arguments: kelas,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Role tidak dikenali")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"])),
        );
      }
    } catch (e) {
      print("ERROR LOGIN: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Tidak dapat terhubung ke server")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const orangeColor = Color(0xFFF58220);
    const lightBlueColor = Color(0xFFB6DEE8);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              // Logo and School Name
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/logo.png',
                    height: 50,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.school, size: 50, color: orangeColor),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Taman Kanak-kanak",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        "Islam Terpadu Alif",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 60),
              // Greetings
              const Text(
                "Selamat Datang",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: orangeColor,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Silahkan masuk untuk melanjutkan",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              // Form
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Username",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: "Masukkan Username Anda",
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orangeColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Kata Sandi",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: passwordController,
                    obscureText: isPasswordHidden,
                    decoration: InputDecoration(
                      hintText: "..........",
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orangeColor),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              // Login Button
              SizedBox(
                width: 140,
                height: 45,
                child: ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: lightBlueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Masuk",
                    style: TextStyle(
                      color: orangeColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 100),
              // Footer
              const Text(
                "@2026 TK Islam Terpadu Alif",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

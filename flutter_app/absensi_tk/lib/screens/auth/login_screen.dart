import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../widgets/bottom_navbar.dart';
import '../admin/admin_dashboard.dart';
import '../../models/kelas_detail_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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

      final response = await http.post(
        Uri.parse("http://10.0.2.2:8080/api/login"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "username": username,
          "password": password,
        }),
      );

      print("LOGIN STATUS: ${response.statusCode}");
      print("LOGIN BODY: ${response.body}");

      if (response.statusCode == 200) {

        final data = jsonDecode(response.body);

        if (data["status"] == true) {

          String role = data["role"].toString().toLowerCase();

          // ================= ADMIN =================
          if (role.contains("admin")) {

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const AdminDashboard(),
              ),
            );

          }

          // ================= GURU =================
          else if (role.contains("guru")) {

            int? idGuru = data["idGuru"];

            // 🔥 kalau tidak ada idGuru → tetap masuk (tanpa kelas)
            if (idGuru == null) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => BottomNavbar(
                    kelas: null,
                  ),
                ),
              );
              return;
            }

            final kelasRes = await http.get(
              Uri.parse("http://10.0.2.2:8080/api/kelas-guru/guru/$idGuru/detail-aktif"),
            );

            print("STATUS KELAS: ${kelasRes.statusCode}");
            print("BODY KELAS: ${kelasRes.body}");

            KelasDetail? kelas;

            if (kelasRes.statusCode == 200 && kelasRes.body != "null") {
              final kelasData = jsonDecode(kelasRes.body);
              kelas = KelasDetail.fromJson(kelasData);
            }

            // 🔥 SELALU MASUK (walaupun kelas null)
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavbar(
                  kelas: kelas,
                ),
              ),
            );

          }

          // ================= ROLE TIDAK DIKENALI =================
          else {

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Role tidak dikenali")),
            );

          }

        } else {

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data["message"])),
          );

        }

      } else {

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Server error")),
        );

      }

    } catch (e) {

      print("ERROR LOGIN: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Tidak dapat terhubung ke server")),
      );

    }
  }

  void loginWithGmail() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Login Gmail belum diaktifkan")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              const Icon(
                Icons.school,
                size: 80,
                color: Colors.blue,
              ),

              const SizedBox(height: 20),

              const Text(
                "Aplikasi Absensi",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.person),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: passwordController,
                obscureText: isPasswordHidden,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordHidden
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordHidden = !isPasswordHidden;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "LOGIN",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              Row(
                children: const [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("atau login dengan"),
                  ),
                  Expanded(child: Divider()),
                ],
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  icon: const Icon(
                    Icons.g_mobiledata,
                    size: 30,
                    color: Colors.red,
                  ),
                  label: const Text(
                    "Login dengan Gmail",
                    style: TextStyle(fontSize: 16),
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: loginWithGmail,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
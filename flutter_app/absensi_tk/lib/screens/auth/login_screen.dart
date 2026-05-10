import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/app_routes.dart';

import '../../models/kelas_detail_model.dart';

import '../../services/auth_service.dart';
import '../../services/kelas_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final TextEditingController
      usernameController =
      TextEditingController();

  final TextEditingController
      passwordController =
      TextEditingController();

  final AuthService authService =
      AuthService();

  final KelasService kelasService =
      KelasService();

  bool isPasswordHidden = true;

  Future<void> login() async {

    String username =
        usernameController.text.trim();

    String password =
        passwordController.text.trim();

    // VALIDASI
    if (username.isEmpty ||
        password.isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Username dan Password wajib diisi",
          ),
        ),
      );

      return;
    }

    try {

      // LOGIN API
      final data =
          await authService.login(
        username: username,
        password: password,
      );

      print("LOGIN RESPONSE: $data");

      // LOGIN BERHASIL
      if (data["status"] == true) {

        final prefs =
            await SharedPreferences
                .getInstance();

        // SIMPAN SESSION
        await prefs.setInt(
          "idUser",
          data["idUser"],
        );

        await prefs.setString(
          "role",
          data["role"],
        );

        String role =
            data["role"]
                .toString()
                .toLowerCase();

        // ================= ADMIN =================

        if (role.contains("admin")) {

          Navigator.pushReplacementNamed(
            context,
            AppRoutes.adminDashboard,
          );

        }

        // ================= GURU =================

        else if (role.contains("guru")) {

          int? idGuru = data["idGuru"];

          KelasDetail? kelas;

          // AMBIL KELAS AKTIF
          if (idGuru != null) {

            kelas = await kelasService
                .getKelasAktif(idGuru);

          }

          // MASUK DASHBOARD
          if (kelas != null) {

            Navigator.pushReplacementNamed(
              context,
              AppRoutes.dashboard,
              arguments: kelas,
            );

          } else {

            ScaffoldMessenger.of(context)
                .showSnackBar(
              const SnackBar(
                content: Text(
                  "Kelas aktif tidak ditemukan",
                ),
              ),
            );

          }

        }

        // ROLE TIDAK DIKENALI
        else {

          ScaffoldMessenger.of(context)
              .showSnackBar(
            const SnackBar(
              content: Text(
                "Role tidak dikenali",
              ),
            ),
          );

        }

      }

      // LOGIN GAGAL
      else {

        ScaffoldMessenger.of(context)
            .showSnackBar(
          SnackBar(
            content: Text(
              data["message"],
            ),
          ),
        );

      }

    } catch (e) {

      print("ERROR LOGIN: $e");

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Tidak dapat terhubung ke server",
          ),
        ),
      );

    }
  }

  void loginWithGmail() {

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          "Login Gmail belum diaktifkan",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      body: Center(

        child: SingleChildScrollView(

          padding:
              const EdgeInsets.all(24),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.center,

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
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              // USERNAME
              TextField(

                controller:
                    usernameController,

                decoration:
                    InputDecoration(

                  labelText: "Username",

                  border:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius
                            .circular(10),
                  ),

                  prefixIcon:
                      const Icon(
                    Icons.person,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // PASSWORD
              TextField(

                controller:
                    passwordController,

                obscureText:
                    isPasswordHidden,

                decoration:
                    InputDecoration(

                  labelText: "Password",

                  border:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius
                            .circular(10),
                  ),

                  prefixIcon:
                      const Icon(
                    Icons.lock,
                  ),

                  suffixIcon:
                      IconButton(

                    icon: Icon(
                      isPasswordHidden
                          ? Icons
                              .visibility
                          : Icons
                              .visibility_off,
                    ),

                    onPressed: () {

                      setState(() {
                        isPasswordHidden =
                            !isPasswordHidden;
                      });

                    },
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // LOGIN BUTTON
              SizedBox(

                width: double.infinity,
                height: 50,

                child: ElevatedButton(

                  onPressed: login,

                  style:
                      ElevatedButton
                          .styleFrom(

                    backgroundColor:
                        Colors.blue,

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius
                              .circular(
                        10,
                      ),
                    ),
                  ),

                  child: const Text(
                    "LOGIN",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              Row(

                children: const [

                  Expanded(
                    child: Divider(),
                  ),

                  Padding(
                    padding:
                        EdgeInsets
                            .symmetric(
                      horizontal: 10,
                    ),
                    child: Text(
                      "atau login dengan",
                    ),
                  ),

                  Expanded(
                    child: Divider(),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // GOOGLE LOGIN
              SizedBox(

                width: double.infinity,
                height: 50,

                child:
                    OutlinedButton.icon(

                  icon: const Icon(
                    Icons.g_mobiledata,
                    size: 30,
                    color: Colors.red,
                  ),

                  label: const Text(
                    "Login dengan Gmail",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  style:
                      OutlinedButton
                          .styleFrom(

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius
                              .circular(
                        10,
                      ),
                    ),
                  ),

                  onPressed:
                      loginWithGmail,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
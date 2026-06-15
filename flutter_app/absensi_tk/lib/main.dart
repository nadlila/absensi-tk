import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Tambahkan ini
import 'routes/route_generator.dart';
import 'routes/app_routes.dart';
import 'models/kelas_detail_model.dart';
import 'services/kelas_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? role = prefs.getString("role");
  int? idUser = prefs.getInt("idUser");
  int? idGuru = prefs.getInt("idGuru");

  String initialRoute = AppRoutes.login;
  Object? arguments;

  if (idUser != null && role != null) {
    if (role.toLowerCase().contains("admin")) {
      initialRoute = AppRoutes.adminDashboard;
    } else if (role.toLowerCase().contains("guru")) {
      initialRoute = AppRoutes.dashboard;

      if (idGuru != null) {
        try {
          final kelasService = KelasService();
          arguments = await kelasService.getKelasAktif(idGuru);
        } catch (e) {
          print("Auto-login info: Guru tidak memiliki kelas aktif");
        }
      }
    }
  }

  runApp(MyApp(initialRoute: initialRoute, initialArguments: arguments));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  final Object? initialArguments;

  const MyApp({super.key, required this.initialRoute, this.initialArguments});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      onGenerateInitialRoutes: (initialRouteName) {
        return [
          RouteGenerator.generateRoute(RouteSettings(
            name: initialRouteName,
            arguments: initialArguments,
          ))!,
        ];
      },
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
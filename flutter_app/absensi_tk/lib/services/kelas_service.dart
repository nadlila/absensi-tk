import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';
import '../models/kelas_detail_model.dart';

class KelasService {
  static const String baseUrl = ApiConfig.baseUrl;

  Future<KelasDetail?> getKelasAktif(int idGuru) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/kelas-guru/guru/$idGuru/detail-aktif"),
      );

      if (response.statusCode == 200 &&
          response.body.isNotEmpty &&
          response.body != "null") {
        final data = jsonDecode(response.body);
        return KelasDetail.fromJson(data);
      }
    } catch (e) {
      print("Error getKelasAktif: $e");
    }
    return null;
  }
}

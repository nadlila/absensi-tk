import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/kelas_detail_model.dart';

class KelasService {

  static const String baseUrl = "http://10.0.2.2:8080/api";

  // Ubah fungsi getKelasAktif menjadi:

  Future<KelasDetail?> getKelasAktif(int idGuru) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/kelas-guru/guru/$idGuru/detail-aktif"),
      );

      // Cek apakah status 200 dan body tidak kosong/null
      if (response.statusCode == 200 &&
          response.body.isNotEmpty &&
          response.body != "null") {

        final data = jsonDecode(response.body);
        return KelasDetail.fromJson(data);
      }
    } catch (e) {
      print("Error getKelasAktif: $e");
    }

    return null; // Kembalikan null jika tidak ada data atau error
  }
}
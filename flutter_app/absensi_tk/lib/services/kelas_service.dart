import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/kelas_detail_model.dart';

class KelasService {

  static const String baseUrl = "http://10.0.2.2:8080/api";

  Future<KelasDetail?> getKelasAktif(int idGuru) async {

    final response = await http.get(
      Uri.parse("$baseUrl/kelas-guru/guru/$idGuru/detail-aktif"),
    );

    if (response.statusCode == 200 && response.body != "null") {

      final data = jsonDecode(response.body);

      return KelasDetail.fromJson(data);

    }

    return null;
  }
}
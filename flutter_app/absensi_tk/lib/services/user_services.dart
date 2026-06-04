import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';

class UserService {
  static const String baseUrl = "${ApiConfig.baseUrl}/users";

  static Future<List<dynamic>> getUsers() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return [];
  }

  static Future<bool> createUser(Map data) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );
    return response.statusCode == 200 || response.statusCode == 201;
  }

  static Future<bool> deleteUser(int id) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/$id"),
    );
    return response.statusCode == 200;
  }
}

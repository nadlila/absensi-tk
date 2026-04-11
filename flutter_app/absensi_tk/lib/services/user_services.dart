import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {

  static const String baseUrl = "http://10.0.2.2:8080/api/users";

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
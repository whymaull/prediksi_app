import 'dart:convert';
import 'package:http/http.dart' as http;

// const String baseUrl = 'https://deploy-production-005c.up.railway.app';
// const String baseUrl = 'https://gg0l3mpr-5002.asse.devtunnels.ms';
const String baseUrl = 'http://192.168.0.106:5000';

class AuthService {
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    return {
      'statusCode': response.statusCode,
      'body': jsonDecode(response.body),
    };
  }

  static Future<Map<String, dynamic>> register(
      String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'username': username, 'email': email, 'password': password}),
    );

    return jsonDecode(response.body);
  }
}

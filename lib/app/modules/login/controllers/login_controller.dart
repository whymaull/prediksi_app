import 'dart:convert';

import 'package:get/get.dart';
import 'package:prediksi_app/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final email = ''.obs;
  final password = ''.obs;

  Future<void> login() async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Email dan Password wajib diisi");
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(
            'http://192.168.0.118:5000/login'), // Ganti IP sesuai backend kamu
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email.value,
          'password': password.value,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final user = data['user'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("user_id", user['id'].toString());
        await prefs.setString("username", user['username']);
        await prefs.setString("email", user['email']);

        Get.offAllNamed(Routes.MAIN);
      } else {
        Get.snackbar("Login Gagal", data['message']);
      }
    } catch (e) {
      Get.snackbar("Error", "Tidak dapat terhubung ke server");
    }
  }
}

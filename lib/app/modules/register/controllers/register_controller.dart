import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:prediksi_app/app/routes/app_pages.dart';
import 'package:prediksi_app/app/services/auth_services.dart';

class RegisterController extends GetxController {
  final username = ''.obs;
  final email = ''.obs;
  final password = ''.obs;
  var showPassword = false.obs;

  void togglePassword() {
    showPassword.value = !showPassword.value;
  }

  Future<void> register() async {
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Semua field wajib diisi");
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username.value,
          'email': email.value,
          'password': password.value,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 ||
          data['message'].toString().toLowerCase().contains('sukses')) {
        Get.snackbar("Berhasil", "Akun berhasil dibuat");
        Get.offAllNamed(Routes.LOGIN);
      } else {
        Get.snackbar("Gagal", data['message'] ?? "Gagal membuat akun");
      }
    } catch (e) {
      Get.snackbar("Error", "Tidak dapat terhubung ke server");
    }
  }
}

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:prediksi_app/app/routes/app_pages.dart';
import 'package:prediksi_app/app/services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  var username = "".obs;
  var email = "".obs;
  var isLoading = false.obs;

  Future<void> fetchProfile() async {
    isLoading.value = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('user_id') ?? "1"; // fallback sementara

      final response = await http.get(Uri.parse('$baseUrl/profile/$userId'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        username.value = data['username'] ?? "-";
        email.value = data['email'] ?? "-";
      } else {
        Get.snackbar("Error", "Gagal ambil data profil");
      }
    } catch (e) {
      Get.snackbar("Exception", e.toString());
    }
    isLoading.value = false;
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    Get.offAllNamed(Routes.LOGIN);
  }

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }
}

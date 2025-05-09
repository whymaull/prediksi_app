import 'package:get/get.dart';
import 'package:prediksi_app/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final email = ''.obs;
  final password = ''.obs;

  Future<void> login() async {
    if (email.isNotEmpty && password.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("user_id", email.value);
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.snackbar("Error", "Email dan Password wajib diisi");
    }
  }
}

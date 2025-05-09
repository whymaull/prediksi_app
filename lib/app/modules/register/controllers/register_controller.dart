import 'package:get/get.dart';
import 'package:prediksi_app/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController

  final email = ''.obs;
  final password = ''.obs;

  void register() {
    if (email.isNotEmpty && password.isNotEmpty) {
      Get.snackbar("Sukses", "Akun berhasil dibuat");
      Get.offAllNamed(Routes.LOGIN);
    } else {
      Get.snackbar("Error", "Email dan Password wajib diisi");
    }
  }
}

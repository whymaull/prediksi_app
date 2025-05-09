import 'package:get/get.dart';
import 'package:prediksi_app/app/modules/home/controllers/home_controller.dart';
import 'package:prediksi_app/app/modules/riwayat/controllers/riwayat_controller.dart';

import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<RiwayatController>(
      () => RiwayatController(),
    );
  }
}

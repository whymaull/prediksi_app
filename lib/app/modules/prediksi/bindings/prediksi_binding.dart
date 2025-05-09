import 'package:get/get.dart';

import '../controllers/prediksi_controller.dart';

class PrediksiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrediksiController>(
      () => PrediksiController(),
    );
  }
}

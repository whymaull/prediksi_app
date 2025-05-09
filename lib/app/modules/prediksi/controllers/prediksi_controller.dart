import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PrediksiController extends GetxController {
  //TODO: Implement PrediksiController

  final forecast = <double>[].obs;
  final isLoading = true.obs;
  late String symbol;

  final baseUrl = 'http://192.168.0.118:5000';

  @override
  void onInit() {
    super.onInit();
    symbol = Get.arguments;
    fetchPrediction();
  }

  Future<void> fetchPrediction() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString("user_id") ?? "guest";

      final res = await http.post(
        Uri.parse('$baseUrl/predict'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "symbol": symbol,
          "user_id": userId,
          "periods": 7,
        }),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        forecast.value = List<double>.from(data['forecast']);
      } else {
        Get.snackbar("Error", "Gagal memuat prediksi");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

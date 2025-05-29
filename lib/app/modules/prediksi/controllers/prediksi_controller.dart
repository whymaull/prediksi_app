import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../services/auth_services.dart';
import '../../riwayat/controllers/riwayat_controller.dart';

class PrediksiController extends GetxController {
  var symbol = '';
  var selectedDate = Rxn<DateTime>();
  var period = 'daily'.obs;
  var forecast = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  void pickDate() async {
    final picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024, 1, 1),
      lastDate: DateTime.now(),
    );
    if (picked != null) selectedDate.value = picked;
  }

  void predict() async {
    if (selectedDate.value == null) {
      Get.snackbar("Error", "Tanggal belum dipilih");
      return;
    }

    isLoading.value = true;

    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString("user_id") ?? "guest";

      final response = await http.post(
        Uri.parse('$baseUrl/predict'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'symbol': symbol,
          'start_date': selectedDate.value!.toIso8601String().split('T')[0],
          'period': period.value,
          'periods': 7,
          'user_id': userId,
        }),
      );

      final result = jsonDecode(response.body);
      forecast.value = List<Map<String, dynamic>>.from(result['forecast']);

      final riwayatC = Get.isRegistered<RiwayatController>()
          ? Get.find<RiwayatController>()
          : null;

      riwayatC?.fetchRiwayat();
    } catch (e) {
      Get.snackbar("Error", "Gagal mengambil hasil prediksi");
    }

    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    symbol = args['symbol'];

    // Hapus hasil prediksi jika periode diubah
    ever(period, (_) {
      forecast.clear();
      Get.snackbar("Info", "Periode diubah, silakan klik prediksi ulang");
    });
  }
}

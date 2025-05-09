import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RiwayatController extends GetxController {
  //TODO: Implement RiwayatController

  var riwayatList = [].obs;
  final isLoading = false.obs;

  Future<void> fetchRiwayat() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');

    final response = await http.get(
      Uri.parse('http://192.168.0.118:5000/riwayat/$userId'),
    );

    if (response.statusCode == 200) {
      riwayatList.value = jsonDecode(response.body);
    } else {
      // Get.snackbar("Gagal", "Tidak bisa mengambil data riwayat");
    }

    isLoading.value = false;
  }

  Future<void> deleteRiwayat(int id) async {
    final response = await http.delete(
      Uri.parse('http://192.168.0.118:5000/riwayat/$id'),
    );

    if (response.statusCode == 200) {
      riwayatList.removeWhere((item) => item['id'] == id);
      Get.snackbar("Berhasil", "Riwayat berhasil dihapus");
    } else {
      Get.snackbar("Gagal", "Gagal menghapus riwayat");
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchRiwayat();
  }
}

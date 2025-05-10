import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:prediksi_app/app/routes/app_pages.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  var allSaham = <Map<String, dynamic>>[].obs;
  var filteredSaham = <Map<String, dynamic>>[].obs;
  final search = ''.obs;

  final String baseUrl = 'http://192.168.0.118:5000';

  @override
  void onInit() {
    super.onInit();
    fetchSaham();
  }

  void fetchSaham() async {
    final res = await http.get(Uri.parse('$baseUrl/symbols'));
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      allSaham.value = List<Map<String, dynamic>>.from(data);
      filteredSaham.value = allSaham;
    } else {
      Get.snackbar("Error", "Gagal memuat saham");
    }
  }

  void filter(String query) {
    search.value = query;
    if (query.isEmpty) {
      filteredSaham.value = allSaham;
    } else {
      filteredSaham.value = allSaham.where((item) {
        return item['symbol'].toLowerCase().contains(query.toLowerCase()) ||
            item['name'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }
}

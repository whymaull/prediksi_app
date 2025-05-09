import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:prediksi_app/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Saham")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: controller.filter,
              decoration: const InputDecoration(
                hintText: "Cari saham...",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: controller.filteredSaham.length,
                  itemBuilder: (context, index) {
                    final saham = controller.filteredSaham[index];
                    return ListTile(
                      title: Text(saham['symbol']),
                      subtitle: Text(saham['name']),
                      onTap: () => Get.toNamed(Routes.PREDIKSI,
                          arguments: saham['symbol']),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}

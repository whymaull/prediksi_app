import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/riwayat_controller.dart';

class RiwayatView extends StatelessWidget {
  final RiwayatController controller = Get.put(RiwayatController());
  RiwayatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Riwayat Prediksi")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.riwayatList.isEmpty) {
          return const Center(child: Text("Belum ada riwayat"));
        }

        return ListView.builder(
          itemCount: controller.riwayatList.length,
          itemBuilder: (context, index) {
            final item = controller.riwayatList[index];
            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                title: Text("Kode Saham: ${item['symbol']}"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Periode: ${item['periods']} hari"),
                    Text("Hasil: ${item['forecast']}"),
                    Text("Tanggal: ${item['created_at']}"),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => controller.deleteRiwayat(item['id']),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

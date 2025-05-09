import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/prediksi_controller.dart';

class PrediksiView extends GetView<PrediksiController> {
  const PrediksiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Prediksi ${controller.symbol}")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.forecast.isEmpty) {
          return const Center(child: Text("Tidak ada hasil prediksi."));
        }

        return ListView.builder(
          itemCount: controller.forecast.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("Hari ke-${index + 1}"),
              trailing: Text(controller.forecast[index].toStringAsFixed(2)),
            );
          },
        );
      }),
    );
  }
}

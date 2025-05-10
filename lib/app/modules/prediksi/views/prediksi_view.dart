import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/prediksi_controller.dart';

class PrediksiView extends GetView<PrediksiController> {
  const PrediksiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Prediksi ${controller.symbol}")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Pilih Tanggal Prediksi"),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: controller.pickDate,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        controller.selectedDate.value == null
                            ? "Pilih Tanggal"
                            : controller.selectedDate.value!
                                .toLocal()
                                .toString()
                                .split(' ')[0],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text("Pilih Periode"),
                  DropdownButton<String>(
                    value: controller.period.value,
                    items: const [
                      DropdownMenuItem(value: 'daily', child: Text("Harian")),
                      DropdownMenuItem(
                          value: 'weekly', child: Text("Mingguan")),
                      DropdownMenuItem(
                          value: 'monthly', child: Text("Bulanan")),
                    ],
                    onChanged: (val) => controller.period.value = val!,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.predict,
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Mulai Prediksi"),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (controller.forecast.isNotEmpty)
                    const Text("Hasil Prediksi:",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ...controller.forecast.map((item) {
                    final date = item['date'];
                    final value = item['value'];
                    final label = controller.period.value == 'daily'
                        ? 'Harian'
                        : controller.period.value == 'weekly'
                            ? 'Mingguan'
                            : 'Bulanan';

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        leading: const Icon(Icons.trending_up),
                        title: Text("Tanggal: $date",
                            overflow: TextOverflow.ellipsis),
                        subtitle: Text("Periode: $label"),
                        trailing: SizedBox(
                          width: 70, // ← batasin lebar trailing biar ga meledak
                          child: Text(
                            value.toStringAsFixed(2),
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              )),
        ),
      ),
    );
  }
}

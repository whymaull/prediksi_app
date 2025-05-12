import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/prediksi_controller.dart';

class PrediksiView extends GetView<PrediksiController> {
  const PrediksiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prediksi Saham ${controller.symbol}"),
      ),
      body: Obx(() => SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Pilih Tanggal Prediksi",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: controller.pickDate,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.selectedDate.value == null
                              ? "Pilih Tanggal"
                              : controller.selectedDate.value!
                                  .toLocal()
                                  .toString()
                                  .split(' ')[0],
                          style: const TextStyle(fontSize: 16),
                        ),
                        const Icon(Icons.calendar_today, size: 18),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text("Pilih Periode",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: controller.period.value,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'daily', child: Text("Harian")),
                    DropdownMenuItem(value: 'weekly', child: Text("Mingguan")),
                    DropdownMenuItem(value: 'monthly', child: Text("Bulanan")),
                  ],
                  onChanged: (val) => controller.period.value = val!,
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: controller.predict,
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Mulai Prediksi",
                            style: TextStyle(fontSize: 16),
                          ),
                  ),
                ),
                const SizedBox(height: 30),
                if (controller.forecast.isNotEmpty) ...[
                  const Divider(),
                  const Text("Hasil Prediksi:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.forecast.length,
                    itemBuilder: (context, index) {
                      final item = controller.forecast[index];
                      final date = item['date'];
                      final value = item['value'];
                      final label = controller.period.value == 'daily'
                          ? 'Harian'
                          : controller.period.value == 'weekly'
                              ? 'Mingguan'
                              : 'Bulanan';

                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.trending_up,
                              color: Colors.deepPurple),
                          title: Text("Tanggal: $date"),
                          subtitle: Text("Periode: $label"),
                          trailing: Text(
                            value.toStringAsFixed(2),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      );
                    },
                  ),
                ]
              ],
            ),
          )),
    );
  }
}

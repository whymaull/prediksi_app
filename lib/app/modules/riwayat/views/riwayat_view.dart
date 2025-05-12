import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prediksi_app/app/helper/date_utils.dart';
import '../controllers/riwayat_controller.dart';

class RiwayatView extends StatelessWidget {
  final RiwayatController controller = Get.put(RiwayatController());
  RiwayatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Riwayat Prediksi",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = controller.riwayatList;

        if (data.isEmpty) {
          return const Center(child: Text("Belum ada riwayat prediksi."));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: data.length,
          itemBuilder: (context, index) {
            final item = data[index];
            final List forecast = jsonDecode(item['forecast']);
            final tanggal = formatTanggal(item['created_at']);
            final tanggalMulai = formatTanggalOnly(item['start_date']);
            final periodType = item['period_type'];
            final label = periodType == 'daily'
                ? 'Harian'
                : periodType == 'weekly'
                    ? 'Mingguan'
                    : 'Bulanan';

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.08),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Kode Saham: ${item['symbol']}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => controller.deleteRiwayat(item['id']),
                      )
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text("Periode: $label (${item['periods']} langkah)"),
                  const SizedBox(height: 4),
                  Text("Mulai Prediksi: $tanggalMulai"),
                  const SizedBox(height: 6),
                  Text(
                    "Hasil:",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ...forecast.map<Widget>((v) {
                    return Text(
                      "${v['date']}: ${double.parse(v['value'].toString()).toStringAsFixed(2)}",
                      style:
                          const TextStyle(fontSize: 13, color: Colors.black87),
                    );
                  }).toList(),
                  const SizedBox(height: 6),
                  Text(
                    "Tanggal Simpan: $tanggal",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}

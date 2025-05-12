import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart'; // ← ini penting
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // wajib untuk await
  await initializeDateFormatting('id_ID', null); // inisialisasi lokal Indonesia

  runApp(
    GetMaterialApp(
      theme: ThemeData.light(),
      title: "Application",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}

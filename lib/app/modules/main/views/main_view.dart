import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:prediksi_app/app/controllers/bottom_navbar.dart';
import 'package:prediksi_app/app/modules/home/views/home_view.dart';
import 'package:prediksi_app/app/modules/profile/views/profile_view.dart';
import 'package:prediksi_app/app/modules/riwayat/views/riwayat_view.dart';

class MainView extends StatelessWidget {
  final BottomNavController controller = Get.put(BottomNavController());

  final List<Widget> pages = [
    HomeView(),
    RiwayatView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.selectedIndex.value != 0) {
          controller.changeIndex(0);
          return false; // jangan keluar app, cukup ganti ke Home
        }
        return true; // kalau sudah di Home, boleh keluar app
      },
      child: Obx(() => Scaffold(
            body: pages[controller.selectedIndex.value],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: controller.selectedIndex.value,
              onTap: controller.changeIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Beranda',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: 'Riwayat',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profil',
                ),
              ],
            ),
          )),
    );
  }
}

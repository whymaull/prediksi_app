import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:prediksi_app/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              onChanged: (val) => controller.email.value = val,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              obscureText: true,
              onChanged: (val) => controller.password.value = val,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.login,
              child: const Text("Login"),
            ),
            TextButton(
              onPressed: () => Get.toNamed(Routes.REGISTER),
              child: const Text("Belum punya akun? Daftar"),
            )
          ],
        ),
      ),
    );
  }
}

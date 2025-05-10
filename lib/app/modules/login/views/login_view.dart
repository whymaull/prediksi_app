import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prediksi_app/app/routes/app_pages.dart';
import 'package:prediksi_app/app/utils/widget/custom_textfield.dart';
import 'package:prediksi_app/app/utils/widget/gradient_button.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7F7FD5),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            padding: const EdgeInsets.all(24),
            width: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 12)
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  decoration: const BoxDecoration(
                    color: Color(0xFF5F52EE),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12)),
                  ),
                  child: Column(
                    children: const [
                      Text("Selamat Datang",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      SizedBox(height: 4),
                      Text("Masuk ke akun Anda",
                          style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  label: "EMAIL",
                  icon: Icons.email,
                  hintText: "email@anda.com",
                  onChanged: (val) => controller.email.value = val,
                ),
                const SizedBox(height: 16),
                Obx(() => CustomTextField(
                      label: "PASSWORD",
                      icon: Icons.lock,
                      hintText: "••••••••",
                      isObscure: !controller.showPassword.value,
                      showToggle: true,
                      onToggle: controller.togglePassword,
                      onChanged: (val) => controller.password.value = val,
                    )),
                const SizedBox(height: 24),
                GradientButton(onPressed: controller.login, text: "Masuk"),
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: () => Get.toNamed(Routes.REGISTER),
                    child: const Text.rich(TextSpan(
                      text: "Belum punya akun? ",
                      children: [
                        TextSpan(
                            text: "Daftar disini",
                            style: TextStyle(color: Color(0xFF5F52EE)))
                      ],
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

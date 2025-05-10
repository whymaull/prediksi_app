import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prediksi_app/app/utils/widget/custom_textfield.dart';
import 'package:prediksi_app/app/utils/widget/gradient_button.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

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
                      Text("Buat Akun",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      SizedBox(height: 4),
                      Text("Daftarkan akun baru Anda",
                          style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  label: "USERNAME",
                  icon: Icons.person,
                  hintText: "nama pengguna",
                  onChanged: (val) => controller.username.value = val,
                ),
                const SizedBox(height: 16),
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
                GradientButton(onPressed: controller.register, text: "Daftar"),
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: () => Get.back(),
                    child: const Text.rich(TextSpan(
                      text: "Sudah punya akun? ",
                      children: [
                        TextSpan(
                            text: "Masuk disini",
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

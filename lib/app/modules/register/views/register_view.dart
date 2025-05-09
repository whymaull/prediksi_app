import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
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
              onPressed: controller.register,
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}

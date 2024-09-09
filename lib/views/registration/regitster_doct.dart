import 'package:doctorappointmenapp/controllers/doctor_register_controller.dart'; // Make sure to import the correct controller
import 'package:doctorappointmenapp/routes/app_routes.dart';
import 'package:doctorappointmenapp/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorRegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
        DoctorRegisterController()); // Correct controller initialization

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doctor Register',
          style: boldTextStyle.copyWith(color: whiteColor),
        ),
        backgroundColor: greenColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create your account',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: greenColor,
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: controller.emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email, color: greenColor),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock, color: greenColor),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.confirmPasswordController,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock, color: greenColor),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 60),
            Center(
              child: SizedBox(
                width: 180,
                child: ElevatedButton(
                  onPressed: () async {
                    await controller
                        .registerDoctor(); // Ensure await to handle the async properly
                    // Optional: Check if registration is successful before navigating
                    // if (controller.registrationSuccess) {
                    //   Get.toNamed(AppRoutes.DOCTOR_LOGIN);
                    // }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greenColor,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Register',
                    style: mediumTextStyle.copyWith(
                        color: whiteColor, fontSize: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 80),
            Center(
              child: TextButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.DOCTOR_LOGIN);
                },
                child: Text(
                  'Already have an account? Login',
                  style:
                      boldTextStyle.copyWith(color: greenColor, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

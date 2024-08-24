import 'package:doctorappointmenapp/controllers/register_controller.dart';
import 'package:doctorappointmenapp/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientRegisterView extends StatelessWidget {
  const PatientRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Patient Register',
          style: boldTextStyle.copyWith(color: whiteColor),
        ),
        backgroundColor: greenColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
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
              decoration: InputDecoration(
                labelText: 'Email',
                border: const OutlineInputBorder(),
                prefixIcon: Icon(Icons.email, color: greenColor),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock, color: greenColor),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: const OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock, color: greenColor),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity, // Full width
              child: ElevatedButton(
                onPressed: () => controller.registerPatient(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: greenColor,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Register',
                  style:
                      mediumTextStyle.copyWith(color: whiteColor, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity, // Full width
              child: ElevatedButton.icon(
                onPressed: () => controller.loginWithGoogle(),
                icon: const Icon(Icons.login, color: Colors.white),
                label: Text('Login with Google',
                    style: mediumTextStyle.copyWith(
                        color: whiteColor, fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: greenColor,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  'Already have an account? Login',
                  style:
                      boldTextStyle.copyWith(fontSize: 18, color: greenColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

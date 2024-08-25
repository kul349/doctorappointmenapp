import 'package:doctorappointmenapp/controllers/login_controller.dart';
import 'package:doctorappointmenapp/routes/app_routes.dart';
import 'package:doctorappointmenapp/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorLoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doctor Login',
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
              'Login to your account',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: greenColor,
              ),
            ),
            SizedBox(height: 24),
            TextField(
              controller: controller.emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email, color: greenColor),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
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
                  onPressed: () => controller.loginDoctor(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greenColor,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: mediumTextStyle.copyWith(
                        color: whiteColor, fontSize: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 80),
            Center(
              child: SizedBox(
                width: 200,
                child: ElevatedButton.icon(
                  onPressed: () => controller.loginWithGoogle(),
                  icon: const Icon(Icons.login, color: Colors.white),
                  label: Text(
                    'Login with Google',
                    style: mediumTextStyle.copyWith(
                        color: whiteColor, fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greenColor,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: TextButton(
                onPressed: () => Get.toNamed(AppRoutes.DOCTOR_REGISTER),
                child: Text(
                  'Don\'t have an account? Register',
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

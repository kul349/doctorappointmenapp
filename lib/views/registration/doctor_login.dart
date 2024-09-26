import 'package:doctorappointmenapp/controllers/auth_controller.dart';
import 'package:doctorappointmenapp/routes/app_routes.dart';
import 'package:doctorappointmenapp/services/doctor/login_authservice.dart';
import 'package:doctorappointmenapp/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorLoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthController _authController = Get.put(AuthController());
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final DoctorLoginAuthService _doctorLoginAuthService =
        DoctorLoginAuthService();

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
            const Text(
              'Login to your account',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: greenColor,
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email, color: greenColor),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
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
                  onPressed: () async {
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();

                    // Trigger login process
                    final doctor = await _doctorLoginAuthService.doctorLogin(
                        email, password);

                    if (doctor != null) {
                      Get.snackbar("Success", "Login successful");
                      Get.offAllNamed(AppRoutes
                          .doctoDashboardView); // Navigate to doctor dashboard or home
                    } else {
                      Get.snackbar("Error",
                          "Failed to login, please check your credentials");
                    }
                  },
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
              child: TextButton(
                onPressed: () => Get.toNamed(AppRoutes.doctorRegister),
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

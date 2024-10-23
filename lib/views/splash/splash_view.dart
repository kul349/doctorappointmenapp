import 'package:doctorappointmenapp/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/splash_controller.dart';

class SplashView extends StatelessWidget {
  final SplashController controller = Get.put(SplashController());

  SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: greenColor, // Set the background color to match the theme
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            // DoctorCare App Logo or Placeholder Image
            Icon(
              Icons.local_hospital,
              size: 120,
              color: whiteColor, // Make the logo color white for contrast
            ),
            const SizedBox(height: 30),
            // Informative Text
            Text(
              "Welcome to DoctorCare App",
              style: boldTextStyle.copyWith(
                fontSize: 28,
                color: whiteColor, // Text color in contrast to the green
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Providing trusted medical appointments at your fingertips.",
                style: mediumTextStyle.copyWith(
                  fontSize: 16,
                  color: whiteColor.withOpacity(0.8),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 50),
            // Additional Informative Text or Tagline
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: whiteColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: whiteColor.withOpacity(0.2)),
                ),
                child: Text(
                  "Manage your health easily with secure, instant access to doctors anytime, anywhere.",
                  style: mediumTextStyle.copyWith(
                    fontSize: 16,
                    color: whiteColor.withOpacity(0.9),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

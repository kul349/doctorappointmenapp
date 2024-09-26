import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctorappointmenapp/routes/app_routes.dart';
import 'package:doctorappointmenapp/themes/app_theme.dart';

class DoctorDashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doctor Dashboard',
          style: boldTextStyle.copyWith(color: whiteColor),
        ),
        backgroundColor: greenColor,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Call the logout function here, e.g., from the AuthController
              // Get.find<AuthController>().logout(); // Uncomment and implement in AuthController
              Get.offAllNamed(AppRoutes.DOCTOR_LOGIN); // Redirect to login
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome, Doctor!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: greenColor,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'What would you like to do today?',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 40),
            // Dashboard buttons
            ElevatedButton(
              onPressed: () {
                // Navigate to the appointments view
                // Get.toNamed(AppRoutes.APPOINTMENTS); // Replace with your appointments route
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: greenColor,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'View Appointments',
                style: TextStyle(color: whiteColor, fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to the patient profiles view
                // Get.toNamed(AppRoutes.PATIENT_PROFILES); // Replace with your patient profiles route
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: greenColor,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'View Patient Profiles',
                style: TextStyle(color: whiteColor, fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to the ratings/reviews page
                // Get.toNamed(AppRoutes.RATINGS); // Replace with your ratings/reviews route
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: greenColor,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'View Ratings & Reviews',
                style: TextStyle(color: whiteColor, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

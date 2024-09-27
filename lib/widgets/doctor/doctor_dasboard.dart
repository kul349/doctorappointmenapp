import 'package:doctorappointmenapp/routes/app_routes.dart';
import 'package:doctorappointmenapp/services/doctor/login_authservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctorappointmenapp/themes/app_theme.dart';

class DoctorDashboardView extends StatelessWidget {
  final DoctorLoginAuthService _authService = DoctorLoginAuthService(); // Instance of Auth Service

  @override
  Widget build(BuildContext context) {
    // Retrieve doctorId from the arguments
    final String doctorId = Get.arguments['doctorId'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doctor Dashboard',
          style: boldTextStyle.copyWith(color: whiteColor),
        ),
        backgroundColor: greenColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              try {
                await _authService.doctorLogout(); // Call the logout function
                Get.offAllNamed(AppRoutes.HOME); // Navigate to login page after logout
              } catch (e) {
                Get.snackbar("Error", "Logout failed. Please try again.");
              }
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
            ElevatedButton(
              onPressed: () {
                // Navigate to the appointments view and pass doctorId
                Get.toNamed(AppRoutes.patientAppointmentView, arguments: {
                  'doctorId': doctorId, // Pass the doctorId here
                });
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
                Get.toNamed('/patient_profiles'); // Replace with your patient profiles route
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
                Get.toNamed('/ratings'); // Replace with your ratings/reviews route
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

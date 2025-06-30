import 'package:doctorappointmenapp/controllers/doctor/doctordashboard_controller.dart';
import 'package:doctorappointmenapp/services/doctor/login_authservice.dart';
import 'package:doctorappointmenapp/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctorappointmenapp/themes/app_theme.dart';

class DoctorDashboardView extends StatelessWidget {
  final DoctorLoginAuthService _authService = DoctorLoginAuthService();
  final DoctorProfileUpdateController doctorController = Get.find();

  DoctorDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve doctorId from the arguments
    final String doctorId = Get.arguments['doctorId'] ?? '';

    // Fetch doctor profile using doctorId from arguments
    if (doctorController.doctor.value.id != doctorId) {
      doctorController
          .fetchDoctorProfile(doctorId); // Fetch profile using doctorId
    }

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
                Get.offAllNamed(
                    AppRoutes.home); // Navigate to login page after logout
              } catch (e) {
                Get.snackbar("Error", "Logout failed. Please try again.");
              }
            },
          ),
        ],
      ),
      drawer: Container(
        width: 200,
        child: Drawer(
          child: ListView(
            children: [
              SizedBox(
                height: 100,
                child: DrawerHeader(
                    child: CircleAvatar(
                  backgroundColor: kRedLightColor,
                  child: Obx(() => Text(
                        doctorController.doctor.value.doctorName.isNotEmpty
                            ? doctorController.doctor.value.doctorName[0]
                            : 'D', // Default value if doctorName is not loaded yet
                        style:
                            const TextStyle(fontSize: 30, color: greyBoldColor),
                      )),
                )),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text("My Profile"),
                onTap: () {
                  print("navigate to my profile");
                  Get.toNamed(AppRoutes.doctorProfileUpdate, arguments: {
                    "doctorId": doctorId,
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout_outlined),
                title:
                    const Text('Logout', style: TextStyle(color: Colors.red)),
                onTap: () async {
                  try {
                    await _authService.doctorLogout();
                    Get.offAllNamed(AppRoutes.home);
                  } catch (e) {
                    Get.snackbar("Error", "Logout failed. Please try again.");
                  }
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, Dr. ${doctorController.doctor.value.doctorName.isNotEmpty ? doctorController.doctor.value.doctorName : 'Doctor'}!',
                  style: const TextStyle(
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
                    Get.toNamed(AppRoutes.patientAppointmentView, arguments: {
                      'doctorId': doctorId, // Use doctorId from arguments
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
                    Get.toNamed(AppRoutes.reviewRating, arguments: {
                      'doctorId': doctorId, // Use doctorId from arguments
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
                    'View Ratings & Reviews',
                    style: TextStyle(color: whiteColor, fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.doctornotificationview, arguments: {
                      'doctorId': doctorId, // Use doctorId from arguments
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
                    'View Notifications',
                    style: TextStyle(color: whiteColor, fontSize: 16),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

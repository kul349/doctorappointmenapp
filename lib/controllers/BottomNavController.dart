import 'package:doctorappointmenapp/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:doctorappointmenapp/controllers/auth_controller.dart'; // Import AuthController

class BottomNavController extends GetxController {
  var selectedIndex = 0.obs; // Default to Home

  // Get instance of AuthController to access patientId
  final AuthController authController = Get.find<AuthController>();

  void changeIndex(int index) {
    selectedIndex.value = index;
    String? patientId = authController.patientId.value; // Get the patientId

    switch (index) {
      case 0:
        Get.toNamed(AppRoutes.HOMESCREEN); // Navigate to Home page
        break;
      case 1:
        print("Navigating to Notification");

        // Pass the patientId to the Notification page
        Get.toNamed(AppRoutes.NOTIFICATION, arguments: {
          'userId': patientId,
        });
        break;
      case 2:
        Get.toNamed(AppRoutes.APPOINTMENTVIEW); // Navigate to Appointment page
        break;
    }
  }
}

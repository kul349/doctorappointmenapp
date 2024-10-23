import 'package:doctorappointmenapp/utils/constant.dart';
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
        Get.toNamed(AppRoutes.homeScreen); // Navigate to Home page
        break;
      case 1:
        print("Navigating to Notification");

        // Pass the patientId to the Notification page
        Get.toNamed(AppRoutes.notification, arguments: {
          'userId': patientId,
        });
        break;
      case 2:
        Get.toNamed(AppRoutes.appointmentView); // Navigate to Appointment page
        break;
    }
  }
}

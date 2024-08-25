import 'package:doctorappointmenapp/routes/app_routes.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController {
  var selectedIndex = 0.obs; // Default to Home

  void changeIndex(int index) {
    selectedIndex.value = index;
    switch (index) {
      case 0:
        Get.offNamed(AppRoutes.HOME); // Navigate to Home page
        break;
      case 1:
        Get.offNamed(AppRoutes.NOTIFICATION); // Navigate to Notification page
        break;
      case 2:
        Get.offNamed(AppRoutes.APPOINTMENTVIEW); // Navigate to Appointment page
        break;
    }
  }
}

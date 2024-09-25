import 'package:doctorappointmenapp/controllers/BottomNavController.dart';
import 'package:doctorappointmenapp/controllers/auth_controller.dart';
import 'package:doctorappointmenapp/controllers/doctor_menu_controller.dart';
import 'package:doctorappointmenapp/controllers/patient_getalldoctor_controller.dart';
import 'package:doctorappointmenapp/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_routes.dart';

void main() {
  // Initialize any necessary bindings (like controllers)
  Get.put(DoctorMenuController());
  Get.put(BottomNavController());
  Get.put(AuthController());
  Get.put(DoctorController());


  // Run the Flutter app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doctor Appointment App',
      theme: ThemeData(primaryColor: greenColor),

      // Set the initial route (splash screen)
      initialRoute: AppRoutes.splash,

      // Define all the routes of the app
      getPages: AppRoutes.routes,

      // Define the app's theme
    );
  }
}

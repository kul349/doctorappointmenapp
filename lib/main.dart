import 'package:doctorappointmenapp/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_routes.dart';

void main() {
  // Initialize any necessary bindings (like controllers)

  // Run the Flutter app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Doctor Appointment App',
      theme: ThemeData(primaryColor: greenColor),

      // Set the initial route (Splash screen)
      initialRoute: AppRoutes.SPLASH,

      // Define all the routes of the app
      getPages: AppRoutes.routes,

      // Define the app's theme
    );
  }
}

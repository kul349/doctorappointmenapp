
import 'package:doctorappointmenapp/controllers/BottomNavController.dart';
import 'package:doctorappointmenapp/controllers/auth_controller.dart';
import 'package:doctorappointmenapp/controllers/doctor/doctordashboard_controller.dart';
import 'package:doctorappointmenapp/controllers/doctor_menu_controller.dart';
import 'package:doctorappointmenapp/controllers/favorites_doctor_controller.dart';
import 'package:doctorappointmenapp/controllers/patient_getalldoctor_controller.dart';
import 'package:doctorappointmenapp/routes/app_routes.dart';
import 'package:doctorappointmenapp/services/localnotification.dart';
import 'package:doctorappointmenapp/themes/app_theme.dart';
import 'package:doctorappointmenapp/utils/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

// Initialize Flutter Local Notifications
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Background message handler for Firebase Messaging
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // This will be called when the app is in the background or terminated
  print('Handling a background message: ${message.messageId}');
}

void main() async {
  // Initialize necessary bindings (like controllers)
  Get.put(AuthController());
  Get.put(DoctorMenuController());
  Get.put(BottomNavController());
  Get.put(DoctorController());
  Get.put(DoctorProfileUpdateController());
  Get.put(FavoritesController());
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();
  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined permission');
  }
  // Initialize Flutter Local Notifications
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Handle foreground messages
  await LocalNotification.initLocalNotifications();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((event) {
    FirebaseMessaging.instance.getToken();
    LocalNotification.triggerLocalNotification(
      title: event.notification!.title ?? "Title",
      body: event.notification!.body ?? "Body",
      data: event.data,
    );
  });

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
      theme: ThemeData(primaryColor: greenColor), // Set your app theme

      // Set the initial route (splash screen)
      initialRoute: AppRoutes.splash,

      // Define all the routes of the app
      getPages: routes,
    );
  }
}

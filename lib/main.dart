import 'package:doctorappointmenapp/controllers/BottomNavController.dart';
import 'package:doctorappointmenapp/controllers/auth_controller.dart';
import 'package:doctorappointmenapp/controllers/doctor_menu_controller.dart';
import 'package:doctorappointmenapp/controllers/patient_getalldoctor_controller.dart';
import 'package:doctorappointmenapp/themes/app_theme.dart';
import 'package:doctorappointmenapp/utils/constant.dart';
import 'package:doctorappointmenapp/views/notification/notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'routes/app_routes.dart';

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
  Get.put(DoctorMenuController());
  Get.put(BottomNavController());
  Get.put(AuthController());
  Get.put(DoctorController());

  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize Flutter Local Notifications
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Handle foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            notificationChannelId, // Replace with your channel ID
            notificationChannelName, // Replace with your channel name
            importance: Importance.max,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: message.data['payload'], // Pass data payload
      );
    }
  });

  // Handle notification taps when app is opened from background
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    final payload =
        message.data['payload'] ?? "No payload data"; // Handle null payload
    Get.to(() => NotificationView(payload: payload));
  });

  // Set the background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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
      getPages: AppRoutes.routes,
    );
  }
}

import 'package:doctorappointmenapp/routes/app_routes.dart';
import 'package:doctorappointmenapp/utils/constant.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class LocalNotification {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initLocalNotifications() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    await flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(android: androidInitializationSettings),
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      onDidReceiveNotificationResponse: notificationTapBackground,
    );
  }

  static void trigerLocalNotification({
    required String title,
    required String body,
    required Map<String, dynamic>
        data, // Ensure this receives the notification data
  }) {
    // Pass userType and userId in the payload for navigation
    String payload = "${data['userType']},${data['userId']}";

    flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          notificationChannelId,
          notificationChannelName,
          priority: Priority.high,
          importance: Importance.high,
        ),
      ),
      payload: payload, // Pass the payload as userType and userId
    );
  }
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // Split the payload by comma to extract userType and userId
  List<String> payloadData =
      notificationResponse.payload?.split(',') ?? ['Unknown', 'Unknown'];
  String userType = payloadData[0]; // First part is userType
  String userId = payloadData[1]; // Second part is userId

  print("UserType: $userType, UserId: $userId");

  // Navigate based on user type
  if (userType == "Doctor") {
    Get.toNamed(AppRoutes.doctornotificationview); // Replace with actual route
  } else if (userType == "Patient") {
    Get.toNamed(AppRoutes.NOTIFICATION,
        parameters: {'userId': userId}); // Pass userId as a parameter
  } else {
    print("Unable to specify the navigation page");
  }
}

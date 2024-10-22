import 'package:doctorappointmenapp/routes/app_routes.dart';
import 'package:doctorappointmenapp/services/token_service.dart';
import 'package:doctorappointmenapp/utils/constant.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class LocalNotification {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialize local notifications
  static Future<void> initLocalNotifications() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings("@mipmap/ic_launcher");

    await flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(android: androidInitializationSettings),
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      onDidReceiveNotificationResponse: notificationTapForeground,
    );
  }

  // Trigger local notification with custom payload
  static void triggerLocalNotification({
    required String title,
    required String body,
    required Map<String, dynamic> data,
  }) {
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
      payload: payload, // Custom payload containing userType and userId
    );
  }
}

// Background notification response handler
@pragma('vm:entry-point')
void notificationTapBackground(
    NotificationResponse notificationResponse) async {
  _handleNotificationTap(notificationResponse);
}

// Foreground notification response handler
@pragma('vm:entry-point')
void notificationTapForeground(
    NotificationResponse notificationResponse) async {
  _handleNotificationTap(notificationResponse);
}

// Shared function to handle notification taps
Future<void> _handleNotificationTap(
    NotificationResponse notificationResponse) async {
  // Check if the payload is available
  if (notificationResponse.payload == null) {
    print("Notification payload is null");
    Get.toNamed(
        AppRoutes.HOME); // Navigate to the home page if payload is missing
    return;
  }

  // Extract and split payload data (userType, userId)
  List<String> payloadData = notificationResponse.payload!.split(',');
  String userType = payloadData.isNotEmpty ? payloadData[0] : 'Unknown';
  String userId = payloadData.length > 1 ? payloadData[1] : 'Unknown';

  // Retrieve and decode the JWT token
  final token = await TokenService().getToken();
  if (token != null) {
    final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    print("Decoded Token for notification: $decodedToken");

    // Determine userType from the JWT token if not passed via payload
    if (userType == 'Unknown') {
      if (decodedToken.containsKey('doctorName') ||
          decodedToken.containsKey('specialization')) {
        userType = 'Doctor';
      } else if (decodedToken.containsKey('userName')) {
        userType = 'Patient';
      }
    }

    // Navigate based on userType
    if (userType == 'Doctor') {
      Get.toNamed(AppRoutes.doctornotificationview,
          arguments: {'userId': userId});
    } else if (userType == 'Patient') {
      Get.toNamed(
        AppRoutes.NOTIFICATION,
      );
    } else {
      print("Unknown user type in payload or token.");
      Get.toNamed(AppRoutes.HOME); // Fallback to home if userType is unknown
    }
  } else {
    // If no token is found, navigate to the home page
    Get.toNamed(AppRoutes.HOME);
  }
}

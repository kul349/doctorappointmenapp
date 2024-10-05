import 'dart:convert';

import 'package:doctorappointmenapp/models/doctor/notification_model.dart';
import 'package:doctorappointmenapp/services/token_service.dart';
import 'package:doctorappointmenapp/utils/constant.dart';
import 'package:http/http.dart' as http;

Future<List<NotificationModel>> fetchNotifications(
    String userType, String userId) async {
  print(userId);
  // Backend API URL
  final String apiUrl = '$baseUrl/notifications/$userType/$userId';

  try {
    // Make the GET request
    final response = await http.get(Uri.parse(apiUrl));

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      // Decode the response body
      final List<dynamic> data = json.decode(response.body);

      // Convert the list of maps into a list of NotificationModel objects
      return data.map((json) => NotificationModel.fromJson(json)).toList();
    } else {
      // Handle errors
      throw Exception('Failed to load notifications');
    }
  } catch (e) {
    print('Error: $e');
    return [];
  }
}

// Function to delete notification
Future<bool> deleteNotification(String notificationId, String userId) async {
  final TokenService _tokenService = TokenService(); // Instance of TokenService

  final String deleteUrl = '$baseUrl/notifications/$notificationId/$userId';
  try {
    final token = await _tokenService.getToken();

    final response = await http.delete(Uri.parse(deleteUrl), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      print('Notification deleted successfully');
      return true; // Deletion was successful
    } else {
      print('Failed to delete notification: ${response.body}');
      return false; // Deletion failed
    }
  } catch (e) {
    print('Error deleting notification: $e');
    return false; // Deletion failed due to error
  }
}

import 'dart:convert'; // For JSON decoding
import 'package:doctorappointmenapp/utils/constant.dart';
import 'package:http/http.dart' as http; // Import the http package

Future<List<dynamic>> fetchNotifications(String userType, String userId) async {
  print(userId);
  // Backend API URL
  final String apiUrl = '$baseUrl/notifications/$userType/$userId';

  try {
    // Make the GET request
    final response = await http.get(Uri.parse(apiUrl));

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      // Decode the response body and return the list of notifications
      return json.decode(response.body);
    } else {
      // Handle errors
      throw Exception('Failed to load notifications');
    }
  } catch (e) {
    print('Error: $e');
    return [];
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:doctorappointmenapp/utils/constant.dart';

class TimeSlotService {
  // Fetch available and taken time slots from the server
  static Future<Map<String, List<Map<String, dynamic>>>> getAvailableTimeSlots(
      String doctorId, DateTime date) async {
    final formattedDate =
        '${date.toIso8601String().split('T').first}'; // Format date as YYYY-MM-DD
    final url =
        '$baseUrl/appointment/getAvailableTimeSlots/$doctorId?date=$formattedDate';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print("Response body: ${response.body}");
      Map<String, dynamic> data = json.decode(response.body);

      // Check for null and return empty lists if null
      return {
        'availableSlots':
            List<Map<String, dynamic>>.from(data['availableSlots'] ?? []),
        'takenSlots': List<Map<String, dynamic>>.from(data['takenSlots'] ?? []),
      };
    } else {
      throw Exception('Failed to load time slots');
    }
  }
}

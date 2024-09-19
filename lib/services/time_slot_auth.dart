import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:doctorappointmenapp/utils/constant.dart';

class TimeSlotService {
  static Future<Map<String, List<Map<String, dynamic>>>> getAvailableTimeSlots(
      String doctorId, DateTime date) async {
    final formattedDate = '${date.toIso8601String().split('T').first}';
    final url = '$baseUrl/appointment/getAvailableTimeSlots/$doctorId?date=$formattedDate';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print("Response body: ${response.body}");
      Map<String, dynamic> data = json.decode(response.body);

      return {
        'availableSlots': List<Map<String, dynamic>>.from(data['availableSlots'] ?? []),
        'takenSlots': List<Map<String, dynamic>>.from(data['takenSlots'] ?? []),
      };
    } else {
      throw Exception('Failed to load time slots');
    }
  }
}

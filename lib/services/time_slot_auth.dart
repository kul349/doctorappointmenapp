// import 'package:doctorappointmenapp/utils/constant.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class TimeSlotService {
//   // Replace with your API base URL

//   static Future<List<Map<String, dynamic>>> getAvailableTimeSlots(
//       String doctorId, DateTime date) async {
//     final formattedDate =
//         '${date.toIso8601String().split('T').first}'; // Format date as YYYY-MM-DD
//     final url = '$baseUrl/getAvailableTimeSlots/$doctorId?date=$formattedDate';
//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       print(response.body);
//       // Assuming the response body contains a list of time slots
//       List<dynamic> data = json.decode(response.body);
//       return data.map((item) => item as Map<String, dynamic>).toList();
//     } else {
//       throw Exception('Failed to load time slots');
//     }
//   }
// }

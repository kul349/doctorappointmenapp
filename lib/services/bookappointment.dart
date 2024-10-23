import 'dart:convert';

import 'package:doctorappointmenapp/utils/constant.dart';
import 'package:http/http.dart' as http;

Future<void> bookAppointment(
    {required String token,
    required String doctorId,
    required String patientId,
    required String date,
    required String startTime}) async {
  try {
    print("patientID for appointment:$patientId");
    final response =
        await http.post(Uri.parse("$baseUrl/appointment/getAppointment"),
            headers: {
              'Authorization':
                  'Bearer $token', // Make sure 'Bearer' is included
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'doctorId': doctorId,
              'date': date,
              'startTime': startTime,
              "patientId": patientId
            }));
    if (response.statusCode == 201) {
      print("Appointment created successfully");
    } else {
      print("Failed to create Appointment:${response.body}");
    }
  } catch (e) {
    print("An error occured:$e");
  }
}

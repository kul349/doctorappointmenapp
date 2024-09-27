import 'package:doctorappointmenapp/utils/constant.dart';
import 'package:get/get.dart';
import 'package:doctorappointmenapp/models/appointment/appointment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PatientAppointmentController extends GetxController {
  final String doctorId;

  // Constructor to initialize doctorId
  PatientAppointmentController(this.doctorId);

  // Fetch appointments method
  Future<List<AppointmentModel>> fetchAppointments() async {
    try {
      print('Get.arguments: ${Get.arguments}');
      print('Doctor ID: $doctorId');

      // Fetching appointments from the API
      final response = await http
          .get(Uri.parse('$baseUrl/appointment/getAllAppointment/$doctorId'));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}'); // Should print the JSON

      if (response.statusCode == 200) {
        // Decode the JSON response
        final Map<String, dynamic> jsonData = json.decode(response.body);
        print('Decoded JSON: $jsonData');

        // Access appointments data safely
        final List<dynamic> appointmentsData = jsonData['appointments'] ?? [];

        // Check if appointmentsData is a list
        if (appointmentsData is! List) {
          throw Exception('Appointments data is not a list');
        }

        // Map the JSON data to AppointmentModel
        return appointmentsData.map((json) {
          return AppointmentModel.fromJson(json);
        }).toList();
      } else {
        throw Exception('Failed to load appointments');
      }
    } catch (e) {
      print('Error: $e'); // Log the error
      throw Exception('Error fetching appointments: $e');
    }
  }
}

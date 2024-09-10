// doctor_controller.dart
import 'package:doctorappointmenapp/models/doctor/gride_model.dart';
import 'package:doctorappointmenapp/utils/constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DoctorController extends GetxController {
  var filteredDoctors = <DoctorModel>[].obs;
  var isLoading = false.obs;

  // Update with your backend API URL
  final String apiUrl =
      '$baseUrl/doctor/getalldoctors'; // Replace with your backend URL

  void fetchDoctorsBySpecialization(String specialization) async {
    try {
      isLoading(true); // Show loading state

      // Make an API call to fetch doctors by specialization
      final response = await http.get(
        Uri.parse('$apiUrl?specialization=$specialization'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        // Parse the response body
        final List<dynamic> data = json.decode(
            response.body)['data']; // Adjust based on your response structure

        // Convert JSON data to list of DoctorModel
        filteredDoctors.value =
            data.map((json) => DoctorModel.fromJson(json)).toList();
      } else {
        // Handle errors
        print('Failed to fetch doctors: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching doctors: $e");
    } finally {
      isLoading(false); // Reset loading state
    }
  }
}

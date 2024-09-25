import 'package:doctorappointmenapp/models/doctor/gride_model.dart';
import 'package:doctorappointmenapp/utils/constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TopDoctorController extends GetxController {
  var doctors = <DoctorModel>[].obs; // Observable list of doctors
  var showAll = false.obs; // Observable for showing all doctors

  @override
  void onInit() {
    fetchTopDoctors(); // Fetch doctors when the controller is initialized
    super.onInit();
  }

  Future<void> fetchTopDoctors() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/doctor/getAllDoctorsWithoutFilter'));

      // Log the response body for debugging
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        // Access the 'data' key to get the list of doctors
        if (jsonResponse['data'] is List) {
          List<DoctorModel> fetchedDoctors = (jsonResponse['data'] as List)
              .map((doc) => DoctorModel.fromJson(doc))
              .toList();

          // Sort doctors by average rating in descending order
          fetchedDoctors
              .sort((a, b) => b.averageRating.compareTo(a.averageRating));
          doctors.assignAll(fetchedDoctors); // Update observable list
        } else {
          print('Expected a list of doctors, but got: $jsonResponse');
          throw Exception(
              'Expected a list of doctors, but got a different structure');
        }
      } else {
        // Log the response status code and body
        print(
            'Failed to load doctors: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to load doctors');
      }
    } catch (e) {
      print('Error occurred: $e');
      throw Exception('Failed to load doctors');
    }
  }

  void toggleShowAll() {
    showAll.value = !showAll.value; // Toggle the showAll state
  }
}

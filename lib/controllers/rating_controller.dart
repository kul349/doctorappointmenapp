import 'package:doctorappointmenapp/routes/app_routes.dart';
import 'package:doctorappointmenapp/services/token_service.dart';
import 'package:doctorappointmenapp/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RatingController extends GetxController {
  var rating = 0.0.obs; // RxDouble for half ratings
  var reviewController = TextEditingController();
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  final TokenService _tokenService = TokenService();

  // Ensure patientId passed is a string
  Future<void> submitRating(String doctorId, String patientId) async {
    isLoading.value = true;
    errorMessage.value = ''; // Reset error message

    // Log patientId for debugging
    print('Patient ID: $patientId');
    print('Doctor ID: $doctorId');

    // Check if patientId is empty or null
    if (patientId.isEmpty) {
      print('Error: patientId is empty');
      errorMessage.value = 'Patient ID is missing';
      isLoading.value = false;
      return;
    }

    // Basic input validation for rating
    if (rating.value < 1 || rating.value > 5) {
      errorMessage.value = 'Rating must be between 1 and 5.';
      isLoading.value = false;
      return;
    }

    try {
      final token = await _tokenService.getToken();
      final body = {
        'doctorId': doctorId,
        'patientId': patientId, // Include patientId as string
        'rating': rating.value, // Access rating value here
        'review': reviewController.text,
      };

      // Log request body for debugging
      print('Request body: ${json.encode(body)}');

      final response = await http.post(
        Uri.parse('$baseUrl/doctor/addRating'), // Your API endpoint
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );

      // Check if response is successful
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print(
            'Rating submitted successfully, navigating to AppointmentView...');
        Get.offNamed(
            AppRoutes.appointmentView); // Navigate back to appointment page
      } else {
        // Log detailed response
        print('Response status code: ${response.statusCode}');
        print('Response body: ${response.body}'); // Log the raw response
        try {
          final responseBody = json.decode(response.body);
          errorMessage.value =
              'Error submitting rating: ${responseBody['message'] ?? 'Unknown error'}';
        } catch (e) {
          // Handle cases where response is not JSON
          errorMessage.value = 'Error submitting rating: ${response.body}';
        }
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }
}

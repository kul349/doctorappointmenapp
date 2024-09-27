import 'dart:convert';
import 'package:doctorappointmenapp/models/doctor/gride_model.dart';
import 'package:doctorappointmenapp/services/token_service.dart';
import 'package:doctorappointmenapp/utils/constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DoctorController extends GetxController {
  final TokenService _tokenService = TokenService();
  var doctor = DoctorModel(
    id: '',
    fullName: '',
    avatar: '',
    email: '',
    doctorName: '',
    specialization: '',
    averageRating: 0,
    totalRatings: 0,
    availabilityStatus: '',
  ).obs;

  var isLoading = false.obs;
  final String apiUrl = '$baseUrl/doctor/updateDoctor';

  // Fetch doctor details (already implemented as shown before)

  // Update doctor profile
  Future<void> updateDoctorProfile(Map<String, dynamic> updates) async {
    isLoading(true); // Show loading indicator
    try {
      final token = await _tokenService.getToken();

      final response = await http.put(
        Uri.parse(
            '$apiUrl/${doctor.value.id}'), // Construct API endpoint with doctor ID
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Send the token in headers
        },
        body: jsonEncode(updates), // Convert updates map to JSON
      );

      if (response.statusCode == 200) {
        // Parse the updated doctor data from the response
        var updatedData = json.decode(response.body);
        doctor.update((doc) {
          doc?.fullName = updatedData['fullName'];
          doc?.email = updatedData['email'];
          doc?.specialization = updatedData['specialization'];
          doc?.licenseNumber = updatedData['licenseNumber'];
          doc?.bio = updatedData['bio'];
          doc?.clinicName = updatedData['clinicName'];
          doc?.clinicAddress = updatedData['clinicAddress'];
          doc?.consultationFee =
              (updatedData['consultationFee'] ?? 0).toDouble();
          doc?.locationCoordinates = (updatedData['location'] != null &&
                  updatedData['location']['coordinates'] != null)
              ? List<double>.from(updatedData['location']['coordinates']
                  .map((e) => e.toDouble()))
              : null;
        });
        Get.snackbar("Success", "Profile updated successfully");
      } else {
        // Handle non-200 status code
        Get.snackbar("Error", "Failed to update profile");
      }
    } catch (error) {
      print('Error updating profile: $error');
      Get.snackbar("Error", "An error occurred while updating the profile");
    } finally {
      isLoading(false); // Hide loading indicator
    }
  }
}

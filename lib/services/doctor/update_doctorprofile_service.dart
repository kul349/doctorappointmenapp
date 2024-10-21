import 'dart:convert';
import 'dart:io';
import 'package:doctorappointmenapp/models/doctor/gride_model.dart';
import 'package:doctorappointmenapp/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:doctorappointmenapp/services/token_service.dart';

class UpdateDoctorProfileService {
  final TokenService _tokenService = TokenService();

  // Fetch doctor profile by ID
  Future<DoctorModel?> fetchDoctorProfile(String doctorId) async {
    print("Fetch doctor profile by ID: $doctorId");
    try {
      final token = await _tokenService.getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/doctor/doctor-details/$doctorId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return DoctorModel.fromJson(data); // Convert JSON to DoctorModel
      } else {
        print('Failed to fetch doctor profile: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error fetching doctor profile: $error');
      return null;
    }
  }

  // Ensure this is the same as your base URL

  Future<void> updateDoctorProfile(
      String doctorId, Map<String, dynamic> updates, File? avatarFile) async {
    try {
      final token = await _tokenService.getToken();

      var request = http.MultipartRequest(
        'PUT',
        Uri.parse('$baseUrl/doctor/updateDoctor/$doctorId'),
      );

      // Add headers
      request.headers.addAll({
        "Authorization": "Bearer $token",
      });

      // Add form fields (the updates)
      updates.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      // Log the request fields for debugging
      print("Request Fields: ${request.fields}");

      // Add the avatar file if provided
      if (avatarFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath('avatar', avatarFile.path),
        );
      }

      // Send the request and capture the response
      var response = await request.send();

      // Handle the response
      if (response.statusCode == 200) {
  var responseData = await response.stream.bytesToString();
  var jsonResponse = jsonDecode(responseData);
  
  // Handle success
  print('Profile updated successfully: ${jsonResponse['updatedDoctor']}');
  
  // Optionally check the message if you want:
  if (jsonResponse['message'] != null) {
    print('Message from server: ${jsonResponse['message']}');
  }
} else {
  var errorData = await response.stream.bytesToString();
  print('Error Data: $errorData');
  throw Exception('Error: ${response.statusCode}');
}
    } catch (e) {
      print('Error updating profile: $e');
      // Consider rethrowing or handling the error appropriately
      throw e; // This will allow the UI to capture the error
    }
  }
}

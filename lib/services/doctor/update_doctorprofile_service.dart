import 'dart:convert';
import 'dart:io';
import 'package:doctorappointmenapp/models/doctor/gride_model.dart';
import 'package:http/http.dart' as http;
import 'package:doctorappointmenapp/services/token_service.dart';
import 'package:doctorappointmenapp/utils/constant.dart';

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

  Future<Map<String, dynamic>?> updateDoctorProfileWithAvatar(
      String doctorId, Map<String, dynamic> updates, File? avatar) async {
    try {
      final token = await _tokenService.getToken();
      final request = http.MultipartRequest(
        'PUT',
        Uri.parse('$baseUrl/doctor/updateDoctor/$doctorId'),
      );

      request.headers['Authorization'] = 'Bearer $token';

      // Add other fields
      request.fields['fullName'] = updates['fullName'];
      request.fields['doctorName'] = updates['doctorName'];
      request.fields['clinicAddress'] = updates['clinicAddress'];
      request.fields['licenseNumber'] = updates['licenseNumber'];
      request.fields['consultationFee'] = updates['consultationFee'].toString();
      request.fields['bio'] = updates['bio'];
      request.fields['clinicName'] = updates['clinicName'];

      // Add the avatar if provided
      if (avatar != null) {
        request.files
            .add(await http.MultipartFile.fromPath('avatar', avatar.path));
      }

      // Send the request
      final response = await request.send();

      // Check for success
      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final updatedData = json.decode(responseString);

        // Ensure the response contains the necessary data
        if (updatedData != null && updatedData.isNotEmpty) {
          print("date are updated successfully:${responseData}");
          print(response.statusCode);
          return updatedData; // Return the updated data
        } else {
          throw Exception('Profile update failed: No data returned.');
        }
      } else {
        // Log and throw the error message from the server
        final responseData = await response.stream.toBytes();
        final errorString = String.fromCharCodes(responseData);
        print(
            'Failed to update profile, status code: ${response.statusCode}, error: $errorString');
        throw Exception(
            'Failed to update profile: ${json.decode(errorString)['message']}');
      }
    } catch (error) {
      print('Error updating profile: $error');
      throw Exception('Error updating profile: $error');
    }
  }
}

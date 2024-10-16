import 'dart:convert';
import 'package:doctorappointmenapp/models/doctor/gride_model.dart';
import 'package:http/http.dart' as http;
import 'package:doctorappointmenapp/services/token_service.dart';
import 'package:doctorappointmenapp/utils/constant.dart';

class UpdateDoctorprofileService {
  final TokenService _tokenService = TokenService();

  // Fetch doctor profile by ID
  Future<DoctorModel?> fetchDoctorProfile(String doctorId) async {
    print("Fetch doctor profile by ID:${doctorId}");
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

        // Convert JSON to DoctorModel and return
        return DoctorModel.fromJson(data);
      } else {
        print('Failed to fetch doctor profile: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error fetching doctor profile: $error');
      return null;
    }
  }

  // Update doctor profile
  Future<Map<String, dynamic>?> updateDoctorProfile(
      String doctorId, Map<String, dynamic> updates) async {
    try {
      final token = await _tokenService.getToken();
      final response = await http.put(
        Uri.parse('$baseUrl/doctor/updateDoctor/$doctorId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(updates),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Failed to update profile, status code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error updating profile: $error');
      return null;
    }
  }
}

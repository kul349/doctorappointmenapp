import 'package:doctorappointmenapp/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class DoctorAuthService {
  Future<bool> registerDoctor({
    required String fullName,
    required String email,
    required String doctorName,
    required String password,
    required String specialization,
    required String qualification,
    required String experience,
    required File avatarImage, // Avatar image parameter
  }) async {
    final url = Uri.parse('$baseUrl/doctor/register');

    // Create a multipart request
    final request = http.MultipartRequest('POST', url)
      ..fields['fullName'] = fullName
      ..fields['email'] = email
      ..fields['doctorName'] = doctorName
      ..fields['password'] = password
      ..fields['specialization'] = specialization
      ..fields['qualification'] = qualification
      ..fields['experience'] = experience;

    // Add avatar image to the request
    if (avatarImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'avatar', // This should match the expected key in your backend
        avatarImage.path,
      ));
    }

    // Send the request
    final response = await request.send();

    if (response.statusCode == 200) {
      return true; // Registration successful
    } else {
      // Log the error response for debugging
      final responseString = await response.stream.bytesToString();
      print('Error: $responseString');
      return false; // Registration failed
    }
  }
}

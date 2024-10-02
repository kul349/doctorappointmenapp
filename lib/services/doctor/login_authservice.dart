import 'dart:convert';

import 'package:doctorappointmenapp/models/doctor/gride_model.dart';
import 'package:doctorappointmenapp/services/token_service.dart';
import 'package:doctorappointmenapp/utils/constant.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class DoctorLoginAuthService {
  final TokenService _tokenService = TokenService(); // Instance of TokenService

  // Function to handle doctor login and store token
  Future<DoctorModel?> doctorLogin(String email, String password) async {
    try {
       final fcmToken = await FirebaseMessaging.instance.getToken();
      print('FCM Token: $fcmToken');
      final url =
          Uri.parse('$baseUrl/doctor/login'); // API endpoint for doctor login
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password,'fcmToken':fcmToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final accessToken = data['data']?['accessToken'] as String?;

        if (accessToken != null && accessToken.isNotEmpty) {
          await _tokenService.storeToken(accessToken); // Store the token
          final doctorJson = data['data']?['doctor'] ??
              {}; // Change key to match actual structure
          return DoctorModel.fromJson(doctorJson);
        } else {
          return null;
        }
      } else {
        print('Login failed: ${response.body}');
        return null;
      }
    } catch (e) {
      print('An error occurred during login: $e');
      return null;
    }
  }

  // Function to log out the doctor
  Future<void> doctorLogout() async {
    try {
      final token = await _tokenService.getToken();
      final response = await http.post(Uri.parse("$baseUrl/doctor/logout"),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          });

      if (response.statusCode == 200) {
        _tokenService.removeToken();
        print("Successfully logged out from backend and app");
      }
    } catch (e) {
      print('An error occurred during logout: $e');
      throw Exception('Error during logout');
    }
  }
}

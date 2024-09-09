import 'dart:convert';

import 'package:doctorappointmenapp/services/token_service.dart';
import 'package:doctorappointmenapp/utils/constant.dart';
import 'package:http/http.dart' as http;

class AuthService {
  // Future<bool> registerPatient(String email, String password) async {
  //   // Implement your patient registration logic here
  //   // Example: Send email and password to your backend or Firebase
  //   return true; // Example
  // }

  // Future<bool> registerDoctor(String email, String password) async {
  //   // Implement your doctor registration logic here
  //   // Example: Send email and password to your backend or Firebase
  //   return true; // Example
  // }

// login-user and token
  // Replace with your API URL
  final TokenService _tokenService = TokenService(); // Instance of TokenService

  // Function to handle login and store token
  Future<String?> login(String email, String password) async {
    try {
      final url = Uri.parse('$baseUrl/login'); // API endpoint for login
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body); // Parse the response body
        final token = data['token']; // Extract the token from the response

        await _tokenService
            .storeToken(token); // Store the token using TokenService

        return token; // Return the token if needed
      } else {
        print('Login failed: ${response.body}'); // Handle error response
        return null;
      }
    } catch (e) {
      print('An error occurred during login: $e');
      return null;
    }
  }

  // Function to log out and remove the token
  Future<void> logout() async {
    await _tokenService.removeToken();
  }
}

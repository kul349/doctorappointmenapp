import 'dart:convert';
import 'package:doctorappointmenapp/models/patient/patient_model.dart';
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
  final TokenService _tokenService = TokenService(); // Instance of TokenService

  // Function to handle user login and store token
  Future<UserModel?> login(String email, String password) async {
    try {
      final url = Uri.parse('$baseUrl/users/login'); // API endpoint for login
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        print('Response body: ${response.body}'); // Debugging line
        final data = jsonDecode(response.body); // Parse the response body

        final accessToken =
            data['data']?['accessToken'] as String?; // Extract the accessToken

        if (accessToken != null && accessToken.isNotEmpty) {
          await _tokenService
              .storeToken(accessToken); // Store the token using TokenService

          final userJson =
              data['data']?['user'] ?? {}; // Safely parse the user data
          return UserModel.fromJson(userJson); // Return the parsed user model
        } else {
          print('Access token is null or empty'); // Debugging line
          return null;
        }
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
    try {
      await _tokenService.removeToken(); // Remove the token from secure storage
      print('Successfully logged out');
    } catch (e) {
      print('An error occurred during logout: $e');
    }
  }
}

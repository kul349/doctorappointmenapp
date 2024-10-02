// token_service.dart
import 'package:doctorappointmenapp/routes/app_routes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class TokenService {
  final _storage = FlutterSecureStorage();
  final _tokenKey = 'authToken';

  Future<void> storeToken(String token) async {
    try {
      await _storage.write(key: _tokenKey, value: token);
      print('Token stored successfully: $token'); // Debugging line
    } catch (e) {
      print('Failed to store token: $e');
    }
  }

  Future<String?> getToken() async {
    try {
      final token = await _storage.read(key: _tokenKey);
      print('Retrieved token: $token'); // Debugging line
      return token;
    } catch (e) {
      print('Failed to retrieve token: $e');
      return null;
    }
  }

  Future<void> removeToken() async {
    try {
      await _storage.delete(key: _tokenKey);
      print('Token removed successfully'); // Debugging line
    } catch (e) {
      print('Failed to remove token: $e');
    }
  }

  // check the session of the token
  Future<void> checkSessionAndRedirect() async {
    String? token = await getToken();

    if (token != null) {
      bool isExpired = JwtDecoder.isExpired(token);
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

      if (isExpired) {
        // Check if the token belongs to a doctor or patient by verifying the keys in the token
        final bool isDoctor = decodedToken.containsKey('doctorName') ||
            decodedToken.containsKey('specialization');
        final bool isPatient =
            decodedToken.containsKey('userName') && !isDoctor;

        if (isDoctor) {
          // Session expired, redirect to doctor login
          await removeToken(); // Clear the token
          Get.offAllNamed(AppRoutes
              .DOCTOR_LOGIN); // Assuming you're using GetX for navigation
        } else if (isPatient) {
          // Session expired, redirect to patient login
          await removeToken(); // Clear the token
          Get.offAllNamed(AppRoutes
              .PATIENT_LOGIN); // Assuming you're using GetX for navigation
        } else {
          print(
              'Unknown token type, unable to identify user as doctor or patient.');
        }
      } else {
        print('Token is still valid.');
        // Proceed with normal app flow as the token is valid
      }
    } else {
      print('No token found, redirect to login.');
      // Redirect to a common login page if no token is found
      Get.offAllNamed(AppRoutes.HOME); // Or handle based on your app's flow
    }
  }
}

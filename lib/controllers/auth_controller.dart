// auth_controller.dart

import 'package:doctorappointmenapp/models/patient/patient_model.dart';
import 'package:doctorappointmenapp/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:doctorappointmenapp/services/auth_service.dart';
import 'package:doctorappointmenapp/services/token_service.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  final TokenService _tokenService =
      TokenService(); // Add TokenService instance
  Rx<UserModel?> userModel = Rx<UserModel?>(null);
  var patientId =
      ''.obs; // Add this line to create an observable for patient ID

  Future<void> checkUserLoginStatus() async {
    final token = await _tokenService.getToken();

    if (token != null && token.isNotEmpty) {
      print('Token found: $token');

      // Decode the token and extract the userId
      final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      String? id = decodedToken['_id']; // Assuming '_id' holds the userId

      if (id != null && id.isNotEmpty) {
        patientId.value = id; // Store the userId in the observable
        print('User ID: ${patientId.value}');

        // Navigate to the home screen with the patientId
        Get.offAllNamed(AppRoutes.HOMESCREEN,
            parameters: {'patientId': patientId.value});
      } else {
        print('User ID not found in token');
        Get.offAllNamed(AppRoutes.HOME);
      }
    } else {
      print('Token not found');
      Get.offAllNamed(AppRoutes.HOME);
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      final user = await _authService.login(email, password);

      if (user != null) {
        userModel.value = user;
        patientId.value = user.patientId; // Store patient ID
        print('Patient ID after login: ${patientId.value}');

        // Retrieve and print the token to confirm it was stored
        final token = await _tokenService.getToken();
        if (token == null || token.isEmpty) {
          print('Token not found after login');
        } else {
          print('Token after login: $token');
        }
        Get.offAllNamed(AppRoutes.HOMESCREEN);
      } else {
        Get.snackbar('Error', 'Login failed. Please try again.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Login failed. Please try again');
    }
  }

  Future<void> logoutUser() async {
    await _authService.logout();
    Get.offAllNamed('/login');
  }

  void doctorLogout() {}
}

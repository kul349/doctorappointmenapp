// auth_controller.dart
import 'package:doctorappointmenapp/services/auth_service.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  // Function to handle user login
  Future<void> loginUser(String email, String password) async {
    final token = await _authService.login(email, password); // Perform login

    if (token != null) {
      // Navigate to the home screen if login is successful
      Get.offAllNamed('/home');
    } else {
      // Show error message if login fails
      Get.snackbar('Error', 'Login failed. Please try again.');
    }
  }

  // Function to handle user logout
  Future<void> logoutUser() async {
    await _authService.logout(); // Perform logout
    Get.offAllNamed('/login'); // Navigate to the login screen
  }
}

import 'package:doctorappointmenapp/routes/app_routes.dart';
import 'package:doctorappointmenapp/services/token_service.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));

    final token = await TokenService().getToken();
    if (token != null) {
      // Check if token is expired
      bool isExpired = JwtDecoder.isExpired(token);

      if (isExpired) {
        // Handle expired token: check user type and redirect to login
        final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        final bool isDoctor = decodedToken.containsKey('doctorName') ||
            decodedToken.containsKey('specialization');

        if (isDoctor) {
          Get.offAllNamed(AppRoutes.DOCTOR_LOGIN); // Redirect to doctor login
        } else {
          Get.offAllNamed(AppRoutes.PATIENT_LOGIN); // Redirect to patient login
        }
        return; // Exit to stop further execution
      }

      try {
        // Decode the token and print the entire content
        final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        print("Decoded token: $decodedToken");

        String? doctorId = decodedToken['_id'];
        String? doctorName = decodedToken['doctorName'];
        print(doctorName);

        // Check for specific fields to determine role
        final bool isDoctor = decodedToken.containsKey('doctorName') ||
            decodedToken.containsKey('specialization');
        final bool isPatient =
            decodedToken.containsKey('userName') && !isDoctor;

        // Navigate based on role
        if (isDoctor) {
          Get.offAllNamed(
            AppRoutes.doctoDashboardView,
            arguments: {'doctorId': doctorId, "doctorName": doctorName},
          );
        } else if (isPatient) {
          Get.offAllNamed(
            AppRoutes.HOMESCREEN,
          );
        } else {
          Get.offAllNamed(AppRoutes.HOME);
        }
      } catch (e) {
        print('Error decoding token: $e');
        Get.offAllNamed(AppRoutes.HOME);
      }
    } else {
      Get.offAllNamed(AppRoutes.HOME); // Redirect to home if no token
    }
  }
}

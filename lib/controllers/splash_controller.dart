import 'package:doctorappointmenapp/controllers/auth_controller.dart';
import 'package:doctorappointmenapp/routes/app_routes.dart';
import 'package:doctorappointmenapp/services/token_service.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class SplashController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));

    // Get the token
    final token = await TokenService().getToken();
    if (token != null) {
      try {
        // Decode the token
        final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        String? doctorId = decodedToken['_id'];
        print("GotdoctorId:$doctorId ");
        // Check for specific fields to determine the role
        final bool isDoctor = decodedToken.containsKey('doctorName') ||
            decodedToken.containsKey('specialization');

        final bool isPatient = decodedToken.containsKey('userName') &&
            !isDoctor; // Ensure it's not a doctor

        // Navigate based on role
        if (isDoctor) {
          Get.offAllNamed(
            AppRoutes.doctoDashboardView,
            arguments: {'doctorId': doctorId}, // Pass doctorId as an argument
          ); // Navigate to doctor dashboard
        } else if (isPatient) {
          Get.offAllNamed(AppRoutes.HOMESCREEN); // Navigate to patient homepage
        } else {
          Get.offAllNamed(
              AppRoutes.HOME); // Navigate to login if role is unknown
        }
      } catch (e) {
        print('Error decoding token: $e'); // Log error
        Get.offAllNamed(AppRoutes.HOME); // Navigate to login on error
      }
    } else {
      Get.offAllNamed(AppRoutes.HOME); // Navigate to login if no token
    }
  }
}

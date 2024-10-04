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
      try {
        print(token);
        // Decode the token and print the entire content
        final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        print("Decoded token: $decodedToken");

        String? doctorId = decodedToken['_id'];
        print("Got doctorId: $doctorId");

        // Check for specific fields
        final bool isDoctor = decodedToken.containsKey('doctorName') ||
            decodedToken.containsKey('specialization');

        final bool isPatient =
            decodedToken.containsKey('userName') && !isDoctor;

        // Navigate based on role
        if (isDoctor) {
          Get.offAllNamed(
            AppRoutes.doctoDashboardView,
            arguments: {'doctorId': doctorId},
          );
        } else if (isPatient) {
          String? patientId = decodedToken['_id'];
          print("Got patient: $patientId");
          Get.offAllNamed(AppRoutes.HOMESCREEN);
        } else {
          Get.offAllNamed(AppRoutes.HOME);
        }
      } catch (e) {
        print('Error decoding token: $e');
        Get.offAllNamed(AppRoutes.HOME);
      }
    } else {
      Get.offAllNamed(AppRoutes.HOME);
    }
  }
}

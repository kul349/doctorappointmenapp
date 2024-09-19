import 'package:doctorappointmenapp/controllers/auth_controller.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();
  @override
  void onInit() {
    super.onInit();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    _authController.checkUserLoginStatus();
  }
}

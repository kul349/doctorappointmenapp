import 'package:get/get.dart';
import '../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offAllNamed(AppRoutes.HOME);
  }
}

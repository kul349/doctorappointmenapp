import 'package:get/get.dart';
import '../views/splash/splash_view.dart';
import '../views/home_view.dart';

class AppRoutes {
  // Define route names as static constants
  static const SPLASH = '/';
  static const HOME = '/home';

  // List of GetPages that defines the routes and their corresponding views
  static final routes = [
    GetPage(
      name: SPLASH, 
      page: () => SplashView(),
    ),
    GetPage(
      name: HOME, 
      page: () => HomeView(),
    ),
  ];
}

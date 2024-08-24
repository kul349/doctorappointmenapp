import 'package:doctorappointmenapp/views/registration/register_pat.dart';
import 'package:doctorappointmenapp/views/registration/regitster_doct.dart';
import 'package:get/get.dart';
import '../views/splash/splash_view.dart';
import '../views/home_view.dart';

class AppRoutes {
  // Define route names as static constants
  static const SPLASH = '/';
  static const HOME = '/home';
  static const PATIENT_REGISTER = '/patient_register';
  static const DOCTOR_REGISTER = '/doctor_register';

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
    GetPage(
      name: PATIENT_REGISTER,
      page: () => PatientRegisterView(),
    ),
    GetPage(
      name: DOCTOR_REGISTER,
      page: () => DoctorRegisterView(),
    ),
  ];
}

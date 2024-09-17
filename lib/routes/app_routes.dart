import 'package:doctorappointmenapp/views/notification/notification.dart';
import 'package:doctorappointmenapp/views/patient/appointment.dart';
import 'package:doctorappointmenapp/views/patient/home_screen.dart';
import 'package:doctorappointmenapp/views/registration/doctor_login.dart';
import 'package:doctorappointmenapp/views/registration/patient_login.dart';
import 'package:doctorappointmenapp/views/registration/register_pat.dart';
import 'package:doctorappointmenapp/views/registration/regitster_doct.dart';
import 'package:get/get.dart';
import '../views/splash/splash_view.dart';
import '../views/home_view.dart';

class AppRoutes {
  // Define route names as static constants
  static const splash = '/';
  static const HOME = '/home';
  static const patientRegister = '/patientRegister';
  static const DOCTOR_REGISTER = '/doctor_register';
  static const DOCTOR_LOGIN = '/doctor_login';
  static const PATIENT_LOGIN = '/Patient_login';
  static const HOMESCREEN = '/homescreen';
  static const APPOINTMENTVIEW = '/apointmentsview';
  static const NOTIFICATION =
      '/notifications'; // Remove the space before 'notifications'

  // List of GetPages that defines the routes and their corresponding views
  static final routes = [
    GetPage(
      name: splash,
      page: () => splashView(),
    ),
    GetPage(
      name: HOME,
      page: () => const HomeView(),
    ),
    GetPage(
      name: patientRegister,
      page: () => const PatientRegisterView(),
    ),
    GetPage(
      name: DOCTOR_REGISTER,
      page: () => DoctorRegisterView(),
    ),
    GetPage(
      name: DOCTOR_LOGIN,
      page: () => DoctorLoginView(),
    ),
    GetPage(
      name: PATIENT_LOGIN,
      page: () => const PatientLoginView(),
    ),
    GetPage(
      name: HOMESCREEN,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: NOTIFICATION,
      page: () => const NotificationView(),
    ),
    GetPage(
      name: APPOINTMENTVIEW,
      page: () => const AppointmentView(),
    ),
  ];
}

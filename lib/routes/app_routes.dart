import 'package:doctorappointmenapp/views/notification/notification.dart';
import 'package:doctorappointmenapp/views/patient/appointment.dart';
import 'package:doctorappointmenapp/views/patient/get_ratting_page.dart';
import 'package:doctorappointmenapp/views/patient/home_screen.dart';
import 'package:doctorappointmenapp/views/registration/doctor_login.dart';
import 'package:doctorappointmenapp/views/registration/patient_login.dart';
import 'package:doctorappointmenapp/views/registration/register_pat.dart';
import 'package:doctorappointmenapp/views/registration/regitster_doct.dart';
import 'package:doctorappointmenapp/widgets/doctor/appointment_list.dart';
import 'package:doctorappointmenapp/widgets/doctor/doctor_dasboard.dart';
import 'package:doctorappointmenapp/widgets/doctor/doctor_notificaiton.dart';
import 'package:get/get.dart';
import '../views/splash/splash_view.dart';
import '../views/home_view.dart';

class AppRoutes {
  // Define route names as static constants
  static const splash = '/';
  static const HOME = '/home';
  static const patientRegister = '/patientRegister';
  static const doctorRegister = '/doctor_register';
  static const DOCTOR_LOGIN = '/doctor_login';
  static const PATIENT_LOGIN = '/Patient_login';
  static const HOMESCREEN = '/homescreen';
  static const APPOINTMENTVIEW = '/apointmentsview';
  static const NOTIFICATION =
      '/notifications'; // Remove the space before 'notifications'
  static const addRating = '/addRating';
  // List of GetPages that defines the routes and their corresponding views
  static const doctoDashboardView = '/dashboard';
  static const patientAppointmentView = '/patientAppointmentView';
  static const doctornotificationview = '/doctornotificationview';
  static final routes = [
    GetPage(
      name: splash,
      page: () => SplashView(),
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
      name: doctorRegister,
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
      page: () =>  NotificationPage(),
    ),
    GetPage(
      name: APPOINTMENTVIEW,
      page: () => AppointmentView(
        doctorId: 'doctorId',
      ),
    ),
    GetPage(
      name: addRating,
      page: () => RatingPage(
        doctorId: Get.arguments['doctorId'],
      ), // Pass the doctorId
    ),
    // for doctorside
    GetPage(
      name: doctoDashboardView,
      page: () => DoctorDashboardView(),
    ),
    GetPage(
        name: patientAppointmentView,
        page: () => PatientAppointmentView(
              doctorId: Get.arguments['doctorId'],
            )),
    GetPage(
      name: AppRoutes
          .doctornotificationview, // Ensure this matches the route name
      page: () {
        final String doctorId = Get.arguments; // Retrieve the passed argument
        return DoctorNotificationPage(
          userId: doctorId, // Pass the doctorId to the DoctorNotificationPage
        );
      },
    ),
  ];
}

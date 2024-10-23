import 'package:doctorappointmenapp/utils/constant.dart';
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
import 'package:doctorappointmenapp/widgets/doctor/edit_doctor_profile.dart';
import 'package:doctorappointmenapp/widgets/doctor/profile_update.dart';
import 'package:doctorappointmenapp/widgets/doctor/rating_review_list.dart';
import 'package:get/get.dart';
import '../views/splash/splash_view.dart';
import '../views/home_view.dart';

  // Define route names as static constants
 
  List<GetPage> routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashView(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
    ),
    GetPage(
      name: AppRoutes.patientRegister,
      page: () => const PatientRegisterView(),
    ),
    GetPage(
      name: AppRoutes.doctorRegister,
      page: () => DoctorRegisterView(),
    ),
    GetPage(
      name: AppRoutes.doctorLogin,
      page: () => DoctorLoginView(),
    ),
    GetPage(
      name: AppRoutes.patientLogin,
      page: () => const PatientLoginView(),
    ),
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.notification,
      page: () => NotificationPage(),
    ),
    GetPage(
      name: AppRoutes.appointmentView,
      page: () => AppointmentView(
        doctorId: 'doctorId',
      ),
    ),
    GetPage(
      name: AppRoutes.addRating,
      page: () => RatingPage(
        doctorId: Get.arguments['doctorId'],
      ), // Pass the doctorId
    ),
    // for doctorside
    GetPage(
      name:AppRoutes.doctoDashboardView,
      page: () => DoctorDashboardView(),
    ),
    GetPage(
        name: AppRoutes.patientAppointmentView,
        page: () => PatientAppointmentView(
              doctorId: Get.arguments['doctorId'],
            )),
    GetPage(
      name: AppRoutes.doctornotificationview,
      page: () {
        // Ensure you are receiving a Map
        final Map<String, String> args = Get.arguments as Map<String, String>;
        final String doctorId =
            args['doctorId'] ?? ''; // Retrieve doctorId from the map
        return DoctorNotificationPage(userId: doctorId);
      },
    ),
    GetPage(
      name:AppRoutes.reviewRating,
      page: () => DoctorReviewsPage(
        Get.arguments['doctorId'],
      ),
    ),
    GetPage(
        name: AppRoutes.doctorProfileUpdate,
        page: () {
          final String doctorId = Get.arguments['doctorId'];
          print("doctorIdasd :${doctorId}"); // Correct way to retrieve
          return DoctorProfile(doctorId: doctorId);
        }),
    GetPage(
      name: AppRoutes.editDoctorProfile,
      page: () {
        final String doctorId =
            Get.arguments['doctorId']; // Correctly retrieving doctorId
        print("doctorId: $doctorId"); // Logging to confirm
        return EditDoctorProfilePage(
            // doctorId: doctorId, // Passing doctorId to the widget
            );
      },
    ),
  ];


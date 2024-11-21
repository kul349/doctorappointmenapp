// const String baseUrl = 'https://backendserver-jivo.onrender.com/api/v1';
const String notificationChannelId = 'doctor_notifications';
const String notificationChannelName = 'Doctor Notifications';
const String baseUrl = 'http://192.168.60.73:8000/api/v1';

class AppRoutes {
// list of static routes:
  static const String splash = '/';
  static const String home = '/home';
  static const String patientRegister = '/patientRegister';
  static const String doctorRegister = '/doctor_register';
  static const String doctorLogin = '/doctor_login';
  static const String patientLogin = '/patient_login';
  static const String homeScreen = '/homescreen';
  static const String appointmentView = '/appointmentview';
  static const String notification = '/notification';
  static const String addRating = '/addRating';
  static const String editDoctorProfile = '/editDoctorProfile';
  // List of GetPages that defines the routes and their corresponding views
  static const String doctoDashboardView = '/dashboard';
  static const String patientAppointmentView = '/patientAppointmentView';
  static const String doctornotificationview = '/doctornotificationview';
  static const String reviewRating = '/reviewRating';
  static const String doctorProfileUpdate = '/doctorProfileUpdate';
  static const String map = '/map';
}

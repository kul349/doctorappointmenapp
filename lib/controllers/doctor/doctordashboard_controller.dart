import 'package:doctorappointmenapp/models/doctor/gride_model.dart';
import 'package:doctorappointmenapp/services/doctor/update_doctorProfile_service.dart';
import 'package:get/get.dart';

class DoctorProfileUpdateController extends GetxController {
  final UpdateDoctorprofileService _doctorService =
      UpdateDoctorprofileService();
  var doctor = DoctorModel(
    id: '',
    fullName: '',
    avatar: '',
    email: '',
    doctorName: '',
    specialization: '',
    averageRating: 0,
    totalRatings: 0,
    availabilityStatus: '',
    clinicAddress: null, // Ensure these are included in the model
    licenseNumber: null,
    consultationFee: 0.0,
    
    bio: null,
    clinicName: null,
    locationCoordinates: null,
  ).obs;

  var isLoading = false.obs;
  var errorMessage = ''.obs; // Variable to hold error messages

  // Fetch doctor profile by ID
  Future<void> fetchDoctorProfile(String doctorId) async {
    isLoading(true);
    errorMessage(''); // Reset error message
    try {
      final doctorData = await _doctorService.fetchDoctorProfile(doctorId);
      if (doctorData != null) {
        doctor.value =
            doctorData; // Directly assign the fetched doctor profile to the observable
      } else {
        errorMessage(
            'Doctor not found.'); // Handle the case when no data is returned
      }
    } catch (error) {
      print('Error fetching profile: $error');
      errorMessage(
          'Error fetching profile: $error'); // Update the error message
    } finally {
      isLoading(false);
    }
  }

  // Update doctor profile
  Future<void> updateDoctorProfile(Map<String, dynamic> updates) async {
    isLoading(true);
    errorMessage(''); // Reset error message
    try {
      final updatedData =
          await _doctorService.updateDoctorProfile(doctor.value.id, updates);
      if (updatedData != null) {
        doctor.update((doc) {
          doc?.fullName = updatedData['fullName'];
          doc?.email = updatedData['email'];
          doc?.specialization = updatedData['specialization'];
          doc?.licenseNumber = updatedData['licenseNumber'];
          doc?.bio = updatedData['bio'];
          doc?.clinicName = updatedData['clinicName'];
          doc?.clinicAddress = updatedData['clinicAddress'];
          doc?.consultationFee =
              (updatedData['consultationFee'] ?? 0).toDouble();
          doc?.locationCoordinates = (updatedData['location'] != null &&
                  updatedData['location']['coordinates'] != null)
              ? List<double>.from(updatedData['location']['coordinates']
                  .map((e) => e.toDouble()))
              : null;
        });
        Get.snackbar("Success", "Profile updated successfully");
      } else {
        errorMessage(
            'Failed to update profile.'); // Handle the null return case
      }
    } catch (error) {
      print('Error updating profile: $error');
      errorMessage(
          'Error updating profile: $error'); // Update the error message
    } finally {
      isLoading(false);
    }
  }
}

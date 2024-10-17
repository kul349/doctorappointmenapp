import 'dart:io';
import 'package:doctorappointmenapp/models/doctor/gride_model.dart';
import 'package:doctorappointmenapp/services/doctor/update_doctorprofile_service.dart';
import 'package:get/get.dart';

class DoctorProfileUpdateController extends GetxController {
  final UpdateDoctorProfileService _doctorService =
      UpdateDoctorProfileService();

  // Observable for doctor profile
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
    clinicAddress: null,
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
        doctor.value = doctorData; // Assign fetched data
      } else {
        errorMessage(
            'Doctor not found.'); // Handle case when no data is returned
      }
    } catch (error) {
      print('Error fetching profile: $error');
      errorMessage('Error fetching profile: $error'); // Update error message
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateDoctorProfile(Map<String, dynamic> updates,
      {File? avatar}) async {
    isLoading(true);
    errorMessage(''); // Reset error message
    try {
      final updatedData = await _doctorService.updateDoctorProfileWithAvatar(
        doctor.value.id,
        updates,
        avatar,
      );

      if (updatedData != null) {
        doctor.update((doc) {
          doc?.fullName = updatedData['fullName'];
          // ... (update other fields)
          doc?.avatar = updatedData['avatar']; // Update avatar if returned
        });
        Get.snackbar("Success", "Profile updated successfully");
        Get.back(); // Navigate back to the previous page
      } else {
        errorMessage('Failed to update profile.'); // Handle null return case
      }
    } catch (error) {
      print('Error updating profile: $error');
      errorMessage('Error updating profile: $error'); // Update error message
    } finally {
      isLoading(false); // Stop loading regardless of success or failure
    }
  }
}

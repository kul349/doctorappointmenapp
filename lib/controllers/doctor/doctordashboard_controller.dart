import 'dart:io';
import 'package:doctorappointmenapp/models/doctor/gride_model.dart';
import 'package:doctorappointmenapp/services/doctor/update_doctorprofile_service.dart';
import 'package:flutter/material.dart';
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

  // Form fields for profile
  TextEditingController fullNameController = TextEditingController();
  TextEditingController doctorNameController = TextEditingController();
  TextEditingController clinicNameController = TextEditingController();
  TextEditingController clinicAddressController = TextEditingController();
  TextEditingController licenseNumberController = TextEditingController();
  TextEditingController consultationFeeController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  // File for avatar upload
  File? avatarFile;

  // Fetch doctor profile by ID and pre-populate form fields
  Future<void> fetchDoctorProfile(String doctorId) async {
    isLoading(true);
    errorMessage(''); // Reset error message
    try {
      final doctorData = await _doctorService.fetchDoctorProfile(doctorId);
      if (doctorData != null) {
        doctor.value = doctorData; // Assign fetched data

        // Populate form fields with existing data
        fullNameController.text = doctorData.fullName ?? '';
        doctorNameController.text = doctorData.doctorName ?? '';
        clinicNameController.text = doctorData.clinicName ?? '';
        clinicAddressController.text = doctorData.clinicAddress ?? '';
        licenseNumberController.text = doctorData.licenseNumber ?? '';
        consultationFeeController.text =
            doctorData.consultationFee?.toString() ?? '0.0';
        bioController.text = doctorData.bio ?? '';
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

  // Method to update the doctor profile
  Future<void> updateProfile(String doctorId) async {
    isLoading.value = true;

    try {
      Map<String, dynamic> updates = {
        'fullName': fullNameController.text,
        'doctorName': doctorNameController.text,
        'clinicName': clinicNameController.text,
        'clinicAddress': clinicAddressController.text,
        'licenseNumber': licenseNumberController.text,
        'consultationFee':
            double.tryParse(consultationFeeController.text) ?? 0.0,
        'bio': bioController.text,
      };

      // Call service to update profile
      await UpdateDoctorProfileService()
          .updateDoctorProfile(doctorId, updates, avatarFile);
      Get.snackbar('Success', 'Profile updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    // Dispose controllers when the controller is closed to prevent memory leaks
    fullNameController.dispose();
    doctorNameController.dispose();
    clinicNameController.dispose();
    clinicAddressController.dispose();
    licenseNumberController.dispose();
    consultationFeeController.dispose();
    bioController.dispose();
    super.onClose();
  }
}

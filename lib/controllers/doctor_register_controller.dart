import 'package:doctorappointmenapp/routes/app_routes.dart';
import 'package:doctorappointmenapp/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io'; // For File

class DoctorRegisterController extends GetxController {
  // Controllers for form fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final fullNameController = TextEditingController();
  final userNameController = TextEditingController();
  final specializationController = TextEditingController();
  final experienceController = TextEditingController();
  final licenseNumberController = TextEditingController();
  final qualificationsController = TextEditingController();
  final certificationsController = TextEditingController();
  final bioController = TextEditingController();

  // Avatar image file
  File? avatarImage;
  final authService = AuthService();

  // Replace with your backend URL
  final String baseUrl =
      'http://localhost:8000/api/v1/doctors/register'; // Adjust URL for your backend

  Future<void> registerDoctor() async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();
    final String confirmPassword = confirmPasswordController.text.trim();
    final String fullName = fullNameController.text.trim();
    final String userName = userNameController.text.trim();
    final String specialization = specializationController.text.trim();
    final String experience = experienceController.text.trim();
    final String licenseNumber = licenseNumberController.text.trim();
    final String qualifications = qualificationsController.text.trim();
    final String certifications = certificationsController.text.trim();
    final String bio = bioController.text.trim();

    if (password != confirmPassword) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    try {
      var request = http.MultipartRequest('POST', Uri.parse(baseUrl))
        ..fields['email'] = email
        ..fields['password'] = password
        ..fields['fullName'] = fullName
        ..fields['userName'] = userName
        ..fields['specialization'] = specialization
        ..fields['experience'] = experience
        ..fields['licenseNumber'] = licenseNumber
        ..fields['qualifications'] = qualifications
        ..fields['certifications'] = certifications
        ..fields['bio'] = bio;

      if (avatarImage != null) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'avatar',
            avatarImage!.readAsBytesSync(),
            filename: 'avatar.jpg',
          ),
        );
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final data = jsonDecode(responseBody);
        Get.snackbar('Success', 'Registration successful');
        print('Registration successful: ${data['message']}');
        Get.toNamed(AppRoutes.DOCTOR_LOGIN); // Navigate to login page
      } else {
        final errorData = jsonDecode(responseBody);
        Get.snackbar('Error', errorData['message'] ?? 'Registration failed');
        print('Registration failed: ${responseBody}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to connect to the server');
      print('Failed to register: $e');
    }
  }

  Future<void> selectAvatarImage() async {
    // Implement image selection logic here
    // For example, using image_picker package
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    fullNameController.dispose();
    userNameController.dispose();
    specializationController.dispose();
    experienceController.dispose();
    licenseNumberController.dispose();
    qualificationsController.dispose();
    certificationsController.dispose();
    bioController.dispose();
    super.onClose();
  }
}

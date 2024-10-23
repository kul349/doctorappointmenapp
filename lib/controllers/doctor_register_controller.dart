import 'dart:io';
import 'package:doctorappointmenapp/services/doctor/doctor_authservice.dart';
import 'package:doctorappointmenapp/utils/constant.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorRegisterController extends GetxController {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController doctorNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController specializationController =
      TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();

  File? avatarImage; // Field to hold the avatar image
  String? fcmToken;
  @override
  void onInit() {
    super.onInit();
    _getFcmToken(); // Get the FCM token when the controller is initialized
  }

  Future<void> _getFcmToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    fcmToken = await messaging.getToken();
    print('FCM Token: $fcmToken');
  }


  Future<void> registerDoctor() async {
    // Add validation for password confirmation
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    // Call the AuthService to register the doctor
    final isSuccess = await DoctorAuthService().registerDoctor(
      fullName: fullNameController.text,
      email: emailController.text,
      doctorName: doctorNameController.text,
      password: passwordController.text,
      specialization: specializationController.text,
      qualification: qualificationController.text,
      experience: experienceController.text,
      avatarImage: avatarImage!, // Ensure avatarImage is not null
      fcmToken:fcmToken!
    );

    if (isSuccess) {
      Get.snackbar("Success", "Doctor registered successfully");
      Get.offAllNamed(
          AppRoutes.doctorLogin); // Navigate to the doctor login page
    } else {
      Get.snackbar("Error", "Failed to register doctor");
    }
  }

  @override
  void onClose() {
    // Dispose of all text editing controllers
    fullNameController.dispose();
    doctorNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    specializationController.dispose();
    qualificationController.dispose();
    experienceController.dispose();
    super.onClose();
  }
}

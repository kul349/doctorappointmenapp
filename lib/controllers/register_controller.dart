import 'package:doctorappointmenapp/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final authService = AuthService();

  void registerPatient() async {
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    final result = await authService.registerPatient(email, password);

    if (result) {
      Get.snackbar('Success', 'Registration successful');
      // Navigate to login or home page
    } else {
      Get.snackbar('Error', 'Registration failed');
    }
  }

  void registerDoctor() async {
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    final result = await authService.registerDoctor(email, password);

    if (result) {
      Get.snackbar('Success', 'Registration successful');
      // Navigate to login or home page
    } else {
      Get.snackbar('Error', 'Registration failed');
    }
  }

  void loginWithGoogle() async {
    final result = await authService.signInWithGoogle();

    if (result) {
      Get.snackbar('Success', 'Logged in with Google');
      // Navigate to home page
    } else {
      Get.snackbar('Error', 'Google sign-in failed');
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}

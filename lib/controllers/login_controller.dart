import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void loginDoctor() {
    // Implement doctor login logic here
    print('Doctor Login: ${emailController.text}');
  }

  void loginPatient() {
    // Implement patient login logic here
    print('Patient Login: ${emailController.text}');
  }

  void loginWithGoogle() {
    // Implement Google login logic here
    print('Login with Google');
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

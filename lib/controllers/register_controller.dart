import 'package:doctorappointmenapp/services/auth_service.dart';
import 'package:doctorappointmenapp/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctorappointmenapp/routes/app_routes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:http_parser/http_parser.dart'; // For File

class RegisterController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  File? avatarImage; // Add this line to handle avatar image
  final authService = AuthService();

  // Replace with your backend URL

  Future<void> registerPatient() async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();
    final String confirmPassword = confirmPasswordController.text.trim();
    final String fullName = fullNameController.text.trim();
    final String userName = userNameController.text.trim();

    if (password != confirmPassword) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    try {
      var request = http.MultipartRequest('POST', Uri.parse(baseUrl))
        ..fields['email'] = email
        ..fields['password'] = password
        ..fields['fullName'] = fullName
        ..fields['userName'] = userName;

      if (avatarImage != null) {
        final bytes = await avatarImage!.readAsBytes();
        request.files.add(
          http.MultipartFile.fromBytes(
            'avatar',
            bytes,
            filename:
                avatarImage!.path.split('/').last, // Use the original filename
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      }

      final response = await request.send();

      final responseBody = await response.stream.bytesToString();

      print(response.statusCode);
      if (response.statusCode == 200) {
        final data = jsonDecode(responseBody);
        Get.snackbar('Success', 'Registration successful');
        print('Registration successful: ${data['message']}');

        Get.toNamed(AppRoutes.PATIENT_LOGIN);
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
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    fullNameController.dispose();
    userNameController.dispose();
    super.onClose();
  }
}

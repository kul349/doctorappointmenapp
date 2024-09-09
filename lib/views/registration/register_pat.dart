import 'dart:io';

import 'package:doctorappointmenapp/controllers/register_controller.dart';
import 'package:doctorappointmenapp/routes/app_routes.dart';
import 'package:doctorappointmenapp/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart'; // Add this for image picking

class PatientRegisterView extends StatelessWidget {
  const PatientRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterController controller = Get.put(RegisterController());
    final ImagePicker _picker = ImagePicker();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Patient Register',
          style: boldTextStyle.copyWith(color: whiteColor),
        ),
        backgroundColor: greenColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create your account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: greenColor,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: controller.fullNameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person, color: greenColor),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller.userNameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person, color: greenColor),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller.emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email, color: greenColor),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller.passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock, color: greenColor),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller.confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock, color: greenColor),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              // Avatar picker
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final XFile? pickedFile =
                          await _picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        controller.avatarImage = File(pickedFile.path);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: greenColor,
                    ),
                    child: Text('Pick Avatar',
                        style: mediumTextStyle.copyWith(color: whiteColor)),
                  ),
                  const SizedBox(width: 16),
                  if (controller.avatarImage != null)
                    CircleAvatar(
                      backgroundImage: FileImage(controller.avatarImage!),
                      radius: 30,
                    ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.registerPatient();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greenColor,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Register',
                    style: mediumTextStyle.copyWith(
                        color: whiteColor, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Center(
                child: TextButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.PATIENT_LOGIN);
                  },
                  child: Text(
                    'Already have an account? Login',
                    style:
                        boldTextStyle.copyWith(fontSize: 18, color: greenColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

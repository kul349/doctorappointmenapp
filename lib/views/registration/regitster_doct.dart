import 'dart:io';
import 'package:doctorappointmenapp/controllers/doctor_register_controller.dart';
import 'package:doctorappointmenapp/routes/app_routes.dart';
import 'package:doctorappointmenapp/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart'; // Add this for image picking

class DoctorRegisterView extends StatelessWidget {
  const DoctorRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final DoctorRegisterController controller =
        Get.put(DoctorRegisterController());
    final ImagePicker _picker = ImagePicker();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doctor Registration',
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
                'Register as a Doctor',
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
                controller: controller.doctorNameController,
                decoration: const InputDecoration(
                  labelText: 'Doctor Name',
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
              const SizedBox(height: 16),
              TextField(
                controller: controller.specializationController,
                decoration: const InputDecoration(
                  labelText: 'Specialization',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.local_hospital, color: greenColor),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller.qualificationController,
                decoration: const InputDecoration(
                  labelText: 'Qualification',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.school, color: greenColor),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller.experienceController,
                decoration: const InputDecoration(
                  labelText: 'Experience (years)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.timeline, color: greenColor),
                ),
                keyboardType: TextInputType.number,
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
                    controller.registerDoctor();
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
                    Get.toNamed(AppRoutes.DOCTOR_LOGIN);
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

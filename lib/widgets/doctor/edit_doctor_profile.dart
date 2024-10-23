import 'dart:io';
import 'package:doctorappointmenapp/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:doctorappointmenapp/controllers/doctor/doctordashboard_controller.dart';

class EditDoctorProfilePage extends StatelessWidget {
  final DoctorProfileUpdateController controller =
      Get.put(DoctorProfileUpdateController());

  EditDoctorProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String doctorId = Get.arguments['doctorId'];
    print("Retrieved doctorId: $doctorId");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Obx(() {
        return controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Title
                    const Text(
                      'Personal Information',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Full Name Field
                    _buildTextField(
                      controller.fullNameController,
                      'Full Name',
                      Icons.person_outline,
                    ),
                    const SizedBox(height: 16),
                    // Doctor Name Field
                    _buildTextField(
                      controller.doctorNameController,
                      'Doctor Name',
                      Icons.badge_outlined,
                    ),
                    const SizedBox(height: 16),
                    // Clinic Name Field
                    _buildTextField(
                      controller.clinicNameController,
                      'Clinic Name',
                      Icons.local_hospital_outlined,
                    ),
                    const SizedBox(height: 16),
                    // Avatar Image Picker
                    _buildImagePicker(controller),
                    const SizedBox(height: 32),
                    // Section Title
                    const Text(
                      'Clinic Information',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Clinic Address Field
                    _buildTextField(
                      controller.clinicAddressController,
                      'Clinic Address',
                      Icons.location_on_outlined,
                    ),
                    const SizedBox(height: 16),
                    // License Number Field
                    _buildTextField(
                      controller.licenseNumberController,
                      'License Number',
                      Icons.verified_outlined,
                    ),
                    const SizedBox(height: 16),
                    // Consultation Fee Field
                    _buildTextField(
                      controller.consultationFeeController,
                      'Consultation Fee',
                      Icons.attach_money_outlined,
                      TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    // Bio Field
                    _buildTextField(
                      controller.bioController,
                      'Bio',
                      Icons.info_outline,
                      TextInputType.text,
                    ),
                    const SizedBox(height: 30),
                    // Update Button
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (controller.fullNameController.text.isEmpty ||
                              controller.doctorNameController.text.isEmpty ||
                              controller.clinicNameController.text.isEmpty) {
                            Get.snackbar(
                                'Error', 'Please fill in all required fields.');
                            return;
                          }
                          // Update Profile
                          controller.updateProfile(doctorId);
                          print(
                              "Navigating to profile with doctorId: $doctorId");
                          Get.toNamed(AppRoutes.doctorProfileUpdate,
                              arguments: {'doctorId': doctorId});
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 16),
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Update Profile',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
      }),
    );
  }

  // Helper to build text fields
  Widget _buildTextField(
    TextEditingController controller,
    String labelText,
    IconData icon, [
    TextInputType inputType = TextInputType.text,
    int maxLines = 1,
  ]) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }

  // Helper to build the image picker button
  Widget _buildImagePicker(DoctorProfileUpdateController controller) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () async {
            final pickedFile =
                await ImagePicker().pickImage(source: ImageSource.gallery);
            if (pickedFile != null) {
              controller.avatarFile = File(pickedFile.path);
              Get.snackbar('Image Selected', 'Avatar has been selected.');
            } else {
              Get.snackbar('No Image', 'Please select an avatar image.');
            }
          },
          icon: const Icon(Icons.image_outlined),
          label: const Text('Choose Avatar'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          ),
        ),
        const SizedBox(height: 8),
        if (controller.avatarFile != null)
          Image.file(
            controller.avatarFile!,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          )
      ],
    );
  }
}

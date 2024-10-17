import 'package:doctorappointmenapp/controllers/doctor/doctordashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctorappointmenapp/models/doctor/gride_model.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker package
import 'dart:io';

class EditDoctorProfile extends StatefulWidget {
  const EditDoctorProfile({super.key});

  @override
  State<EditDoctorProfile> createState() => _EditDoctorProfileState();
}

class _EditDoctorProfileState extends State<EditDoctorProfile> {
  final DoctorProfileUpdateController doctorController = Get.find();
  final _formKey = GlobalKey<FormState>();
  late DoctorModel doctor;
  File? _image; // Variable to hold the selected image

  @override
  void initState() {
    super.initState();
    doctor = doctorController.doctor.value;
    final arguments = Get.arguments;
    final doctorId = arguments['doctorId'];
    print("doctorId for edit: $doctorId");
    // Optionally, you can fetch doctor data using doctorId here if necessary
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Show loading indicator
      final loadingDialog = Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      try {
        // Attempt to update the doctor profile
        await doctorController.updateDoctorProfile({
          "fullName": doctor.fullName,
          "doctorName": doctor.doctorName,
          "clinicAddress": doctor.clinicAddress,
          "licenseNumber": doctor.licenseNumber,
          "consultationFee": doctor.consultationFee,
          "bio": doctor.bio,
          "clinicName": doctor.clinicName,
          // Include the image if it's selected
          "avatar": _image != null ? _image!.path : doctor.avatar,
        });

        // Close the loading dialog
        Get.back(); // Close loading dialog

        // Optionally show a success message
        Get.snackbar("Success", "Profile updated successfully");

        // Delay the navigation to allow Snackbar to be displayed
        await Future.delayed(const Duration(seconds: 2));

        // Navigate back to the previous page (ensure this is correct)
        Get.offAllNamed('/profile'); // Change this to your profile route
      } catch (e) {
        // Close loading dialog on error
        Get.back(); // Close loading dialog
        Get.snackbar("Error", "Failed to update the profile: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Doctor Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : doctor.avatar.isNotEmpty
                          ? NetworkImage(doctor.avatar)
                          : const AssetImage('assets/placeholder.jpg')
                              as ImageProvider,
                  child: const Icon(Icons.edit),
                ),
              ),
              const SizedBox(height: 20),
              _buildTextFormField(
                label: 'Full Name',
                initialValue: doctor.fullName,
                onSaved: (value) => doctor.fullName = value!,
              ),
              _buildTextFormField(
                label: 'Doctor Name',
                initialValue: doctor.doctorName,
                onSaved: (value) => doctor.doctorName = value!,
              ),
              _buildTextFormField(
                label: 'Clinic Address',
                initialValue: doctor.clinicAddress ?? '',
                onSaved: (value) => doctor.clinicAddress = value!,
              ),
              _buildTextFormField(
                label: 'License Number',
                initialValue: doctor.licenseNumber ?? '',
                onSaved: (value) => doctor.licenseNumber = value!,
              ),
              _buildTextFormField(
                label: 'Consultation Fee',
                initialValue: doctor.consultationFee.toString(),
                onSaved: (value) =>
                    doctor.consultationFee = double.tryParse(value!) ?? 0,
              ),
              _buildTextFormField(
                label: 'Bio',
                initialValue: doctor.bio ?? '',
                maxLines: 3,
                onSaved: (value) => doctor.bio = value!,
              ),
              _buildTextFormField(
                label: 'Clinic Name',
                initialValue: doctor.clinicName ?? '',
                onSaved: (value) => doctor.clinicName = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text("Save Changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String label,
    required String initialValue,
    int maxLines = 1,
    required Function(String?) onSaved,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: initialValue,
        maxLines: maxLines,
        decoration: InputDecoration(labelText: label),
        onSaved: onSaved,
        validator: (value) => value!.isEmpty ? 'Please enter $label' : null,
      ),
    );
  }
}

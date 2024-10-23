import 'package:doctorappointmenapp/controllers/doctor/doctordashboard_controller.dart';
import 'package:doctorappointmenapp/themes/app_theme.dart';
import 'package:doctorappointmenapp/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorProfile extends StatefulWidget {
  final String doctorId;

  const DoctorProfile({super.key, required this.doctorId});

  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  final DoctorProfileUpdateController doctorController = Get.find();

  @override
  void initState() {
    super.initState();
    // Fetch doctor profile when the widget is initialized
    doctorController.fetchDoctorProfile(widget.doctorId);
  }

  @override
  Widget build(BuildContext context) {
    final String doctorId = Get.arguments['doctorId'] ?? '';

    return Scaffold(
      backgroundColor: kGreenLightColor,
      appBar: AppBar(
        title: const Text("Doctor Profile"),
      ),
      body: Obx(() {
        if (doctorController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Handle the case where doctor data might not be available
        if (doctorController.doctor.value.id.isEmpty) {
          return const Center(child: Text("No doctor data available."));
        }

        return ListView(
          children: [
            // Top container with background color and avatar in between
            Column(
              children: [
                // Top background container
                SizedBox(
                  height: 200,
                  width: MediaQuery.sizeOf(context).width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50, // Set the size of the avatar
                        backgroundImage: NetworkImage(
                          doctorController.doctor.value.avatar,
                        ), // Avatar image
                      ),
                      const SizedBox(height: 10), // Spacing below the avatar
                      Text(
                        doctorController.doctor.value.fullName,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom container with profile details
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20), // For spacing from avatar
                      _buildCustomListTile(
                        icon: Icons.person,
                        title:
                            "Full Name: ${doctorController.doctor.value.fullName}",
                      ),
                      _buildCustomListTile(
                        icon: Icons.email,
                        title: "Email: ${doctorController.doctor.value.email}",
                      ),
                      _buildCustomListTile(
                        icon: Icons.medical_services,
                        title:
                            "Doctor Name: ${doctorController.doctor.value.doctorName}",
                      ),
                      _buildCustomListTile(
                        icon: Icons.local_hospital,
                        title:
                            "Specialization: ${doctorController.doctor.value.specialization}",
                      ),
                      _buildCustomListTile(
                        icon: Icons.location_on,
                        title:
                            "Clinic Address: ${doctorController.doctor.value.clinicAddress ?? 'Not Available'}",
                      ),
                      _buildCustomListTile(
                        icon: Icons.card_membership,
                        title:
                            "License Number: ${doctorController.doctor.value.licenseNumber ?? 'Not Available'}",
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          print("going to editdoctorProfile:");
                          Get.offNamed(AppRoutes.editDoctorProfile, arguments: {
                            "doctorId": doctorId,
                            
                          });
                        },
                        child: const Text("Update Profile"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }

  // Helper method for custom ListTile with color and shadow
  Widget _buildCustomListTile({required IconData icon, required String title}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueGrey),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

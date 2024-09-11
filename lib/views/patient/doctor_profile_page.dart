// views/patient/doctor_profile_details.dart

import 'package:doctorappointmenapp/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:doctorappointmenapp/models/doctor/gride_model.dart';
import 'package:doctorappointmenapp/controllers/doctor_profile_controller.dart';

class DoctorProfileDetails extends StatelessWidget {
  // Initializing the GetX controller with the doctor model
  final DoctorProfileController controller = Get.put(
    DoctorProfileController(Get.arguments as DoctorModel),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.doctor.specialization),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDoctorCard(),
                  const SizedBox(height: 16),
                  const SizedBox(height: 16),
                  _buildAboutSection(),
                  const SizedBox(height: 16),
                  _buildHospitalSection(),
                  const SizedBox(height: 16),
                  _buildDateTimeSelection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget for Doctor Card
  Widget _buildDoctorCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: controller.doctor.avatar.isNotEmpty
                      ? NetworkImage(controller.doctor.avatar)
                      : null,
                  child: controller.doctor.avatar.isEmpty
                      ? const Icon(Icons.person, size: 60)
                      : null,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. ${controller.doctor.fullName}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      ' ${controller.doctor.specialization}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ],
            ),
            _buildPatientCard(),
          ],
        ),
      ),
    );
  }

  // Widget for Patient Card
  Widget _buildPatientCard() {
    return Card(
      color: kGreyColor500,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text("PATIENT",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              Text("1000+",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold))
            ],
          )),
    );
  }

  Widget ratingCard() {
    return Card(
      color: kGreyColor500,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text("PATIENT",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              Text("1000+",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold))
            ],
          )),
    );
  }

  // Widget for About Section
  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Dr. ${controller.doctor.fullName} is a highly skilled ${controller.doctor.specialization}.',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  // Widget for Hospital Section
  Widget _buildHospitalSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(Icons.local_hospital, color: Colors.red),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.doctor.doctorName,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.red),
                    const SizedBox(width: 4),
                    Text(controller.doctor.email), // Example: display email
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget for Date and Time Selection
  Widget _buildDateTimeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose Date',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            // Implement date selection logic
          },
          child: const Text('Select Date'),
        ),
        const SizedBox(height: 16),
        const Text(
          'Choose Time',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            // Implement time selection logic
          },
          child: const Text('Select Time'),
        ),
      ],
    );
  }
}

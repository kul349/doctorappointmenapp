// views/patient/doctor_profile_details.dart

import 'package:doctorappointmenapp/controllers/patient_getalldoctor_controller.dart';
import 'package:doctorappointmenapp/themes/app_theme.dart';
import 'package:flutter/material.dart';
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
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDoctorCard(),
                  const SizedBox(height: 8),
                  _buildHospitalSection(),
                  const SizedBox(height: 16),
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              // it's helps to image static on first place
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100, // Set the desired width
                  height: 140, // Set the desired height
                  child: controller.doctor.avatar.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(
                              8), // Optional: Adjust for rounded corners
                          child: Image.network(
                            controller.doctor.avatar,
                            fit: BoxFit
                                .cover, // Ensures the image fits within the box
                          ),
                        )
                      : const Icon(
                          Icons.person,
                          size: 60, // Adjust size of the icon
                        ),
                ),
                const SizedBox(width: 20),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr. ${controller.doctor.fullName}',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        ' ${controller.doctor.specialization}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Row(
                        children: [
                          Expanded(child: ratingCard()),
                          const SizedBox(
                            width: 4,
                          ),
                          Expanded(child: _buildPatientCard()),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            _buildAboutSection(),
          ],
        ),
      ),
    );
  }

  // Widget for Patient Card
  Widget _buildPatientCard() {
    return Card(
      color: kpurplecolor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: const Padding(
          padding: EdgeInsets.all(18.0),
          child: Column(
            children: [
              Text("PATIENT",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text("1000+",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              (Icon(Icons.people_alt))
            ],
          )),
    );
  }

  Widget ratingCard() {
    // Ensure your controller is available

    return Card(
      color: kpinkcolor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "Rating",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              controller.doctor.averageRating.toStringAsFixed(1),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildStarRating(controller.doctor.averageRating),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildStarRating(double rating) {
    List<Widget> stars = [];
    int fullStars = rating.floor();
    bool hasHalfStar = rating - fullStars >= 0.5;

    // Add full stars
    for (int i = 0; i < fullStars; i++) {
      stars.add(const Icon(Icons.star, color: Colors.amber, size: 20));
    }

    // Add half star if applicable
    if (hasHalfStar) {
      stars.add(const Icon(Icons.star_half, color: Colors.amber, size: 18));
    }

    // Add empty stars if needed to complete 5 stars
    while (stars.length < 5) {
      stars.add(const Icon(Icons.star_border, color: Colors.amber, size: 18));
    }

    return stars;
  }

  // Widget for About Section
  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Dr. ${controller.doctor.fullName} is a highly skilled ${controller.doctor.specialization}.',
          style: const TextStyle(fontSize: 18),
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
}

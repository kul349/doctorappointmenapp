import 'package:doctorappointmenapp/controllers/patient_getalldoctor_controller.dart';
import 'package:doctorappointmenapp/models/doctor/gride_model.dart';
import 'package:doctorappointmenapp/themes/app_theme.dart';
import 'package:doctorappointmenapp/views/patient/doctor_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorListPage extends StatelessWidget {
  final String specialization;
  final DoctorController doctorController = Get.find();

  DoctorListPage({
    required this.specialization,
    Key? key,
  }) : super(key: key) {
    // Fetch doctors by the selected specialization
    doctorController.fetchDoctorsBySpecialization(specialization);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$specialization'.toUpperCase()),
        centerTitle: true,
      ),
      body: Obx(() {
        // Show a loading indicator while data is being fetched
        if (doctorController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // If there are no doctors available after filtering, show a message
        if (doctorController.filteredDoctors.isEmpty) {
          return Center(
            child: Text('No doctors available for $specialization.'),
          );
        }

        // Display the filtered list of doctors
        return ListView.builder(
          itemCount: doctorController.filteredDoctors.length,
          itemBuilder: (context, index) {
            final DoctorModel doctor = doctorController.filteredDoctors[index];

            return Card(
              color: kGreenLightColor,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.only(left: 4.0, right: 4.0),
                leading: CircleAvatar(
                  radius: 45,
                  backgroundImage: doctor.avatar.isNotEmpty
                      ? NetworkImage(doctor.avatar)
                      : null,
                  child: doctor.avatar.isEmpty
                      ? const Icon(Icons.person, size: 30)
                      : null,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        doctor.fullName,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                        overflow: TextOverflow
                            .ellipsis, // Handle long names gracefully
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 5), // Adjust padding as needed
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius:
                            BorderRadius.circular(17), // Rounded corners
                      ),
                      child: Row(
                        children: [
                          Text(
                            '${doctor.averageRating}',
                            style: const TextStyle(
                              fontSize: 20, // Font size for rating
                              color: Colors.black, // Text color
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.star,
                            color: Colors.black, // Icon color
                            size: 28,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 3),
                    Text(
                      '${doctor.specialization}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 5),

                    Text(
                      'Availability: ${doctor.availabilityStatus}',
                      style: const TextStyle(fontSize: 20),
                    ), // Display availability status
                    Text(
                      'doctorId: ${doctor.id}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                onTap: () {
                  // Navigate to the DoctorDetailPage with the selected doctor
                  print(
                      'Navigating to DoctorProfileDetails with doctor: ${doctor.id}');
                  Get.to(
                    () => DoctorProfileDetails(),
                    arguments: doctor, // Pass the DoctorModel object
                  );
                },
              ),
            );
          },
        );
      }),
    );
  }
}

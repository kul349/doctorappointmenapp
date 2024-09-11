import 'package:doctorappointmenapp/controllers/patient_getalldoctor_controller.dart';
import 'package:doctorappointmenapp/models/doctor/gride_model.dart';
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
        title: Text('$specialization Doctors'),
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
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.only(left: 8.0, right: 2.0),
                leading: CircleAvatar(
                  radius: 30,
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
                            fontSize: 24, fontWeight: FontWeight.bold),
                        overflow: TextOverflow
                            .ellipsis, // Handle long names gracefully
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 5), // Adjust padding as needed
                      decoration: BoxDecoration(
                        color: Colors.yellow, // Background color
                        borderRadius:
                            BorderRadius.circular(17), // Rounded corners
                      ),
                      child: Row(
                        children: [
                          Text(
                            '${doctor.ratings}',
                            style: const TextStyle(
                              fontSize: 24, // Font size for rating
                              color: Colors.black, // Text color
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.star,
                            color: Colors.black, // Icon color
                            size: 33,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text('${doctor.specialization}'),
                    const SizedBox(height: 5),

                    Text(
                        'Availability: ${doctor.availabilityStatus}'), // Display availability status
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Handle tap if needed
                },
              ),
            );
          },
        );
      }),
    );
  }
}

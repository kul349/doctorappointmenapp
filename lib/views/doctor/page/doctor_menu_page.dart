import 'package:doctorappointmenapp/controllers/patient_getalldoctor_controller.dart';
import 'package:doctorappointmenapp/models/doctor/gride_model.dart';
import 'package:doctorappointmenapp/views/patient/doctor_fav_page.dart';
import 'package:doctorappointmenapp/views/patient/doctor_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorListPage extends StatelessWidget {
  final String specialization;
  final DoctorController doctorController = Get.find();

  DoctorListPage({
    required this.specialization,
    super.key,
  }) {
    // Fetch doctors by the selected specialization
    doctorController.fetchDoctorsBySpecialization(specialization);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(specialization.toUpperCase()),
        centerTitle: true,
        backgroundColor: Colors.green, // Set dominant color as green
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
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Doctor's image on the left side
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200], // Placeholder background color
                        image: DecorationImage(
                          image: doctor.avatar.isNotEmpty
                              ? NetworkImage(doctor.avatar)
                              : const AssetImage('assets/placeholder.png')
                                  as ImageProvider,
                          fit:
                              BoxFit.cover, // Ensures the image scales properly
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Doctor's details on the right side
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Doctor's name with favorite icon
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  doctor.fullName,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.favorite_border,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  // Logic to mark as favorite
                                  Get.to(() => FavoritesPage());
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // Specialization
                          Text(
                            doctor.specialization,
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 5),

                          // Clinic Address
                          Text(
                            'Clinic Address: ${doctor.clinicAddress}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 5),

                          // Availability status
                          Text(
                            'Availability: ${doctor.availabilityStatus}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          IconButton(
                            onPressed: () {
                              // Get latitude and longitude from the doctor's location
                              final double longitude =
                                  doctor.locationCoordinates?[0] ?? 0.0;
                              final double latitude =
                                  doctor.locationCoordinates?[1] ?? 0.0;
                              print(
                                  "Longitude: $longitude, Latitude: $latitude");

                              // Navigate to the map page with latitude and longitude
                              Get.toNamed(
                                '/map', // Your map page route
                                parameters: {
                                  'latitude': latitude.toString(),
                                  'longitude': longitude.toString(),
                                },
                              );
                            },
                            icon: const Icon(Icons.map_rounded),
                          ),
                          // Rating, Star, and Book Button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Display rating and stars
                              Row(
                                children: [
                                  Text(
                                    doctor.averageRating.toStringAsFixed(1),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.yellow,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 28,
                                  ),
                                ],
                              ),

                              // Book button
                              ElevatedButton(
                                onPressed: () {
                                  // Navigate to the DoctorProfileDetails
                                  Get.to(
                                    () => DoctorProfileDetails(),
                                    arguments:
                                        doctor, // Pass the DoctorModel object
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.green, // Set button color to green
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Book',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

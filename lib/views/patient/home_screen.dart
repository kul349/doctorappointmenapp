import 'package:doctorappointmenapp/controllers/search_doctor_controller.dart';
import 'package:doctorappointmenapp/controllers/top_doctor_controller.dart';
import 'package:doctorappointmenapp/themes/app_theme.dart';
import 'package:doctorappointmenapp/views/patient/doctor_profile_page.dart';
import 'package:doctorappointmenapp/views/patient/navigation_botton.dart'; // Ensure correct import
import 'package:doctorappointmenapp/widgets/doctor_app_grid_menu.dart';
import 'package:doctorappointmenapp/widgets/home_screen_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TopDoctorController doctorController = Get.put(TopDoctorController());
    final DoctorSearchController searchController =
        Get.put(DoctorSearchController()); // Search controller

    return Scaffold(
      body: Column(
        children: [
          // Main content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeScreenNavbar(),
                    const SizedBox(height: 30),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.displaySmall,
                        children: <TextSpan>[
                          const TextSpan(text: 'Find '),
                          TextSpan(
                            text: 'your doctor',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(color: kGreyColor900),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Search Box
                    Container(
                      height: 56,
                      padding: const EdgeInsets.only(
                          right: 8, left: 16, bottom: 5, top: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: kGreyColor500,
                      ),
                      child: TextField(
                        onChanged: (query) {
                          // Trigger search whenever the text changes
                          searchController.searchDoctors(
                            query,
                          ); // You can pass specialization if needed
                        },
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: kBlackColor900),
                        cursorHeight: 24,
                        decoration: InputDecoration(
                          suffixIcon:
                              const Icon(Icons.search, color: kBlackColor900),
                          suffixIconConstraints:
                              const BoxConstraints(maxHeight: 24),
                          hintText: 'Search doctor, medicines etc',
                          hintStyle: Theme.of(context).textTheme.headlineSmall,
                          contentPadding: const EdgeInsets.only(bottom: 5),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const DoctorAppGridMenu(),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Top Doctors',
                            style: Theme.of(context).textTheme.bodyLarge),
                        GestureDetector(
                          onTap: () {
                            doctorController
                                .toggleShowAll(); // Toggle between showing all and a few doctors
                          },
                          child: Obx(() => Text(
                                doctorController.showAll.value
                                    ? 'Show Less'
                                    : 'See All',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(color: kBlueColor),
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Display search results or top doctors
                    Obx(() {
                      if (searchController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (searchController.searchResults.isNotEmpty) {
                        // Display search results if available
                        return _buildSearchResultsList(searchController);
                      } else {
                        // Otherwise, show top doctors list
                        return _buildTopDoctorsList(context, doctorController);
                      }
                    }),
                  ],
                ),
              ),
            ),
          ),
          // Bottom Navigation Bar
          const BottomNavBar(),
        ],
      ),
    );
  }

  // Top Doctors List Builder
  Widget _buildTopDoctorsList(
      BuildContext context, TopDoctorController doctorController) {
    return Obx(() {
      final displayDoctors = doctorController.showAll.value
          ? doctorController.doctors.take(11).toList()
          : doctorController.doctors.take(4).toList();

      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.25, // Responsive height
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: displayDoctors.length,
          itemBuilder: (context, index) {
            final doctor = displayDoctors[index];
            return GestureDetector(
              onTap: () {
                // Navigate to the DoctorDetailsPage with the selected doctor's information
                Get.to(() =>  DoctorProfileDetails(), arguments: doctor);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4, // Dynamic width
                margin: const EdgeInsets.only(right: 10),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),

                        // Center the Avatar
                        Center(
                          child: CircleAvatar(
                            radius: MediaQuery.of(context).size.width *
                                0.1, // Responsive avatar size
                            backgroundImage: NetworkImage(doctor.avatar),
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Expanded ensures text doesn't overflow the card's height
                        Expanded(
                          child: Text(
                            "Dr ${doctor.doctorName}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16, // Reduced font size for better fit
                            ),
                          ),
                        ),

                        const SizedBox(height: 4),

                        Expanded(
                          child: Text(
                            doctor.specialization,
                            style: const TextStyle(
                                fontSize: 14), // Responsive font size
                            textAlign: TextAlign.left,
                          ),
                        ),

                        const SizedBox(height: 4),

                        // Row for ratings
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: kYellowColor, // Ensure this is defined
                              size: 24, // Adjusted icon size
                            ),
                            const SizedBox(width: 5),
                            Text(
                              doctor.averageRating.toStringAsFixed(1),
                              style: const TextStyle(
                                  fontSize: 16), // Adjusted text size
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  // Search Results List Builder
  Widget _buildSearchResultsList(DoctorSearchController searchController) {
    return SizedBox(
      height: 250, // Set a fixed height for the horizontal list
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: searchController.searchResults.length,
        itemBuilder: (context, index) {
          final doctor = searchController.searchResults[index];
          return Card(
            margin: const EdgeInsets.only(right: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: Center(
                      child: CircleAvatar(
                        radius: 60,
                        child:
                            Image.network(doctor.avatar, height: 80, width: 80),
                      ),
                    ),
                  ), // Doctor's image
                  const SizedBox(height: 8),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Dr ${doctor.doctorName}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      const SizedBox(height: 4),
                      Text(
                        doctor.specialization,
                        style: const TextStyle(fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: kYellowColor,
                            size: 30,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            ' ${doctor.averageRating.toStringAsFixed(1)}',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      )
                    ],
                  ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

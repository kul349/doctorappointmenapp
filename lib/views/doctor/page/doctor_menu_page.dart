import 'package:doctorappointmenapp/controllers/doctordetials_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:doctorappointmenapp/controllers/doctor_menu_controller.dart';
import 'package:get/get.dart'; // Import the DoctorMenu model

class GridMenuItem extends StatelessWidget {
  final DoctorMenu
      doctorMenuItem; // This should be the correct parameter name and type

  GridMenuItem({
    Key? key,
    required this.doctorMenuItem, // Ensure this matches what you're passing
  }) : super(key: key);
  final DetailsController controller = Get.put(DetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              doctorMenuItem.name), // Display the name of the selected item
          centerTitle: true,
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            // Show loading indicator while data is being fetched
            return const Center(child: CircularProgressIndicator());
          }

          // Display the details once the data is loaded
          final detail = controller.detailData;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: ${detail['name']}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text('Qualification: ${detail['qualification']}'),
                SizedBox(height: 10),
                Text('Experience: ${detail['experience']}'),
              ],
            ),
          );
        }
            //Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: Column(
            //     children: [
            //       if (doctorMenuItem.image.isNotEmpty)
            //         SvgPicture.asset(doctorMenuItem.image,
            //             height: 100, width: 100), // Use SvgPicture for SVG images
            //       const SizedBox(height: 16),
            //       Text(
            //         doctorMenuItem.name, // Display the name
            //         style: Theme.of(context).textTheme.bodyLarge,
            //       ),
            //       // Add more details or widgets as needed
            //     ],
            //   ),
            ) // ),
        );
  }
}

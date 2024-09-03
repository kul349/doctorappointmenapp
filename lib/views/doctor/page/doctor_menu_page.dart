import 'package:flutter/material.dart';
import 'package:doctorappointmenapp/controllers/doctor_menu_controller.dart';
import 'package:flutter_svg/svg.dart'; // Import the DoctorMenu model

class GridMenuItem extends StatelessWidget {
  final DoctorMenu
      doctorMenuItem; // This should be the correct parameter name and type

  const GridMenuItem({
    Key? key,
    required this.doctorMenuItem, // Ensure this matches what you're passing
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(doctorMenuItem.name), // Display the name of the selected item
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (doctorMenuItem.image.isNotEmpty)
              SvgPicture.asset(doctorMenuItem.image,
                  height: 100, width: 100), // Use SvgPicture for SVG images
            const SizedBox(height: 16),
            Text(
              doctorMenuItem.name, // Display the name
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            // Add more details or widgets as needed
          ],
        ),
      ),
    );
  }
}

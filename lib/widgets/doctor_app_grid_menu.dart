import 'package:doctorappointmenapp/views/doctor/page/doctor_menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Ensure flutter_svg is included
import 'package:get/get.dart';
import '../controllers/doctor_menu_controller.dart'; // Adjust import based on your directory structure

class DoctorAppGridMenu extends StatelessWidget {
  const DoctorAppGridMenu({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiate the controller
    final DoctorMenuController controller = Get.find();

    return Obx(
      () => GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 8,
        ),
        padding: EdgeInsets.zero,
        itemCount: controller.doctorMenu.length,
        itemBuilder: (BuildContext context, index) {
          final menuItem = controller.doctorMenu[index];
          return GestureDetector(
            onTap: () {
              Get.to(() => GridMenuItem(doctorMenuItem: menuItem));
            },
            child: Container(
              constraints: const BoxConstraints(
                maxHeight: 81,
              ),
              child: Column(
                children: [
                  Container(
                    constraints: const BoxConstraints(
                      minHeight: 56,
                      minWidth: 56,
                      maxHeight: 69,
                      maxWidth: 69,
                    ),
                    child: SvgPicture.asset(
                      menuItem.image,
                      width: 69,
                      height: 69,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Expanded(
                    child: Text(
                      menuItem.name,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// doctor_app_grid_menu.dart
import 'package:doctorappointmenapp/controllers/doctor_menu_controller.dart';
import 'package:doctorappointmenapp/views/doctor/page/doctor_menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DoctorAppGridMenu extends StatelessWidget {
  const DoctorAppGridMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DoctorMenuController controller = Get.find();

    return Obx(
      () => GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200, // Maximum width per grid item
          childAspectRatio: 1, // Adjust to make items square

          mainAxisSpacing: 8,
        ),
        padding: EdgeInsets.zero,
        itemCount: controller.doctorMenu.length,
        itemBuilder: (BuildContext context, index) {
          final menuItem = controller.doctorMenu[index];
          return GestureDetector(
            onTap: () {
              // Navigate to the doctor list page with the selected specialization
              Get.to(() => DoctorListPage(specialization: menuItem.name));
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

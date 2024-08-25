import 'package:doctorappointmenapp/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Use flutter_svg for SVG images
import 'package:get/get.dart';
import '../controllers/home_screen_navbar_controller.dart'; // Adjust import based on your directory structure

class HomeScreenNavbar extends StatelessWidget {
  const HomeScreenNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Instantiate the controller
    final HomeScreenNavbarController controller = Get.find();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            // Add your onTap action here, if needed
          },
          child: SvgPicture.asset(
            'lib/assets/svg/icon-burger.svg',
            width: 24,
            height: 24,
          ),
        ),
        Obx(
          () => Container(
            width: 36,
            height: 36,
            child: CircleAvatar(
              backgroundColor: kBlueColor,
              backgroundImage: NetworkImage(controller.profileImageUrl.value),
            ),
          ),
        ),
      ],
    );
  }
}

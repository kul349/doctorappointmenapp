import 'package:doctorappointmenapp/controllers/auth_controller.dart';
import 'package:doctorappointmenapp/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Use flutter_svg for SVG images
import 'package:get/get.dart';

class HomeScreenNavbar extends StatelessWidget {
  HomeScreenNavbar({Key? key}) : super(key: key);

  // Fetch the AuthController to access user data
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            // Add your onTap action here, if needed
          },
          child: SvgPicture.asset(
            'assets/svg/icon-burger.svg',
            width: 24,
            height: 24,
          ),
        ),
        Obx(() {
          // Fetch the avatar URL from AuthController's userModel
          final avatarUrl = authController.userModel.value?.avatar ?? '';
          final defaultImage =
              'https://media.istockphoto.com/id/1805954358/photo/hr-human-resources-recruitment-team-staff-management-business-concept-relationship-management.jpg?s=1024x1024&w=is&k=20&c=sQtdh8xmzErxaFTWqgX5UTC4lEJqnn7ejQyEnN7aVlQ='; // Replace with actual default URL if needed

          return Container(
            width: 36,
            height: 36,
            child: CircleAvatar(
              backgroundColor: kBlueColor,
              backgroundImage: NetworkImage(
                avatarUrl.isNotEmpty
                    ? avatarUrl
                    : defaultImage, // Use avatarUrl or default
              ),
            ),
          );
        }),
      ],
    );
  }
}

import 'package:doctorappointmenapp/controllers/auth_controller.dart';
import 'package:doctorappointmenapp/themes/app_theme.dart';
import 'package:doctorappointmenapp/utils/decode_patient_token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreenNavbar extends StatelessWidget {
  HomeScreenNavbar({super.key});
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
        FutureBuilder<String?>(
          future: TokenHelper.getAvatarUrl(), // Get the avatar URL
          builder: (context, snapshot) {
            String avatarUrl = snapshot.data ?? '';
            const defaultImage =
                'https://media.istockphoto.com/id/1805954358/photo/hr-human-resources-recruitment-team-staff-management-business-concept-relationship-management.jpg?s=1024x1024&w=is&k=20&c=sQtdh8xmzErxaFTWqgX5UTC4lEJqnn7ejQyEnN7aVlQ=';

            return PopupMenuButton<String>(
              icon: CircleAvatar(
                backgroundColor: kBlueColor,
                backgroundImage: NetworkImage(
                  avatarUrl.isNotEmpty ? avatarUrl : defaultImage,
                ),
              ),
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                    value: 'change_password',
                    child: Text('Change Password'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'logout',
                    child: Text('Logout'),
                  ),
                ];
              },
              onSelected: (value) async {
                if (value == 'change_password') {
                  Get.toNamed('/change-password');
                   // Navigate to ChangePasswordScreen
                } else if (value == 'logout') {
                  await authController.logoutUser(); // Logout
                  Get.offAllNamed('/login'); // Navigate to Login Screen
                }
              },
            );
          },
        ),
      ],
    );
  }
}

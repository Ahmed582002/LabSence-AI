import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labsense_ai/controllers/home/home_controller.dart';
import 'package:labsense_ai/controllers/home/profile_controller.dart';
import 'package:labsense_ai/core/constants/color.dart';
import 'package:labsense_ai/view/widgets/custom_settings_button.dart';
import 'package:labsense_ai/view/widgets/home/title_text.dart';
import 'package:labsense_ai/view/widgets/home/view_photo.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());
    final HomeController homeController = Get.find();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
      child: ListView(
        children: [
          // top
          Row(
            children: [
              TitleText(text: "Profile"),
              Spacer(),
              GestureDetector(
                onTap: () {
                  profileController.logout();
                },
                child: Text("Logout", style: TextStyle(color: Colors.red[800])),
              ),
            ],
          ),
          // photo, name and email
          SizedBox(height: Get.height * 0.03),
          Obx(() {
            if (homeController.profileImage.value == null) {
              return const CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 40),
              );
            }
            return ViewPhoto(
              radius: 50,
              image: homeController.profileImage.value!,
            );
          }),
          SizedBox(height: Get.height * 0.01),
          Center(
            child: Text(
              homeController.user.value!.name,
              style: TextStyle(color: AppColors.primary, fontSize: 19),
            ),
          ),
          Center(
            child: Text(
              homeController.user.value!.email,
              style: TextStyle(fontSize: 14),
            ),
          ),
          // settings
          SizedBox(height: Get.height * 0.02),
          TitleText(text: "Settings"),
          // buttons
          CustomSettingsButton(text: "Personal Info"),
          CustomSettingsButton(
            text: "Language",
            onPressed: () {
              profileController.moveToChangeLang();
            },
          ),
          CustomSettingsButton(
            text: "Mode",
            onPressed: () {
              profileController.moveToChangeMode();
            },
          ),
        ],
      ),
    );
  }
}

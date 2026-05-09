import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labsense_ai/controllers/home/home_controller.dart';
import 'package:labsense_ai/controllers/home/profile_controller.dart';
import 'package:labsense_ai/core/constants/color.dart';
import 'package:labsense_ai/core/functions/initials.dart';
import 'package:labsense_ai/view/widgets/custom_button.dart';
import 'package:labsense_ai/view/widgets/home/profile/language_selector.dart';
import 'package:labsense_ai/view/widgets/home/profile/profile_info.dart';
import 'package:labsense_ai/view/widgets/home/profile/view_photo.dart';

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
          SizedBox(height: Get.height * 0.02),
          SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, Color(0xFF7B61FF)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.4),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Obx(() {
                      if (homeController.profileImage.value == null) {
                        return CircleAvatar(
                          radius: 50,
                          backgroundColor: AppColors.secondary,
                          child: Text(
                            initials(homeController.user.value!.name),
                            style: Theme.of(context).textTheme.displayLarge!
                                .copyWith(
                                  color: AppColors.primary,
                                  fontSize: 35,
                                ),
                          ),
                        );
                      }
                      return ViewPhoto(
                        radius: 50,
                        image: homeController.profileImage.value!,
                      );
                    }),
                  ),
                ),
                SizedBox(height: Get.height * 0.025),
                Center(
                  child: Text(
                    homeController.user.value!.name,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 19,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.005),
                Center(
                  child: Text(
                    homeController.user.value!.email,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                SizedBox(height: Get.height * 0.03),
                Text(
                  "39".tr,
                  style: Theme.of(
                    context,
                  ).textTheme.displayLarge!.copyWith(fontSize: 16),
                ),
                SizedBox(height: Get.height * 0.01),
                ProfileInfo(
                  icon: Icons.person,
                  label: "18".tr,
                  value: homeController.user.value!.name,
                ),
                ProfileInfo(
                  icon: Icons.email,
                  label: "8".tr,
                  value: homeController.user.value!.email,
                ),
                ProfileInfo(
                  icon: Icons.phone,
                  label: "19".tr,
                  value: homeController.user.value!.phone,
                ),
                ProfileInfo(
                  icon: Icons.male,
                  label: "40".tr,
                  value: homeController.user.value!.gender,
                ),
                LanguageSelector(),
                SizedBox(height: Get.height * 0.02),
                CustomButton(
                  text: "41".tr,
                  onPressed: () {
                    profileController.moveToEditProfile();
                  },
                ),
                SizedBox(height: Get.height * 0.01),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      side: const BorderSide(color: Colors.redAccent, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      profileController.logout();
                    },
                    child: Text(
                      '42'.tr,
                      style: Theme.of(context).textTheme.displayMedium!
                          .copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Colors.redAccent,
                          ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

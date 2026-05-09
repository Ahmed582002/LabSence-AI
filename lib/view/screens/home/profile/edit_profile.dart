import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labsense_ai/controllers/auth/auth_controller.dart';
import 'package:labsense_ai/controllers/home/edit_profile_controller.dart';
import 'package:labsense_ai/controllers/home/home_controller.dart';
import 'package:labsense_ai/core/constants/color.dart';
import 'package:labsense_ai/core/constants/routes.dart';
import 'package:labsense_ai/core/services/firebase_service.dart';
import 'package:labsense_ai/view/widgets/custom_button.dart';
import 'package:labsense_ai/view/widgets/home/profile/custom_profile_text_field.dart';
import 'package:labsense_ai/view/widgets/home/profile/view_photo.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EditProfileController controller = Get.put(EditProfileController());
    final AuthController authcontroller = Get.put(AuthController());
    final HomeController homeController = Get.find();
    final FirebaseService firebaseService = FirebaseService();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "42".tr,
          style: Theme.of(
            context,
          ).textTheme.displayLarge!.copyWith(fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              SizedBox(height: Get.height * 0.03),
              GestureDetector(
                onTap: () {
                  authcontroller.pickAndEncodeImage();
                },
                child: Container(
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
                    child: Stack(
                      children: [
                        Obx(() {
                          if (authcontroller.base64Photo.isEmpty) {
                            if (homeController.profileImage.value != null) {
                              return ViewPhoto(
                                radius: 70,
                                image: homeController.profileImage.value!,
                              );
                            }
                            return GestureDetector(
                              onTap: authcontroller.pickAndEncodeImage,
                              child: const CircleAvatar(
                                backgroundColor: AppColors.secondary,
                                radius: 70,
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: 35,
                                  color: AppColors.primary,
                                ),
                              ),
                            );
                          } else {
                            return GestureDetector(
                              onTap: authcontroller.pickAndEncodeImage,
                              child: CircleAvatar(
                                radius: 70,
                                backgroundImage: MemoryImage(
                                  base64Decode(
                                    authcontroller.base64Photo.value,
                                  ),
                                ),
                              ),
                            );
                          }
                        }),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: CircleAvatar(
                            backgroundColor: AppColors.background,
                            radius: 15,
                            child: Center(child: Icon(Icons.edit, size: 18)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.03),
              CustomProfileTextField(
                label: "18".tr,
                controller: controller.nameController,
                hintText: "43".tr,
              ),
              CustomProfileTextField(
                label: "8".tr,
                controller: controller.emailController,
                hintText: "44".tr,
                icon: Icons.email_outlined,
              ),
              CustomProfileTextField(
                label: "19".tr,
                controller: controller.phoneController,
                hintText: "45".tr,
                icon: Icons.phone_outlined,
              ),
              SizedBox(height: Get.height * 0.09),
              CustomButton(
                text: "46".tr,
                onPressed: () async {
                  await controller.saveChanges(
                    firebaseService.getUserId()!,
                    authcontroller.base64Photo.value,
                  );
                  Get.snackbar("47".tr, "48".tr);
                  Get.toNamed(AppRoute.home);
                },
              ),
              SizedBox(height: Get.height * 0.01),
              Center(
                child: TextButton(
                  onPressed: () {
                    controller.back();
                  },
                  child: Text(
                    "5".tr,
                    style: Theme.of(
                      context,
                    ).textTheme.displaySmall!.copyWith(fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

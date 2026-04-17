import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labsense_ai/controllers/auth_controller.dart';
import 'package:labsense_ai/core/constants/color.dart';
import 'package:labsense_ai/view/widgets/custom_button.dart';
import 'package:labsense_ai/view/widgets/home/custom_textfield.dart';

class CompleteProfileScreen extends StatelessWidget {
  final String? userId; // Pass from signup
  final AuthController controller = Get.put(AuthController());

  CompleteProfileScreen({super.key, this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'LapSense AI',
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
            fontSize: 21,
            color: AppColors.primary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: Get.height * 0.01),
            // Texts on the top
            Center(
              child: Text(
                'Welcome to LabSense AI',
                style: Theme.of(
                  context,
                ).textTheme.displayLarge!.copyWith(fontSize: 24),
              ),
            ),
            SizedBox(height: Get.height * 0.025),
            Text(
              'Complete your profile to get the best experience.',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.displaySmall!.copyWith(fontSize: 14),
            ),
            SizedBox(height: Get.height * 0.05),
            Obx(() {
              if (controller.base64Photo.isEmpty) {
                return GestureDetector(
                  onTap: controller.pickAndEncodeImage,
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
                  onTap: controller.pickAndEncodeImage,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: MemoryImage(
                      base64Decode(controller.base64Photo.value),
                    ),
                  ),
                );
              }
            }),
            SizedBox(height: Get.height * 0.03),
            CustomTextField(
              controller: controller.nameController,
              hintText: "Full Name",
            ),
            CustomTextField(
              controller: controller.phoneController,
              hintText: "Phone Number",
            ),

            const SizedBox(height: 10),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio<String>(
                    value: "Male",
                    groupValue: controller.gender.value,
                    onChanged: (val) => controller.gender.value = val!,
                  ),
                  const Text("Male"),
                  SizedBox(width: 40),
                  Radio<String>(
                    value: "Female",
                    groupValue: controller.gender.value,
                    onChanged: (val) => controller.gender.value = val!,
                  ),
                  const Text("Female"),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.03),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                onPressed: () async {
                  await controller.saveProfile(userId!);
                  Get.snackbar("Success", "Profile saved successfully!");
                  // navigate to driver/rider home
                },
                text: "Save",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

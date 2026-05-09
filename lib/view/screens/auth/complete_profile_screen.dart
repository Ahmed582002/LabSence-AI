import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labsense_ai/controllers/auth/auth_controller.dart';
import 'package:labsense_ai/controllers/auth/state/build_auth_state.dart';
import 'package:labsense_ai/core/constants/color.dart';
import 'package:labsense_ai/core/functions/validator.dart';
import 'package:labsense_ai/view/widgets/custom_button.dart';
import 'package:labsense_ai/view/widgets/auth/custom_textfield.dart';

class CompleteProfileScreen extends StatelessWidget {
  final String? userId;
  final AuthController authController = Get.put(AuthController());

  CompleteProfileScreen({super.key, this.userId});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
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
      body: SafeArea(
        child: StateBuilder(
          state: authController.state,
          onLoading: () => Center(child: CircularProgressIndicator()),
          onIdle: () => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  SizedBox(height: Get.height * 0.01),
                  // Texts on the top
                  Center(
                    child: Text(
                      '16'.tr,
                      style: Theme.of(
                        context,
                      ).textTheme.displayLarge!.copyWith(fontSize: 24),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.025),
                  Text(
                    '17'.tr,
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.displaySmall!.copyWith(fontSize: 14),
                  ),
                  SizedBox(height: Get.height * 0.05),
                  Obx(() {
                    if (authController.base64Photo.isEmpty) {
                      return GestureDetector(
                        onTap: authController.pickAndEncodeImage,
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
                        onTap: authController.pickAndEncodeImage,
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage: MemoryImage(
                            base64Decode(authController.base64Photo.value),
                          ),
                        ),
                      );
                    }
                  }),
                  SizedBox(height: Get.height * 0.03),
                  CustomTextField(
                    controller: authController.nameController,
                    hintText: "18".tr,
                    validator: (value) => validator(value!, "name"),
                  ),
                  CustomTextField(
                    controller: authController.phoneController,
                    hintText: "19".tr,
                    validator: (value) => validator(value!, "phone"),
                  ),

                  const SizedBox(height: 10),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio<String>(
                          value: "Male",
                          groupValue: authController.gender.value,
                          onChanged: (val) =>
                              authController.gender.value = val!,
                        ),
                        Text("20".tr),
                        SizedBox(width: 40),
                        Radio<String>(
                          value: "Female",
                          groupValue: authController.gender.value,
                          onChanged: (val) =>
                              authController.gender.value = val!,
                        ),
                        Text("21".tr),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height * 0.03),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await authController.saveProfile();
                        }
                      },
                      text: "22".tr,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

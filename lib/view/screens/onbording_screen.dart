import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labsense_ai/controllers/start/onboarding_controller.dart';
import 'package:labsense_ai/core/constants/color.dart';
import 'package:labsense_ai/view/widgets/custom_button.dart';
import 'package:labsense_ai/view/widgets/dots.dart';
import 'package:labsense_ai/view/widgets/pageview.dart';

class OnBordingScreen extends StatelessWidget {
  const OnBordingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OnboardingController onboardingController = Get.put(OnboardingController());
    Get.put(OnboardingController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "LabSense AI",
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
            color: AppColors.primary,
            fontSize: 21,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              onboardingController.onSkip();
            },
            child: Text("1".tr, style: TextStyle(color: AppColors.text)),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Expanded(flex: 10, child: MyPageView()),
              Spacer(),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Dots(),
                    SizedBox(height: 20),
                    Obx(
                      () => CustomButton(
                        text: onboardingController.currentPage.value == 2
                            ? "4".tr
                            : "3".tr,
                        onPressed: () {
                          if (onboardingController.currentPage.value == 2) {
                            onboardingController.onSkip();
                          } else {
                            onboardingController.next();
                          }
                        },
                      ),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          onboardingController.previous();
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
            ],
          ),
        ),
      ),
    );
  }
}

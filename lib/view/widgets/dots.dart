import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:labsense_ai/controllers/onboarding_controller.dart';
import 'package:labsense_ai/core/constants/color.dart';
import 'package:labsense_ai/core/constants/onboarding_const.dart';

class Dots extends StatelessWidget {
  const Dots({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingController>(
      builder: ((controller) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(
            myList.length,
            (index) => AnimatedContainer(
              margin: const EdgeInsets.only(right: 8),
              duration: const Duration(milliseconds: 500),
              width: controller.currentPage == index ? 30 : 7,
              height: 6,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      )),
    );
  }
}

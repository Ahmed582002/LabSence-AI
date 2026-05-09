import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:labsense_ai/controllers/start/onboarding_controller.dart';
import 'package:labsense_ai/core/constants/onboarding_const.dart';

class MyPageView extends GetView<OnboardingController> {
  const MyPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller.pageController,
      onPageChanged: (value) {
        controller.onChangPage(value);
      },
      itemCount: myList.length,
      itemBuilder: (context, index) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 12, child: Center(child: myList[index].image!)),
          Expanded(
            flex: 3,
            child: Text(
              textAlign: TextAlign.center,
              myList[index].title!,
              style: Theme.of(
                context,
              ).textTheme.displayLarge!.copyWith(fontSize: 24),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            flex: 3,
            child: Text(
              textAlign: TextAlign.center,
              myList[index].body!,
              style: Theme.of(
                context,
              ).textTheme.displaySmall!.copyWith(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}

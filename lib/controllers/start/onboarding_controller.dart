import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:labsense_ai/core/constants/routes.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;
  late PageController pageController;
  final box = GetStorage();

  void next() {
    currentPage++;
    pageController.animateToPage(
      currentPage.value,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void previous() {
    currentPage--;
    pageController.animateToPage(
      currentPage.value,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void onChangPage(int index) {
    currentPage.value = index;
    update();
  }

  void onSkip() {
    box.write("seenOnboarding", true);
    Get.offAllNamed(AppRoute.login);
  }

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }
}

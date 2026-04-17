import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labsense_ai/controllers/splash_controller.dart';
import 'package:labsense_ai/core/constants/imgaes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppImages.logo, width: Get.width * 0.35),
            Text(
              "LabSense AI",
              style: Theme.of(
                context,
              ).textTheme.displayLarge!.copyWith(fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}

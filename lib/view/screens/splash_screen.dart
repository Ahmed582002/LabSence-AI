import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labsense_ai/controllers/start/splash_controller.dart';
import 'package:labsense_ai/core/constants/color.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: AnimatedBuilder(
        animation: controller.animationController,
        builder: (context, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF3B82FF),
                  Color(0xFF2F6BFF),
                  Color(0xFF1C4ED8),
                ],
              ),
            ),
            child: Stack(
              children: [
                /// Bottom moving light
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment(controller.bottomLight.value, 1.2),
                        radius: 1.5,
                        colors: const [
                          Color.fromARGB(140, 255, 255, 255),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                /// Top moving light (opposite direction)
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment(controller.topLight.value, -1.2),
                        radius: 1.5,
                        colors: const [
                          Color.fromARGB(120, 255, 255, 255),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                /// Logo + Text
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/logo-1 w.png", width: 200),
                      Text(
                        "LabSense AI",
                        style: Theme.of(context).textTheme.displayLarge!
                            .copyWith(fontSize: 28, color: AppColors.secondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

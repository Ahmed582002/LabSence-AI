import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labsense_ai/controllers/bottom_navigation_bar_controller.dart';
import 'package:labsense_ai/controllers/home/home_controller.dart';
import 'package:labsense_ai/core/constants/color.dart';
import 'package:labsense_ai/view/widgets/custom_button.dart';
import 'package:labsense_ai/view/widgets/home/report_card.dart';
import 'package:labsense_ai/view/widgets/home/see_more.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    final BottomNavigationBarController navController = Get.find();
    // final WelcomeController welcomeController = Get.put(WelcomeController());
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: ListView(
        children: [
          // Top
          SizedBox(height: Get.height * 0.025),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Patient Dashboard",
                style: Theme.of(
                  context,
                ).textTheme.displaySmall!.copyWith(fontSize: 12),
              ),
              SizedBox(height: Get.height * 0.01),
              Text(
                "Welcome Back,",
                style: Theme.of(
                  context,
                ).textTheme.displayLarge!.copyWith(fontSize: 28),
              ),
              SizedBox(height: Get.height * 0.005),
              Obx(() {
                if (homeController.user.value == null) {
                  return const Text("Loading...");
                }
                return Text(
                  homeController.user.value!.name,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 26,
                    color: AppColors.primary,
                  ),
                );
              }),
              SizedBox(height: Get.height * 0.04),
              Container(
                padding: EdgeInsets.all(30),
                margin: EdgeInsets.symmetric(horizontal: 6),
                width: Get.width,
                decoration: BoxDecoration(
                  color: Color(0xFFC2C6D4),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Instant Clinical \nAnalysis",
                      style: Theme.of(
                        context,
                      ).textTheme.displayMedium!.copyWith(fontSize: 26),
                    ),
                    SizedBox(height: Get.height * 0.03),
                    Text(
                      "Upload your laboratory results \nor scan paper reports for \nimmediate AI-powered \ninterpretation and trend \ntracking.",
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: 16,
                        height: Get.height * 0.002,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.05),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: CustomButton(
                        text: "Start New Scan",
                        onPressed: () {
                          navController.selectedIndex.value++;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.03),
              SeeMore(
                text: "Recent Analyses",
                onTap: () {
                  navController.selectedIndex + 2;
                },
              ),
              SizedBox(height: Get.height * 0.03),
              ReportCard(
                title: "Full Blood Count (FBC)",
                centerName: "St. Mary's Diagnostic Center",
                date: "Oct 12, 2023",
                onTap: () {},
              ),
              ReportCard(
                title: "Full Blood Count (FBC)",
                centerName: "St. Mary's Diagnostic Center",
                date: "Oct 12, 2023",
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

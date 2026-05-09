import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:labsense_ai/controllers/home/bottom_navigation_bar_controller.dart';
import 'package:labsense_ai/controllers/home/home_controller.dart';
import 'package:labsense_ai/controllers/home/reports_controller.dart';
import 'package:labsense_ai/core/constants/color.dart';
import 'package:labsense_ai/model/analysis_model.dart';
import 'package:labsense_ai/view/screens/home/results.dart';
import 'package:labsense_ai/view/widgets/custom_button.dart';
import 'package:labsense_ai/view/widgets/home/report/report_card.dart';
import 'package:labsense_ai/view/widgets/home/see_more.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    final BottomNavigationBarController navController = Get.find();
    final ReportsController reportsController = Get.put(ReportsController());
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
                "24".tr,
                style: Theme.of(
                  context,
                ).textTheme.displaySmall!.copyWith(fontSize: 12),
              ),
              SizedBox(height: Get.height * 0.01),
              Text(
                "${"6".tr},",
                style: Theme.of(
                  context,
                ).textTheme.displayLarge!.copyWith(fontSize: 28),
              ),
              SizedBox(height: Get.height * 0.005),
              Obx(() {
                if (homeController.user.value == null) {
                  return Text("25".tr);
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
                      "26".tr,
                      style: Theme.of(
                        context,
                      ).textTheme.displayMedium!.copyWith(fontSize: 26),
                    ),
                    SizedBox(height: Get.height * 0.03),
                    Text(
                      "27".tr,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: 16,
                        height: Get.height * 0.002,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.05),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: CustomButton(
                        text: "28".tr,
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
                text: "29".tr,
                onTap: () {
                  navController.selectedIndex + 2;
                },
              ),
              SizedBox(height: Get.height * 0.03),
              Obx(() {
                if (reportsController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (reportsController.reports.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.description_outlined,
                            size: 60,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "30".tr,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return Column(
                  children: reportsController.reports.take(2).map((doc) {
                    final data = doc.data();

                    final date1 = data["createdAt"] != null
                        ? DateFormat(
                            "MMM d, yyyy • hh:mm a",
                          ).format((data["createdAt"] as Timestamp).toDate())
                        : "Unknown";

                    return ReportCard(
                      title: data["test_name"] ?? "Blood Test Report",
                      centerName: "31".tr,
                      date: date1,
                      onTap: () {
                        final analysis = AnalysisModel.fromJson(data);

                        Get.to(
                          () => ResultsScreen(),
                          arguments: analysis,
                          transition: Transition.zoom,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                    );
                  }).toList(),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}

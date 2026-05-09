import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labsense_ai/controllers/home/home_controller.dart';
import 'package:labsense_ai/core/constants/color.dart';
import 'package:labsense_ai/core/functions/initials.dart';
import 'package:labsense_ai/core/services/services.dart';
import 'package:labsense_ai/model/analysis_model.dart';
import 'package:labsense_ai/view/widgets/home/scan/advice_card.dart';
import 'package:labsense_ai/view/widgets/home/scan/biomarker_card.dart';
import 'package:labsense_ai/view/widgets/home/scan/health_score_card.dart';
import 'package:labsense_ai/view/widgets/auth/title_text.dart';
import 'package:labsense_ai/view/widgets/home/profile/view_photo.dart';

class ResultsScreen extends StatelessWidget {
  final AnalysisModel data = Get.arguments;

  ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    MyServices myServices = Get.find();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: myServices.sharedPreferences.getString("lang") == "ar"
              ? const EdgeInsets.only(right: 15)
              : const EdgeInsets.only(left: 15),
          child: Obx(() {
            if (homeController.profileImage.value == null) {
              if (homeController.user.value == null) {
                return CircleAvatar(
                  backgroundColor: AppColors.secondary,
                  child: CircularProgressIndicator(),
                );
              }
              return CircleAvatar(
                backgroundColor: AppColors.secondary,
                child: Text(
                  initials(homeController.user.value!.name),
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: AppColors.primary,
                    fontSize: 18,
                  ),
                ),
              );
            }
            return ViewPhoto(
              radius: 10,
              image: homeController.profileImage.value!,
            );
          }),
        ),
        title: Text(
          "23".tr,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
            fontSize: 20,
            color: AppColors.primary,
          ),
        ),
        actions: [
          Padding(
            padding: myServices.sharedPreferences.getString("lang") == "ar"
                ? const EdgeInsets.only(left: 10)
                : const EdgeInsets.only(right: 10),
            child: Icon(
              Icons.notifications_outlined,
              color: AppColors.headText,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              Text(
                "68".tr,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: 16,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              Text(
                "69".tr,
                style: Theme.of(
                  context,
                ).textTheme.displayLarge!.copyWith(fontSize: 30),
              ),
              SizedBox(height: Get.height * 0.02),
              Text(
                "${"70".tr} ${data.biomarkers.length} ${"71".tr}",
                style: Theme.of(
                  context,
                ).textTheme.displaySmall!.copyWith(fontSize: 14),
              ),
              SizedBox(height: Get.height * 0.02),
              HealthScoreCard(
                healthScore: data.healthScore,
                statusText: data.status,
              ),

              SizedBox(height: Get.height * 0.04),

              TitleText(text: "summary".tr),
              Text(
                data.totalInfo,
                style: Theme.of(
                  context,
                ).textTheme.displaySmall!.copyWith(fontSize: 14),
              ),

              SizedBox(height: Get.height * 0.03),

              TitleText(text: "72".tr),
              ...data.biomarkers.map((e) => BiomarkerCard(marker: e)),

              const SizedBox(height: 20),

              TitleText(text: "good_results".tr),
              ...data.goodResults.map(
                (e) => Text(
                  "• $e",
                  style: Theme.of(
                    context,
                  ).textTheme.displaySmall!.copyWith(fontSize: 14),
                ),
              ),

              const SizedBox(height: 20),

              TitleText(text: "abnormal_results".tr),
              ...data.abnormalResults.map(
                (e) => Text(
                  "• $e",
                  style: Theme.of(
                    context,
                  ).textTheme.displaySmall!.copyWith(fontSize: 14),
                ),
              ),

              const SizedBox(height: 20),

              TitleText(text: "medical_advice".tr),
              ...data.advices.map((e) => AdviceCard(advice: e)),
            ],
          ),
        ),
      ),
    );
  }
}

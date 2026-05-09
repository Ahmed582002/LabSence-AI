import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:labsense_ai/controllers/home/reports_controller.dart';
import 'package:labsense_ai/core/constants/color.dart';
import 'package:labsense_ai/model/analysis_model.dart';
import 'package:labsense_ai/view/screens/home/results.dart';
import 'package:labsense_ai/view/widgets/home/report/custom_search_bar.dart';
import 'package:labsense_ai/view/widgets/home/report/report_card.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ReportsController controller = Get.find();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.reports.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.description_outlined, size: 60, color: Colors.grey),
                SizedBox(height: 10),
                Text(
                  "30".tr,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ListView(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "77".tr,
                      style: Theme.of(context).textTheme.displayMedium!
                          .copyWith(fontSize: 16, color: AppColors.primary),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Text(
                      "78".tr,
                      style: Theme.of(
                        context,
                      ).textTheme.displayLarge!.copyWith(fontSize: 25),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Text(
                      "79".tr,
                      style: Theme.of(context).textTheme.displayMedium!
                          .copyWith(fontSize: 12, color: AppColors.text),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Text(
                      "${controller.filteredReports.length}",
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontSize: 20,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.03),
            CustomSearchBar(
              controller: controller.searchController,
              text: "80".tr,
              onChanged: controller.searchReports,
            ),
            SizedBox(height: Get.height * 0.02),
            Column(
              children: controller.filteredReports.map((doc) {
                final data = doc.data();

                final date = data["createdAt"] != null
                    ? DateFormat(
                        "MMM d, yyyy • hh:mm a",
                      ).format((data["createdAt"] as Timestamp).toDate())
                    : "Unknown";

                return Dismissible(
                  key: Key(doc.id),

                  direction: DismissDirection.horizontal,

                  background: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color.fromARGB(255, 200, 51, 40),
                    ),
                    margin: EdgeInsets.only(bottom: 10),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color.fromARGB(255, 200, 51, 40),
                    ),
                    margin: EdgeInsets.only(bottom: 10),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),

                    child: const Icon(Icons.delete, color: Colors.white),
                  ),

                  confirmDismiss: (direction) async {
                    return await Get.defaultDialog(
                      title: "Delete",
                      middleText:
                          "Are you sure you want to delete this report?",
                      textConfirm: "Yes",
                      textCancel: "No",
                      onConfirm: () => Get.back(result: true),
                      onCancel: () => Get.back(result: false),
                    );
                  },

                  onDismissed: (direction) async {
                    await controller.deleteReport(doc.id);
                  },

                  child: ReportCard(
                    title: data["test_name"] ?? "Blood Test Report",
                    centerName: "31".tr,
                    date: date,
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
                  ),
                );
              }).toList(),
            ),
          ],
        );
      }),
    );
  }
}

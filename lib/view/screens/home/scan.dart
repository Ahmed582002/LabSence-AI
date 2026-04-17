import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labsense_ai/controllers/home/scan_controller.dart';
import 'package:labsense_ai/core/constants/color.dart';
import 'package:labsense_ai/view/widgets/custom_button.dart';
import 'package:labsense_ai/view/widgets/home/scan_card.dart';

class ScanPage extends StatelessWidget {
  final ScanController controller = Get.put(ScanController());

  ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
      child: ListView(
        children: [
          const SizedBox(height: 20),

          /// IMAGE PREVIEW
          Obx(() {
            if (controller.selectedImage.value == null) {
              return const Text("No image selected");
            }

            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                controller.selectedImage.value!,
                height: Get.height * 0.3,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            );
          }),

          const SizedBox(height: 20),

          /// UPLOAD CARD
          ScanCard(
            title: "Upload Test",
            subtitle: "Upload a lab report image for AI analysis.",
            icon: Icons.upload_file,
            color: AppColors.primary,
            onTap: controller.pickImage,
          ),

          /// CAMERA CARD
          ScanCard(
            title: "Take Photo",
            subtitle: "Capture a blood test report using your camera.",
            icon: Icons.camera_alt,
            color: const Color.fromARGB(255, 121, 70, 11),
            onTap: controller.takePhoto,
          ),

          /// QR CARD
          ScanCard(
            title: "Scan QR Code",
            subtitle: "Directly link results from participating laboratories.",
            icon: Icons.qr_code_scanner,
            color: const Color(0xFF0B6E79),
            onTap: () {},
          ),

          const SizedBox(height: 20),

          /// ANALYZE BUTTON
          Obx(
            () => CustomButton(
              text: "analyze_report".tr,
              isLoading: controller.isLoading.value,
              onPressed: controller.analyze,
            ),
          ),

          const SizedBox(height: 20),

          /// RESULT
          //       Obx(() {
          //         final data = controller.analysis.value;

          //         if (data == null) {
          //           return const Text("No analysis yet");
          //         }

          //         return Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             /// HEALTH SCORE
          //             Container(
          //               padding: const EdgeInsets.all(20),
          //               decoration: BoxDecoration(
          //                 color: Colors.blue.withOpacity(0.1),
          //                 borderRadius: BorderRadius.circular(12),
          //               ),
          //               child: Column(
          //                 children: [
          //                   const Text(
          //                     "Health Score",
          //                     style: TextStyle(fontSize: 18),
          //                   ),
          //                   Text(
          //                     "${data.healthScore}",
          //                     style: const TextStyle(
          //                       fontSize: 40,
          //                       fontWeight: FontWeight.bold,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),

          //             const SizedBox(height: 15),

          //             /// STATUS
          //             Chip(
          //               label: Text(data.status.toUpperCase()),
          //               backgroundColor: controller.getStatusColor(data.status),
          //             ),
          //             TitleText(text: "summary".tr),
          //             Text(data.totalInfo),

          //             TitleText(text: "Biomarkers"),

          //             const SizedBox(height: 15),

          //             ...data.biomarkers.map((e) => BiomarkerCard(marker: e)),

          //             const SizedBox(height: 15),

          //             TitleText(text: "good_results".tr),
          //             ...data.goodResults.map((e) => Text("• $e")),

          //             const SizedBox(height: 15),

          //             TitleText(text: "abnormal_results".tr),
          //             ...data.abnormalResults.map((e) => Text("• $e")),

          //             const SizedBox(height: 15),

          //             TitleText(text: "Advice & Next Steps"),

          //             const SizedBox(height: 15),

          //             ...data.advices.map((e) => AdviceCard(advice: e)),
          //           ],
          //         );
          //       }),

          //       const SizedBox(height: 100),
        ],
      ),
    );
  }
}

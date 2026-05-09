import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labsense_ai/controllers/home/scan_controller.dart';
import 'package:labsense_ai/core/constants/color.dart';
import 'package:labsense_ai/view/widgets/custom_button.dart';
import 'package:labsense_ai/view/widgets/home/scan/scan_card.dart';

class ScanPage extends StatelessWidget {
  final ScanController controller = Get.put(ScanController());

  ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
      child: ListView(
        children: [
          SizedBox(height: Get.height * 0.01),
          Text(
            "75".tr,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
              fontSize: 30,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: Get.height * 0.02),
          Text(
            "76".tr,
            style: Theme.of(
              context,
            ).textTheme.displaySmall!.copyWith(fontSize: 16),
          ),
          SizedBox(height: Get.height * 0.04),

          /// IMAGE PREVIEW
          Obx(() {
            if (controller.selectedImage.value == null) {
              return Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Row(
                  children: [
                    Icon(Icons.image_outlined, color: AppColors.primary),
                    SizedBox(width: Get.width * 0.02),
                    Text(
                      "32".tr,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: 15,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              );
            }

            return Container(
              decoration: BoxDecoration(
                border: Border.all(width: 3, color: AppColors.primary),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Image.file(
                  controller.selectedImage.value!,
                  height: Get.height * 0.3,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),

          SizedBox(height: Get.height * 0.04),

          /// UPLOAD CARD
          ScanCard(
            title: "33".tr,
            subtitle: "34".tr,
            icon: Icons.upload_file,
            color: AppColors.primary,
            onTap: controller.pickImage,
          ),

          /// CAMERA CARD
          ScanCard(
            title: "35".tr,
            subtitle: "36".tr,
            icon: Icons.camera_alt,
            color: const Color(0xFF0B6E79),
            onTap: controller.takePhoto,
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
        ],
      ),
    );
  }
}

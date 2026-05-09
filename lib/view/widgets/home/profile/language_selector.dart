import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labsense_ai/core/constants/color.dart';
import 'package:labsense_ai/core/localization/changelocal.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LocalController>();

    final languages = [
      {"code": "en", "label": "English"},
      {"code": "ar", "label": "العربية"},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Obx(
        () => Container(
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: controller.toggleExpand,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.language,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 14),

                      /// Label
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "67".tr,
                              style: Theme.of(
                                context,
                              ).textTheme.displayLarge!.copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      ),

                      Text(
                        controller.currentLangLabel,
                        style: Theme.of(context).textTheme.displaySmall!
                            .copyWith(fontSize: 12, color: AppColors.primary),
                      ),

                      const SizedBox(width: 6),

                      Icon(
                        controller.isExpanded.value
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.chevron_right_rounded,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),

              if (controller.isExpanded.value)
                Column(
                  children: languages.map((lang) {
                    final isSelected =
                        controller.currentLangCode.value == lang["code"];

                    return InkWell(
                      onTap: () => controller.changeLang(lang["code"]!),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 56),

                            Expanded(
                              child: Text(
                                lang["label"]!,
                                style: Theme.of(context).textTheme.displayLarge!
                                    .copyWith(
                                      fontSize: 13,
                                      color: isSelected
                                          ? AppColors.primary
                                          : null,
                                    ),
                              ),
                            ),

                            if (isSelected)
                              const Icon(
                                Icons.check,
                                color: AppColors.primary,
                                size: 18,
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

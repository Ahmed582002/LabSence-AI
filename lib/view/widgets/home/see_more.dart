import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labsense_ai/core/constants/color.dart';

class SeeMore extends StatelessWidget {
  final String text;
  final void Function() onTap;
  const SeeMore({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.displayMedium!.copyWith(fontSize: 18),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            "62".tr,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
              fontSize: 16,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}

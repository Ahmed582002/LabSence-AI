import 'package:flutter/material.dart';
import 'package:labsense_ai/core/constants/color.dart';

class CustomLine extends StatelessWidget {
  const CustomLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: AppColors.headText,
      margin: EdgeInsets.symmetric(horizontal: 25),
    );
  }
}

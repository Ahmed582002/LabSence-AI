import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class TitleText extends StatelessWidget {
  final String text;
  const TitleText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 24),
    ).paddingOnly(bottom: 15);
  }
}

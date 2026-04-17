import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSettingsButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const CustomSettingsButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: Get.height * 0.07,
      minWidth: double.infinity,
      onPressed: onPressed,
      color: Colors.transparent,
      child: Row(
        children: [Text(text), Spacer(), Icon(Icons.arrow_forward_sharp)],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomLoginWithButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String imagePath;
  final String text;

  const CustomLoginWithButton({
    super.key,
    required this.onPressed,
    required this.imagePath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(imagePath, height: 24),
            SizedBox(width: 8),
            Text(
              text,
              style: Theme.of(
                context,
              ).textTheme.displayMedium!.copyWith(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

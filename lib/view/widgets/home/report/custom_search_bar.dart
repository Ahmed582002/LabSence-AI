import 'package:flutter/material.dart';
import 'package:labsense_ai/core/constants/color.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onFilterTap;
  final Function(String)? onChanged;
  final String? text;

  const CustomSearchBar({
    super.key,
    this.controller,
    this.onFilterTap,
    this.onChanged,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Search Field
        Expanded(
          child: Container(
            height: 55,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFC2C6D4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.grey),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: controller,
                    onChanged: onChanged,
                    decoration: InputDecoration(
                      hintText: text,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 10),

        // Filter Button
        GestureDetector(
          onTap: onFilterTap,
          child: Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.tune, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

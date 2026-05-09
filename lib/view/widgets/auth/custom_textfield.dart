import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final IconData? prefixIcon;
  final bool isPassword;
  final TextEditingController controller;
  final VoidCallback? onForgot;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    required this.controller,
    this.isPassword = false,
    this.onForgot,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Label + Forgot
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.hintText,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),

            if (widget.isPassword && widget.onForgot != null)
              GestureDetector(
                onTap: widget.onForgot,
                child: Text(
                  "82".tr,
                  style: TextStyle(color: Colors.blue, fontSize: 13),
                ),
              ),
          ],
        ),

        const SizedBox(height: 8),

        /// TextFormField
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,

          // NEW
          validator: widget.validator,

          obscureText: widget.isPassword ? obscureText : false,

          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon)
                : null,

            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  )
                : null,

            filled: true,
            fillColor: const Color(0xFFC2C6D4),

            hintText: "${"83".tr} ${widget.hintText.toLowerCase()}",

            errorStyle: const TextStyle(fontSize: 12),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.blue, width: 1.2),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
          ),
        ),
      ],
    ).paddingOnly(bottom: Get.height * 0.02);
  }
}

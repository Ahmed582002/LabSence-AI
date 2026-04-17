import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labsense_ai/controllers/auth_controller.dart';
import 'package:labsense_ai/core/constants/color.dart';
import 'package:labsense_ai/core/constants/imgaes.dart';
import 'package:labsense_ai/view/widgets/custom_button.dart';
import 'package:labsense_ai/view/widgets/home/custom_login_with_button.dart';
import 'package:labsense_ai/view/widgets/home/custom_textfield.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    return Scaffold(
      // AppBar
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'LapSense AI',
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
            fontSize: 21,
            color: AppColors.primary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            SizedBox(height: Get.height * 0.035),
            // Texts on the top
            Center(
              child: Text(
                'Create Account',
                style: Theme.of(
                  context,
                ).textTheme.displayLarge!.copyWith(fontSize: 24),
              ),
            ),
            SizedBox(height: Get.height * 0.025),
            Text(
              'Sign up to your LapSense AI account to continue.',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.displaySmall!.copyWith(fontSize: 14),
            ),
            SizedBox(height: Get.height * 0.05),
            // Signup Form
            CustomTextField(
              hintText: "Email",
              prefixIcon: Icons.email,
              controller: authController.emailController,
            ),
            CustomTextField(
              hintText: "Password",
              isPassword: true,
              onForgot: () {},
              prefixIcon: Icons.lock,
              controller: authController.passwordController,
            ),
            SizedBox(height: Get.height * 0.04),
            // Signup Button
            CustomButton(
              text: "Sign Up",
              onPressed: () {
                authController.signUpStep1(
                  authController.emailController.text.trim(),
                  authController.passwordController.text.trim(),
                );
              },
            ),
            SizedBox(height: Get.height * 0.05),
            Center(
              child: Text("---------------- OR Continue with ----------------"),
            ),
            SizedBox(height: Get.height * 0.05),
            // Google Login Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomLoginWithButton(
                  onPressed: () {},
                  imagePath: AppImages.google2,
                  text: "  Google  ",
                ),
                CustomLoginWithButton(
                  onPressed: () {},
                  imagePath: AppImages.ios,
                  text: "   Apple   ",
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.05),
            // Sign Up Text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: Theme.of(
                    context,
                  ).textTheme.displaySmall!.copyWith(fontSize: 14),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Log in",
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontSize: 14,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.025),
          ],
        ),
      ),
    );
  }
}

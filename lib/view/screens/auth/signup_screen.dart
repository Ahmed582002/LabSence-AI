import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labsense_ai/controllers/auth/auth_controller.dart';
import 'package:labsense_ai/controllers/auth/state/build_auth_state.dart';
import 'package:labsense_ai/core/constants/color.dart';
import 'package:labsense_ai/core/constants/imgaes.dart';
import 'package:labsense_ai/core/functions/validator.dart';
import 'package:labsense_ai/view/widgets/custom_button.dart';
import 'package:labsense_ai/view/widgets/auth/custom_login_with_button.dart';
import 'package:labsense_ai/view/widgets/auth/custom_textfield.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    final formKey = GlobalKey<FormState>();
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
      body: SafeArea(
        child: StateBuilder(
          state: authController.state,
          onLoading: () => Center(child: CircularProgressIndicator()),
          onIdle: () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  SizedBox(height: Get.height * 0.035),
                  // Texts on the top
                  Center(
                    child: Text(
                      '12'.tr,
                      style: Theme.of(
                        context,
                      ).textTheme.displayLarge!.copyWith(fontSize: 24),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.025),
                  Text(
                    '13'.tr,
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.displaySmall!.copyWith(fontSize: 14),
                  ),
                  SizedBox(height: Get.height * 0.05),
                  // Signup Form
                  CustomTextField(
                    hintText: "8".tr,
                    prefixIcon: Icons.email,
                    controller: authController.emailController,
                    validator: (value) => validator(value!, "email"),
                  ),
                  CustomTextField(
                    hintText: "9".tr,
                    isPassword: true,
                    onForgot: () {},
                    prefixIcon: Icons.lock,
                    controller: authController.passwordController,
                    validator: (value) => validator(value!, "password"),
                  ),
                  SizedBox(height: Get.height * 0.04),
                  // Signup Button
                  CustomButton(
                    text: "14".tr,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        authController.signUpStep1(
                          authController.emailController.text.trim(),
                          authController.passwordController.text.trim(),
                        );
                      }
                    },
                  ),
                  SizedBox(height: Get.height * 0.05),
                  Center(
                    child: Text("---------------- ${"10".tr} ----------------"),
                  ),
                  SizedBox(height: Get.height * 0.05),
                  // Google Login Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomLoginWithButton(
                        onPressed: () {
                          authController.signInWithGoogle();
                        },
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
                        "15".tr,
                        style: Theme.of(
                          context,
                        ).textTheme.displaySmall!.copyWith(fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: () {
                          authController.navigateBack();
                        },
                        child: Text(
                          "2".tr,
                          style: Theme.of(context).textTheme.displaySmall!
                              .copyWith(
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
          ),
        ),
      ),
    );
  }
}

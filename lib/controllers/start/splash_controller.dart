import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:labsense_ai/core/constants/routes.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late AnimationController animationController;
  late Animation<double> bottomLight;
  late Animation<double> topLight;

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    bottomLight = Tween<double>(begin: -1.2, end: 1.2).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    topLight = Tween<double>(begin: 1.2, end: -1.2).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    animationController.repeat(reverse: true);

    navigate();
  }

  Future<void> navigate() async {
    final box = GetStorage();

    await Future.delayed(const Duration(seconds: 3));

    bool seenOnboarding = box.read("seenOnboarding") ?? false;

    final user = _auth.currentUser;

    if (!seenOnboarding) {
      Get.offAllNamed(AppRoute.onboarding);
      return;
    }

    if (user == null) {
      Get.offAllNamed(AppRoute.login);
      return;
    }

    DocumentSnapshot userDoc = await _firestore
        .collection("users")
        .doc(user.uid)
        .get();

    if (userDoc.exists && (userDoc["profileCompleted"] == true)) {
      Get.offAllNamed(AppRoute.home);
    } else {
      Get.offAllNamed(AppRoute.completeProfile);
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}

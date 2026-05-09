import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labsense_ai/controllers/home/home_controller.dart';

class EditProfileController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  final HomeController homeController = Get.find();

  Future<void> saveChanges(String userId, dynamic base64Photo) async {
    await _firestore.collection("users").doc(userId).update({
      "name": nameController.text,
      "email": emailController.text,
      "phone": phoneController.text,
      "photoBase64": base64Photo,
    });
  }

  void back() {
    Get.back();
  }

  @override
  void onInit() {
    emailController.text = homeController.user.value!.email;
    nameController.text = homeController.user.value!.name;
    phoneController.text = homeController.user.value!.phone;
    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}

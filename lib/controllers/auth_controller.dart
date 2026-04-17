import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:labsense_ai/core/constants/routes.dart';
import 'package:labsense_ai/view/screens/auth/complete_profile_screen.dart';
import 'package:labsense_ai/view/screens/home/home.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Rx<User?> firebaseUser = Rx<User?>(null);
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var gender = "".obs;
  var base64Photo = "".obs;

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(_auth.authStateChanges());
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  // STEP 1: Create auth account
  Future<void> signUpStep1(String email, String password) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String userId = cred.user!.uid;

      // Temporary save role in Firestore (profile incomplete)
      await _firestore.collection("users").doc(cred.user!.uid).set({
        "email": email,
        "profileCompleted": false,
        "createdAt": DateTime.now(),
      });

      // Go to profile completion screen
      Get.off(() => CompleteProfileScreen(userId: userId));
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> pickAndEncodeImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    final bytes = await File(pickedFile.path).readAsBytes();
    base64Photo.value = base64Encode(bytes);
  }

  Future<void> saveProfile(String userId) async {
    await _firestore.collection("users").doc(userId).set({
      "name": nameController.text,
      "gender": gender.value,
      "phone": phoneController.text,
      "photoBase64": base64Photo.value,
      "profileCompleted": true,
    }, SetOptions(merge: true)); // merge to avoid overwriting role/email
    Get.off(() => HomeScreen());
  }

  Future<String?> getUserPhoto(String userId) async {
    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .get();

    if (doc.exists && doc.data()!.containsKey("photoBase64")) {
      return doc["photoBase64"];
    }
    return null;
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      // Check if profile is completed
      String uid = _auth.currentUser!.uid;
      DocumentSnapshot userDoc = await _firestore
          .collection("users")
          .doc(uid)
          .get();

      if (userDoc.exists && !(userDoc["profileCompleted"] ?? false)) {
        Get.offAllNamed(AppRoute.completeProfile);
      } else {
        Get.offAllNamed(AppRoute.home);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  void navigate(String route) {
    Get.toNamed(route);
  }
}

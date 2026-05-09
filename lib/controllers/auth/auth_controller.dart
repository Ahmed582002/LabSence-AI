import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:labsense_ai/controllers/auth/state/auth_state.dart';
import 'package:labsense_ai/core/constants/routes.dart';
import 'package:labsense_ai/core/error/firebase_errors.dart';
import 'package:labsense_ai/view/screens/auth/complete_profile_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  var state = AuthState.idle.obs;
  var errorMessage = ''.obs;
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
    state.value = AuthState.loading;
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

      state.value = AuthState.idle;

      // Go to profile completion screen
      Get.off(() => CompleteProfileScreen(userId: userId));
    } on FirebaseAuthException catch (e) {
      final message = FirebaseErrors.getAuthErrorMessage(e);
      Get.snackbar("60".tr, message);
      state.value = AuthState.idle;
    } catch (e) {
      errorMessage.value = "Unexpected error occurred.";
      state.value = AuthState.idle;
    }
  }

  Future<void> pickAndEncodeImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    final bytes = await File(pickedFile.path).readAsBytes();
    base64Photo.value = base64Encode(bytes);
  }

  Future<void> saveProfile() async {
    final user = _auth.currentUser;

    if (user == null) {
      Get.snackbar("Error", "User not logged in");
      return;
    }

    state.value = AuthState.loading;

    try {
      await _firestore.collection("users").doc(user.uid).set({
        "name": nameController.text,
        "gender": gender.value,
        "phone": phoneController.text,
        "photoBase64": base64Photo.value,
        "profileCompleted": true,
      }, SetOptions(merge: true));

      Get.offAllNamed(AppRoute.home);
      state.value = AuthState.idle;
    } catch (e) {
      Get.snackbar("Error", e.toString());
      state.value = AuthState.idle;
    }
  }

  Future<String?> getUserPhoto(String userId) async {
    state.value = AuthState.loading;
    try {
      final doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .get();

      if (doc.exists && doc.data()!.containsKey("photoBase64")) {
        state.value = AuthState.success;
        return doc["photoBase64"];
      }
    } catch (e) {
      Get.snackbar("60".tr, e.toString());
      state.value = AuthState.idle;
    }
    return null;
  }

  Future<void> login(String email, String password) async {
    state.value = AuthState.loading;

    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if profile is completed
      String uid = _auth.currentUser!.uid;
      String userId = cred.user!.uid;
      DocumentSnapshot userDoc = await _firestore
          .collection("users")
          .doc(uid)
          .get();

      final isCompleted =
          userDoc.exists && (userDoc["profileCompleted"] == true);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!isCompleted) {
          Get.off(() => CompleteProfileScreen(userId: userId));
          state.value = AuthState.idle;
        } else {
          Get.offAllNamed(AppRoute.home);
          state.value = AuthState.idle;
        }
      });
    } on FirebaseAuthException catch (e) {
      final message = FirebaseErrors.getAuthErrorMessage(e);
      Get.snackbar("60".tr, message);
      state.value = AuthState.idle;
    } on FirebaseException catch (e) {
      Get.snackbar("60".tr, FirebaseErrors.getFirestoreErrorMessage(e));
      state.value = AuthState.error;
    } catch (e) {
      errorMessage.value = "Unexpected error occurred.";
      state.value = AuthState.idle;
    }
  }

  Future<void> signInWithGoogle() async {
    state.value = AuthState.loading;

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize();

      final account = await googleSignIn.authenticate();

      final auth = account.authentication;

      final credential = GoogleAuthProvider.credential(idToken: auth.idToken);

      final userCredential = await _auth.signInWithCredential(credential);

      final user = userCredential.user!;

      final doc = await _firestore.collection("users").doc(user.uid).get();

      if (!doc.exists) {
        await _firestore.collection("users").doc(user.uid).set({
          "email": user.email,
          "name": user.displayName,
          "photo": user.photoURL,
          "profileCompleted": false,
          "createdAt": DateTime.now(),
        });

        Get.off(() => CompleteProfileScreen(userId: user.uid));
      } else {
        final isCompleted = doc["profileCompleted"] == true;

        if (!isCompleted) {
          Get.off(() => CompleteProfileScreen(userId: user.uid));
        } else {
          Get.offAllNamed(AppRoute.home);
        }
      }

      state.value = AuthState.idle;
    } catch (e) {
      Get.snackbar("Error", e.toString());
      state.value = AuthState.idle;
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      state.value = AuthState.success;
    } catch (e) {
      Get.snackbar("Error", e.toString());
      state.value = AuthState.error;
    }
  }

  void navigate(String route) {
    Get.toNamed(route);
  }

  void navigateBack() {
    Get.back();
  }
}

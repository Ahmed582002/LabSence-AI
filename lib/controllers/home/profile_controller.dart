import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:labsense_ai/core/constants/routes.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// logout function
  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed(AppRoute.login);
  }

  /// move to changeLang screen
  void moveToChangeLang() {
    Get.toNamed(AppRoute.changeLang);
  }

  /// move to changeLang screen
  void moveToChangeMode() {
    Get.toNamed(AppRoute.changeMode);
  }
}

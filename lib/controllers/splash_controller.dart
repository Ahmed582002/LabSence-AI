import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:labsense_ai/core/constants/routes.dart';
import 'package:labsense_ai/core/services/firebase_service.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    navigate();
  }

  Future<void> navigate() async {
    final box = GetStorage();

    await Future.delayed(const Duration(seconds: 3));

    bool seenOnboarding = box.read("seenOnboarding") ?? false;
    bool isUserLoggedIn = FirebaseService().isUserLoggedIn();

    if (seenOnboarding) {
      if (isUserLoggedIn == true) {
        Get.offAllNamed(AppRoute.home);
      } else {
        Get.offAllNamed(AppRoute.login);
      }
    } else {
      Get.offAllNamed(AppRoute.onboarding);
    }
  }
}

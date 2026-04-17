import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labsense_ai/core/constants/routes.dart';
import 'package:labsense_ai/core/services/services.dart';

class LocalController extends GetxController {
  Locale? language;
  MyServices myServices = Get.find();
  // ThemeData appTheme = themeEnglish;

  void changeLang(String langcode) {
    Locale locale = Locale(langcode);
    myServices.sharedPreferences.setString("lang", langcode);
    // appTheme = langcode == "ar" ? themeArabic : themeEnglish;
    // Get.changeTheme(appTheme);
    Get.updateLocale(locale);
    Get.toNamed(AppRoute.home);
  }

  @override
  void onInit() {
    String? sharedPrefLang = myServices.sharedPreferences.getString("lang");
    if (sharedPrefLang == "ar") {
      language = const Locale("ar");
      // appTheme = themeArabic;
    } else if (sharedPrefLang == "en") {
      language = const Locale("en");
      // appTheme = themeEnglish;
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
      // appTheme = themeEnglish;
    }
    super.onInit();
  }
}

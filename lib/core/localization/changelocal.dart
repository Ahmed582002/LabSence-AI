import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labsense_ai/core/services/services.dart';

class LocalController extends GetxController {
  Locale? language;
  MyServices myServices = Get.find();

  RxBool isExpanded = false.obs;

  RxString currentLangCode = "en".obs;

  void toggleExpand() {
    isExpanded.toggle();
  }

  void changeLang(String langcode) {
    Locale locale = Locale(langcode);

    myServices.sharedPreferences.setString("lang", langcode);

    currentLangCode.value = langcode;

    Get.updateLocale(locale);

    isExpanded.value = false;
  }

  String get currentLangLabel {
    return currentLangCode.value == "ar" ? "العربية" : "English";
  }

  @override
  void onInit() {
    String? sharedPrefLang = myServices.sharedPreferences.getString("lang");

    if (sharedPrefLang == "ar") {
      language = const Locale("ar");
      currentLangCode.value = "ar";
    } else if (sharedPrefLang == "en") {
      language = const Locale("en");
      currentLangCode.value = "en";
    } else {
      final deviceLang = Get.deviceLocale!.languageCode;
      language = Locale(deviceLang);
      currentLangCode.value = deviceLang;
    }

    super.onInit();
  }
}

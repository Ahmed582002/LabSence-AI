import 'package:get/get.dart';

String? validator(String value, String type) {
  value = value.trim();

  switch (type) {
    case "email":
      if (value.isEmpty) {
        return "87".tr;
      }

      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
        return "88".tr;
      }

      break;

    case "password":
      if (value.isEmpty) {
        return "89".tr;
      }

      if (value.length < 6) {
        return "90".tr;
      }

      break;

    case "name":
      if (value.isEmpty) {
        return "91".tr;
      }

      if (value.length < 3) {
        return "92".tr;
      }

      break;

    case "phone":
      if (value.isEmpty) {
        return "93".tr;
      }

      if (!RegExp(r'^[0-9]{11}$').hasMatch(value)) {
        return "94".tr;
      }

      break;
  }

  return null;
}

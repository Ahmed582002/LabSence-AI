import 'package:get/get.dart';
import 'package:labsense_ai/view/screens/home/scan.dart';
import 'package:labsense_ai/view/screens/home/reports.dart';
import 'package:labsense_ai/view/screens/home/profile/profile.dart';
import 'package:labsense_ai/view/screens/home/welcome.dart';

class BottomNavigationBarController extends GetxController {
  var selectedIndex = 0.obs;

  final pages = [
    WelcomePage(),
    ScanPage(),
    const ReportsPage(),
    const ProfilePage(),
  ];

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}

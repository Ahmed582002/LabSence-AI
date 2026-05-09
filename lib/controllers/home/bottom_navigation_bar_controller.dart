import 'package:get/get.dart';
import 'package:labsense_ai/view/screens/home/profile/profile.dart';
import 'package:labsense_ai/view/screens/home/reports.dart';
import 'package:labsense_ai/view/screens/home/scan.dart';
import 'package:labsense_ai/view/screens/home/welcome.dart';

class BottomNavigationBarController extends GetxController {
  var selectedIndex = 0.obs;

  int previousIndex = 0;

  final pages = [
    WelcomePage(),
    ScanPage(),
    const ReportsPage(),
    const ProfilePage(),
  ];

  bool get isForward => selectedIndex.value > previousIndex;

  void changeIndex(int index) {
    previousIndex = selectedIndex.value;
    selectedIndex.value = index;
  }
}

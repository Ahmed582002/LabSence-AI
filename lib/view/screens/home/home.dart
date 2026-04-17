import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labsense_ai/controllers/bottom_navigation_bar_controller.dart';
import 'package:labsense_ai/controllers/home/home_controller.dart';
import 'package:labsense_ai/core/constants/color.dart';
import 'package:labsense_ai/view/widgets/home/custom_bottom_navigation_bar.dart';
import 'package:labsense_ai/view/widgets/home/view_photo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BottomNavigationBarController controller = Get.put(
    BottomNavigationBarController(),
  );
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 15),
          child: Obx(() {
            if (homeController.user.value == null) {
              return const Text("Loading...");
            }
            return ViewPhoto(
              radius: 20,
              image: homeController.profileImage.value!,
            );
          }),
        ),
        title: Text(
          "Clinical Sanctum",
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
            fontSize: 20,
            color: AppColors.primary,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              Icons.notifications_outlined,
              color: AppColors.headText,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () => CustomBottomBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changeIndex,
        ),
      ),
      body: Stack(
        children: [Obx(() => controller.pages[controller.selectedIndex.value])],
      ),
    );
  }
}

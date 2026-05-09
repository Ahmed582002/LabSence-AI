import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labsense_ai/controllers/home/bottom_navigation_bar_controller.dart';
import 'package:labsense_ai/controllers/home/home_controller.dart';
import 'package:labsense_ai/controllers/home/reports_controller.dart';
import 'package:labsense_ai/core/constants/color.dart';
import 'package:labsense_ai/core/functions/initials.dart';
import 'package:labsense_ai/core/services/services.dart';
import 'package:labsense_ai/view/widgets/home/custom_bottom_navigation_bar.dart';
import 'package:labsense_ai/view/widgets/home/profile/view_photo.dart';
import 'package:labsense_ai/view/widgets/home/report/health_chart_sheet.dart';

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
  final ReportsController reportsController = Get.put(ReportsController());
  MyServices myServices = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: myServices.sharedPreferences.getString("lang") == "ar"
              ? const EdgeInsets.only(right: 15)
              : const EdgeInsets.only(left: 15),
          child: Obx(() {
            if (homeController.profileImage.value == null) {
              if (homeController.user.value == null) {
                return CircleAvatar(
                  backgroundColor: AppColors.secondary,
                  child: CircularProgressIndicator(),
                );
              }
              return CircleAvatar(
                backgroundColor: AppColors.secondary,
                child: Text(
                  initials(homeController.user.value!.name),
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: AppColors.primary,
                    fontSize: 18,
                  ),
                ),
              );
            }
            return ViewPhoto(
              radius: 10,
              image: homeController.profileImage.value!,
            );
          }),
        ),
        title: Text(
          "23".tr,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
            fontSize: 20,
            color: AppColors.primary,
          ),
        ),
        actions: [
          Padding(
            padding: myServices.sharedPreferences.getString("lang") == "ar"
                ? const EdgeInsets.only(left: 10)
                : const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(Icons.addchart, color: AppColors.headText),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const HealthChartSheet(),
                );
              },
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
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await reportsController.fetchReports();
            await homeController.loadUserData();
          },
          child: Obx(() {
            final currentIndex = controller.selectedIndex.value;

            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (child, animation) {
                final isMovingRight = controller.isForward;

                final beginOffset = isMovingRight
                    ? const Offset(1, 0)
                    : const Offset(-1, 0);

                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position:
                        Tween<Offset>(
                          begin: beginOffset,
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeInOut,
                          ),
                        ),
                    child: child,
                  ),
                );
              },
              child: Container(
                key: ValueKey(currentIndex),
                child: controller.pages[currentIndex],
              ),
            );
          }),
        ),
      ),
    );
  }
}

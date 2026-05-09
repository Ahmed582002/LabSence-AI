import 'package:get/get.dart';
import 'package:labsense_ai/core/constants/routes.dart';
import 'package:labsense_ai/view/screens/auth/complete_profile_screen.dart';
import 'package:labsense_ai/view/screens/auth/login_screen.dart';
import 'package:labsense_ai/view/screens/auth/signup_screen.dart';
import 'package:labsense_ai/view/screens/home/home.dart';
import 'package:labsense_ai/view/screens/home/profile/edit_profile.dart';
import 'package:labsense_ai/view/screens/onbording_screen.dart';
import 'package:labsense_ai/view/screens/splash_screen.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: AppRoute.splashScreen, page: () => SplashScreen()),
  GetPage(name: AppRoute.onboarding, page: () => OnBordingScreen()),
  GetPage(name: AppRoute.home, page: () => const HomeScreen()),
  GetPage(name: AppRoute.login, page: () => LoginScreen()),
  GetPage(name: AppRoute.signup, page: () => SignupScreen()),
  GetPage(name: AppRoute.completeProfile, page: () => CompleteProfileScreen()),

  GetPage(name: AppRoute.editProfile, page: () => EditProfileScreen()),
];

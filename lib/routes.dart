import 'package:get/get.dart';
import 'package:labsense_ai/core/constants/routes.dart';
import 'package:labsense_ai/view/screens/auth/login_screen.dart';
import 'package:labsense_ai/view/screens/auth/signup_screen.dart';
import 'package:labsense_ai/view/screens/home/home.dart';
import 'package:labsense_ai/view/screens/home/profile/change_lang.dart';
import 'package:labsense_ai/view/screens/home/profile/change_mode.dart';
import 'package:labsense_ai/view/screens/onbording_screen.dart';
import 'package:labsense_ai/view/screens/splash_screen.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: AppRoute.splashScreen, page: () => SplashScreen()),
  GetPage(name: AppRoute.onboarding, page: () => OnBordingScreen()),
  GetPage(name: AppRoute.home, page: () => const HomeScreen()),
  GetPage(name: AppRoute.login, page: () => LoginScreen()),
  GetPage(name: AppRoute.signup, page: () => SignupScreen()),

  GetPage(name: AppRoute.changeLang, page: () => ChangeLang()),
  GetPage(name: AppRoute.changeMode, page: () => ChangeMode()),
];

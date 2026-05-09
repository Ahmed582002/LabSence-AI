import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:labsense_ai/core/constants/routes.dart';
import 'package:labsense_ai/core/constants/theme.dart';
import 'package:labsense_ai/core/localization/changelocal.dart';
import 'package:labsense_ai/core/localization/translation.dart';
import 'package:labsense_ai/core/services/services.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await initialServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    LocalController controller = Get.put(LocalController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: MyTranslation(),
      title: 'LabSence AI',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoute.splashScreen,
      locale: controller.language,
      getPages: routes,
    );
  }
}

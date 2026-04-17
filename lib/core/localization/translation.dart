import 'package:get/get.dart';

class MyTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    "ar": {
      "1": "اختر اللغة",
      "2": "تسجيل الدخول",
      "summary": "الملخص",
      "good_results": "النتائج الطبيعية",
      "abnormal_results": "النتائج غير الطبيعية",
      "medical_advice": "النصيحة الطبية",
      "analyze_report": "تحليل التقرير",
    },
    "en": {
      "1": "Choose Language",
      "2": "Login",
      "summary": "Summary",
      "good_results": "Good Results",
      "abnormal_results": "Abnormal Results",
      "medical_advice": "Medical Advice",
      "analyze_report": "Analyze Report",
    },
  };
}

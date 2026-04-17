import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:labsense_ai/AI/gemini_services.dart';
import 'package:labsense_ai/model/analysis_model.dart';
import 'package:labsense_ai/view/screens/home/results.dart';

class ScanController extends GetxController {
  final GeminiService _geminiService = GeminiService();
  final ImagePicker picker = ImagePicker();

  var selectedImage = Rxn<File>();
  var analysis = Rxn<AnalysisModel>();
  var isLoading = false.obs;

  /// PICK FROM GALLERY
  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      selectedImage.value = File(picked.path);
    }
  }

  /// TAKE PHOTO
  Future<void> takePhoto() async {
    final picked = await picker.pickImage(source: ImageSource.camera);

    if (picked != null) {
      selectedImage.value = File(picked.path);
    }
  }

  /// CLEAN GEMINI RESPONSE (removes ```json blocks)
  String cleanJson(String text) {
    return text.replaceAll("```json", "").replaceAll("```", "").trim();
  }

  /// EXTRACT ONLY JSON OBJECT
  String extractJson(String text) {
    final start = text.indexOf('{');
    final end = text.lastIndexOf('}');
    if (start != -1 && end != -1) {
      return text.substring(start, end + 1);
    }
    return text;
  }

  // Build Prompt
  String buildPrompt() {
    final lang = Get.locale?.languageCode ?? "en";

    if (lang == "ar") {
      return """
قم بتحليل تقرير فحص الدم.

أعد النتيجة بصيغة JSON فقط:

{
 "health_score": 0-100,
 "status": "healthy | stable | dangerous",
 "total_info": "ملخص قصير",

 "biomarkers":[
   {
    "name":"اسم الفحص",
    "category":"نوع المؤشر",
    "value":0,
    "unit":"الوحدة",
    "low":0,
    "optimal":0,
    "high":0,
    "status":"low | optimal | high"
   }
 ],

 "good_results": ["عناصر"],
 "abnormal_results": ["عناصر"],

 "advices":[
   {
     "title":"عنوان النصيحة",
     "description":"شرح قصير من سطرين أو ثلاثة",
     "priority":"high | medium | low",
     "action":"نص الإجراء مثل: احجز استشارة",
     "category":"nutrition | lifestyle | medical"
   }
 ]

}

قواعد:
- كل نصيحة يجب أن تكون واضحة ومحددة.
- priority تعتمد على خطورة الحالة.
- لا تكتب نص خارج JSON.
""";
    } else {
      return """
Analyze this blood test report.

Return ONLY JSON:

{
 "health_score": 0-100,
 "status": "healthy | stable | dangerous",
 "total_info": "short summary",

 "biomarkers":[
   {
    "name":"test name",
    "category":"marker type",
    "value":0,
    "unit":"mg/dL",
    "low":0,
    "optimal":0,
    "high":0,
    "status":"low | optimal | high"
   }
 ],

 "good_results": ["items"],
 "abnormal_results": ["items"],

 "advices":[
   {
     "title":"Advice title",
     "description":"2-3 lines explanation",
     "priority":"high | medium | low",
     "action":"CTA text like Schedule Consultation",
     "category":"nutrition | lifestyle | medical"
   }
 ]

}

Rules:
- Each advice must be specific and actionable.
- priority depends on severity.
- Return JSON only.
""";
    }
  }

  /// SEND TO GEMINI
  Future<void> analyze() async {
    if (selectedImage.value == null) {
      Get.snackbar("Error", "Please upload an image first");
      return;
    }

    try {
      Get.snackbar(
        "Analyzing...",
        "This may take 10-15 seconds",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );

      isLoading.value = true;

      final response = await _geminiService.analyzeReport(
        image: selectedImage.value!,
        prompt: buildPrompt(),
      );

      if (response != null) {
        /// remove markdown
        String cleaned = cleanJson(response);

        /// extract JSON object
        cleaned = extractJson(cleaned);

        /// decode safely
        final jsonData = jsonDecode(cleaned);

        analysis.value = AnalysisModel.fromJson(jsonData);

        Get.to(() => ResultsScreen(), arguments: analysis.value);
      }
    } catch (e) {
      print("Gemini parsing error: $e");
      Get.snackbar("Error", "Analysis failed");
    } finally {
      isLoading.value = false;
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "healthy":
        return Colors.green;
      case "stable":
        return Colors.orange;
      case "dangerous":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

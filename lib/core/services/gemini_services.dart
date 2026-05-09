import 'dart:io';
import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiService {
  final Gemini gemini = Gemini.instance;

  Future<String?> analyzeReport({
    required File image,
    required String prompt,
  }) async {
    final response = await gemini.textAndImage(
      text: prompt,
      images: [image.readAsBytesSync()],
    );

    return response?.output;
  }
}

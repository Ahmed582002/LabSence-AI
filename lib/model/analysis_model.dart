import 'package:labsense_ai/model/advice_model.dart';

import 'biomarker_model.dart';

class AnalysisModel {
  final int healthScore;
  final String status;
  final String totalInfo;
  final List<String> goodResults;
  final List<String> abnormalResults;
  final String medicalAdvice;
  final List<BiomarkerModel> biomarkers;
  final List<AdviceModel> advices;

  AnalysisModel({
    required this.healthScore,
    required this.status,
    required this.totalInfo,
    required this.goodResults,
    required this.abnormalResults,
    required this.medicalAdvice,
    required this.biomarkers,
    required this.advices,
  });

  factory AnalysisModel.fromJson(Map<String, dynamic> json) {
    return AnalysisModel(
      healthScore: json["health_score"] ?? 0,
      status: json["status"] ?? "",
      totalInfo: json["total_info"] ?? "",
      goodResults: List<String>.from(json["good_results"] ?? []),
      abnormalResults: List<String>.from(json["abnormal_results"] ?? []),
      medicalAdvice: json["medical_advice"] ?? "",
      biomarkers: (json["biomarkers"] as List? ?? [])
          .map((e) => BiomarkerModel.fromJson(e))
          .toList(),
      advices: (json["advices"] as List? ?? [])
          .map((e) => AdviceModel.fromJson(e))
          .toList(),
    );
  }
}

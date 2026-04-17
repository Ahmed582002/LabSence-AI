// import 'analysis_model.dart';

// class ReportModel {
//   final String? id;
//   final String date;
//   final String image;
//   final AnalysisModel analysis;

//   ReportModel({
//     this.id,
//     required this.date,
//     required this.image,
//     required this.analysis,
//   });

//   factory ReportModel.fromMap(Map<String, dynamic> data, String documentId) {
//     return ReportModel(
//       id: documentId,
//       date: data['date'] ?? '',
//       image: data['image'] ?? '',
//       analysis: AnalysisModel.fromMap(data['analysis'] ?? {}),
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {"date": date, "image": image, "analysis": analysis.toMap()};
//   }
// }

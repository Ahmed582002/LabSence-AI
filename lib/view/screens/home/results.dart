import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labsense_ai/model/analysis_model.dart';
import 'package:labsense_ai/view/widgets/home/advice_card.dart';
import 'package:labsense_ai/view/widgets/home/biomarker_card.dart';
import 'package:labsense_ai/view/widgets/home/title_text.dart';

class ResultsScreen extends StatelessWidget {
  final AnalysisModel data = Get.arguments;

  ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Results")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            /// HEALTH SCORE
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Text("Health Score"),
                  Text(
                    "${data.healthScore}",
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            /// STATUS
            Chip(label: Text(data.status.toUpperCase())),

            const SizedBox(height: 15),

            TitleText(text: "Summary"),
            Text(data.totalInfo),

            const SizedBox(height: 20),

            TitleText(text: "Biomarkers"),
            ...data.biomarkers.map((e) => BiomarkerCard(marker: e)),

            const SizedBox(height: 20),

            TitleText(text: "Good Results"),
            ...data.goodResults.map((e) => Text("• $e")),

            const SizedBox(height: 20),

            TitleText(text: "Abnormal Results"),
            ...data.abnormalResults.map((e) => Text("• $e")),

            const SizedBox(height: 20),

            TitleText(text: "Advice"),
            ...data.advices.map((e) => AdviceCard(advice: e)),
          ],
        ),
      ),
    );
  }
}

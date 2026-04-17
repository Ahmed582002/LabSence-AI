import 'package:flutter/material.dart';
import 'package:labsense_ai/model/biomarker_model.dart';

class BiomarkerCard extends StatelessWidget {
  final BiomarkerModel marker;

  const BiomarkerCard({super.key, required this.marker});

  double getProgress() {
    double max = marker.high * 1.2;
    return marker.value / max;
  }

  Color getColor() {
    switch (marker.status) {
      case "low":
        return Colors.blue;
      case "optimal":
        return Colors.green;
      case "high":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: const Color(0xFF1B0E0E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TITLE
          Text(
            marker.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 4),

          Text(marker.category, style: const TextStyle(color: Colors.grey)),

          const SizedBox(height: 15),

          /// VALUE
          Row(
            children: [
              Text(
                marker.value.toString(),
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Text(marker.unit, style: const TextStyle(color: Colors.white70)),
            ],
          ),

          const SizedBox(height: 15),

          /// BAR
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: getProgress(),
              minHeight: 8,
              color: getColor(),
              backgroundColor: Colors.white10,
            ),
          ),

          const SizedBox(height: 10),

          /// RANGES
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "LOW (${marker.low})",
                style: const TextStyle(color: Colors.grey, fontSize: 10),
              ),
              Text(
                "OPTIMAL (${marker.optimal})",
                style: const TextStyle(color: Colors.grey, fontSize: 10),
              ),
              Text(
                "HIGH (${marker.high}+)",
                style: const TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

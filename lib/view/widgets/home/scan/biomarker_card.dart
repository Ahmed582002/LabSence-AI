import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labsense_ai/core/constants/color.dart';
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
        return AppColors.primary;
      case "optimal":
        return const Color(0xff4a7c59);
      case "high":
        return const Color.fromARGB(255, 200, 51, 40);
      default:
        return Colors.grey;
    }
  }

  IconData getIcon() {
    switch (marker.status) {
      case "low":
        return Icons.error;
      case "optimal":
        return Icons.check_circle;
      case "high":
        return Icons.warning;
      default:
        return Icons.done;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TITLE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  marker.name,
                  style: Theme.of(
                    context,
                  ).textTheme.displayMedium!.copyWith(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 10),
                child: Icon(getIcon(), color: getColor()),
              ),
            ],
          ),

          const SizedBox(height: 4),

          Text(
            marker.category,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 20),

          /// VALUE
          Row(
            children: [
              Text(
                marker.value.toString(),
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: 32,
                  color: getColor(),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                marker.unit,
                style: Theme.of(
                  context,
                ).textTheme.displaySmall!.copyWith(fontSize: 14),
              ),
            ],
          ),

          const SizedBox(height: 20),

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

          const SizedBox(height: 20),

          /// RANGES
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "${"84".tr} (${marker.low})",
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontSize: 10,
                  color: marker.status == "low" ? getColor() : AppColors.text,
                  fontWeight: marker.status == "low"
                      ? FontWeight.w900
                      : FontWeight.normal,
                ),
              ),
              Text(
                "${"85".tr} (${marker.optimal})",
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontSize: 10,
                  color: marker.status == "optimal"
                      ? getColor()
                      : AppColors.text,
                  fontWeight: marker.status == "optimal"
                      ? FontWeight.w900
                      : FontWeight.normal,
                ),
              ),
              Text(
                "${"86".tr} (${marker.high}+)",
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontSize: 10,
                  color: marker.status == "high" ? getColor() : AppColors.text,
                  fontWeight: marker.status == "high"
                      ? FontWeight.w900
                      : FontWeight.normal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labsense_ai/core/constants/color.dart';

class HealthScoreCard extends StatelessWidget {
  final int healthScore;
  final String statusText;

  const HealthScoreCard({
    super.key,
    required this.healthScore,
    required this.statusText,
  });

  /// Returns color based on status
  Color _getStatusColor() {
    switch (statusText.toLowerCase()) {
      case "stable":
        return Colors.green;

      case "healthy":
        return Colors.blue;

      case "dangerous":
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  /// Returns icon based on status
  IconData _getStatusIcon() {
    switch (statusText.toLowerCase()) {
      case "stable":
        return Icons.check_circle;

      case "healthy":
        return Icons.favorite;

      case "dangerous":
        return Icons.warning_rounded;

      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();
    final statusIcon = _getStatusIcon();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: AppColors.secondary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.35),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          /// Health Score
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "73".tr,
                style: TextStyle(
                  color: Color(0xFF8A94A6),
                  fontSize: 12,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                healthScore.toString(),
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          /// Divider
          Container(height: 40, width: 1, color: AppColors.headText),

          /// Status
          Column(
            children: [
              Text(
                "74".tr,
                style: TextStyle(
                  color: Color(0xFF8A94A6),
                  fontSize: 12,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(statusIcon, color: statusColor, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    statusText.toUpperCase(),
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

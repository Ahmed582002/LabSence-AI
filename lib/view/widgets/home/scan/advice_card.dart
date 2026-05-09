import 'package:flutter/material.dart';
import 'package:labsense_ai/model/advice_model.dart';

class AdviceCard extends StatelessWidget {
  final AdviceModel advice;

  const AdviceCard({super.key, required this.advice});

  Color getPriorityColor() {
    switch (advice.priority) {
      case "high":
        return Color.fromARGB(255, 200, 51, 40);
      case "medium":
        return const Color.fromARGB(255, 238, 147, 9);
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// LEFT DOT
        Container(
          width: 12,
          height: 12,
          margin: const EdgeInsets.only(top: 6),
          decoration: BoxDecoration(
            color: getPriorityColor(),
            shape: BoxShape.circle,
          ),
        ),

        const SizedBox(width: 12),

        /// CONTENT
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                advice.title,
                style: Theme.of(
                  context,
                ).textTheme.displayLarge!.copyWith(fontSize: 16),
              ),

              const SizedBox(height: 5),

              Text(
                advice.description,
                style: Theme.of(
                  context,
                ).textTheme.displaySmall!.copyWith(fontSize: 14),
              ),

              const SizedBox(height: 8),

              GestureDetector(
                onTap: () {
                  // later: navigate / open link
                },
                child: Text(
                  "${advice.action} →",
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: 13,
                    color: getPriorityColor(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}

// intro_section.dart
import 'package:flutter/material.dart';

class FitnessTipsBusyPoepleIntroSection extends StatelessWidget {
  final Color primaryColor;

  const FitnessTipsBusyPoepleIntroSection({super.key, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            Icons.fitness_center_rounded,
            color: primaryColor,
            size: 64,
          ),
          const SizedBox(height: 12),
          Text(
            'Staying Fit in a Busy World',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'Discover practical and effective ways to maintain your fitness, even with a demanding schedule. These tips will help you stay active, healthy, and energized.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[800],
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class IntroSection extends StatelessWidget {
  const IntroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFE1F2FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'Eating healthy is one of the most important steps toward living a longer and healthier life. Our bodies need a variety of nutrients to stay strong, active, and mentally sharp. By adopting these habits, you can improve your overall well-being and reduce the risk of many chronic diseases.',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: const Color(0xFF1E293B),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

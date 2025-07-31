// lib/presentation/widgets/home/search_section.dart

import 'package:flutter/material.dart';
import 'package:vistacall/presentation/widgets/custom_textfield.dart';
import 'package:vistacall/utils/constants.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FIND YOUR DOCTOR',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppConstants.primaryColor,
          ),
        ),
        SizedBox(height: 10),
        CustomTextField(
          hintText: 'Search doctors, specialties...',
          prefixIcon: Icons.search,
        ),
      ],
    );
  }
}
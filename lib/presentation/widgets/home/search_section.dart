// lib/presentation/widgets/home/search_section.dart

import 'package:flutter/material.dart';
import 'package:vistacall/presentation/widgets/custom_textfield.dart';
import 'package:vistacall/utils/constants.dart';

class SearchSection extends StatelessWidget {
  final Function(String)? onSearchChanged;
  const SearchSection({super.key, required this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'FIND YOUR DOCTOR',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppConstants.primaryColor,
          ),
        ),
        const SizedBox(height: 10),
        CustomTextField(
          hintText: 'Search doctors, specialties...',
          prefixIcon: Icons.search,
          onChanged: onSearchChanged,
        ),
      ],
    );
  }
}
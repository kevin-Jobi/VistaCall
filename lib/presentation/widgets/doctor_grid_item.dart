import 'package:flutter/material.dart';
import 'package:vistacall/utils/constants.dart';

class DoctorGridItem extends StatelessWidget {
  final String title;
  final String imagePath;

  const DoctorGridItem({
    super.key,
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: AppConstants.primaryColor.withOpacity(0.2),
          child: Image.asset(
            imagePath,
            width: 45,
            height: 45,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
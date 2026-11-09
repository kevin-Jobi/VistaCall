


import 'package:flutter/material.dart';
import 'package:vistacall/data/models/doctor_category.dart';
import 'package:vistacall/presentation/widgets/doctor_grid_item.dart';
import 'package:vistacall/presentation/widgets/section_header.dart';

class DoctorCategoriesGrid extends StatelessWidget {
  final List<DoctorCategory> categories;
  final Function(DoctorCategory) onCategoryTap;

  const DoctorCategoriesGrid({
    super.key,
    required this.categories,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Find Doctors for your Health Problem',
          ),
          const SizedBox(height: 20),
          GridView.builder(
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.71,
              crossAxisSpacing: 10,
              mainAxisSpacing: 28,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return GestureDetector(
                onTap: () => onCategoryTap(category),
                child: DoctorGridItem(
                  title: category.title,
                  imagePath: category.imagePath,
                  index: index,
                  onTap: () => onCategoryTap(category),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
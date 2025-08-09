
import 'package:flutter/material.dart';
import 'package:vistacall/data/models/doctor_category.dart';
import 'package:vistacall/presentation/widgets/doctor_grid_item.dart';

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
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: categories.map((category) => GestureDetector(
        onTap: () => onCategoryTap(category),
        child: DoctorGridItem(
          title: category.title,
          imagePath: category.imagePath,
        ),
      )).toList(),
    );
  }
}

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
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF42A5F5), Color(0xFF1E88E5)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Find Doctors for your Health Problem',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A),
                    letterSpacing: -0.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GridView.builder(
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




// import 'package:flutter/material.dart';
// import 'package:vistacall/data/models/doctor_category.dart';
// import 'package:vistacall/presentation/widgets/doctor_grid_item.dart';
// import 'package:vistacall/presentation/widgets/section_header.dart';

// class DoctorCategoriesGrid extends StatelessWidget {
//   final List<DoctorCategory> categories;
//   final Function(DoctorCategory) onCategoryTap;

//   const DoctorCategoriesGrid({
//     super.key,
//     required this.categories,
//     required this.onCategoryTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SectionHeader(
//             title: 'Find Doctors for your Health Problem',
//           ),
//           const SizedBox(height: 20),
//           GridView.builder(
//             padding: EdgeInsets.zero,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 4,
//               childAspectRatio: 0.71,
//               crossAxisSpacing: 10,
//               mainAxisSpacing: 28,
//             ),
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: categories.length,
//             itemBuilder: (context, index) {
//               final category = categories[index];
//               return GestureDetector(
//                 onTap: () => onCategoryTap(category),
//                 child: DoctorGridItem(
//                   title: category.title,
//                   imagePath: category.imagePath,
//                   index: index,
//                   onTap: () => onCategoryTap(category),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:vistacall/data/models/doctor_category.dart';
import 'package:vistacall/utils/premium_theme.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PremiumSectionTitle(title: 'Find Doctors for your Health Problem'),
        const SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 18,
              crossAxisSpacing: 12,
              mainAxisExtent: 104,
            ),
            itemBuilder: (context, index) {
              final category = categories[index];
              return _CategoryTile(
                title: category.title,
                icon: _iconForCategory(category.title),
                onTap: () => onCategoryTap(category),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Picks a clean line icon from the category title. Display only: the
/// category data and the tap callback are untouched.
IconData _iconForCategory(String title) {
  final t = title.toLowerCase();
  bool has(List<String> keys) => keys.any(t.contains);

  if (has(['cardio', 'heart'])) return Icons.favorite_border_rounded;
  if (has(['neuro', 'brain'])) return Icons.psychology_outlined;
  if (has(['psychiat', 'psycholog', 'mental', 'counsel'])) {
    return Icons.self_improvement_rounded;
  }
  if (has(['gyn', 'obstet', 'maternity', 'pregnan', 'women'])) {
    return Icons.pregnant_woman_rounded;
  }
  if (has(['pediat', 'paediat', 'child', 'kid'])) {
    return Icons.child_care_rounded;
  }
  if (has(['ortho', 'bone', 'joint', 'spine'])) {
    return Icons.accessibility_new_rounded;
  }
  if (has(['derma', 'skin', 'cosmet', 'hair'])) {
    return Icons.face_retouching_natural_rounded;
  }
  if (has(['ayurved', 'herbal', 'homeo', 'naturo', 'unani', 'siddha'])) {
    return Icons.eco_outlined;
  }
  if (has(['eye', 'ophthal', 'optic'])) return Icons.visibility_outlined;
  if (has(['dent', 'tooth', 'oral'])) {
    return Icons.sentiment_satisfied_alt_rounded;
  }
  if (t.trim() == 'ent' ||
      has(['otolaryng', 'throat', 'nose', ' ear', 'audio'])) {
    return Icons.hearing_rounded;
  }
  if (has(['urolog', 'nephro', 'kidney'])) return Icons.water_drop_outlined;
  if (has(['pulmon', 'lung', 'chest', 'respir'])) return Icons.air_rounded;
  if (has(['gastro', 'digest', 'liver', 'diet', 'nutrition'])) {
    return Icons.restaurant_outlined;
  }
  if (has(['physio', 'rehab'])) return Icons.fitness_center_rounded;
  if (has(['onco', 'cancer'])) return Icons.biotech_outlined;
  if (has(['endocrin', 'diabet'])) return Icons.bloodtype_outlined;
  if (has(['vaccin', 'immun'])) return Icons.vaccines_outlined;
  return Icons.medical_services_outlined; // general / anything else
}

class _CategoryTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _CategoryTile({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: PremiumColors.line),
              boxShadow: [
                BoxShadow(
                  color: PremiumColors.navy800.withValues(alpha: 0.06),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Icon(icon, size: 26, color: PremiumColors.navy700),
          ),
          const SizedBox(height: 9),
          Text(
            title,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: PremiumColors.ink,
              fontSize: 12,
              height: 1.2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
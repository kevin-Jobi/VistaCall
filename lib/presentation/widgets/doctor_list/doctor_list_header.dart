// import 'package:flutter/material.dart';

// class DoctorListHeader extends StatelessWidget {
//   final int count;

//   const DoctorListHeader({super.key, required this.count});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;

//     return Container(
//       margin: const EdgeInsets.fromLTRB(16, 16, 16, 12),
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             colorScheme.primary.withValues(alpha: 0.1),
//             colorScheme.primary.withValues(alpha: 0.05),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: colorScheme.primary.withValues(alpha: 0.2),
//           width: 1,
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: colorScheme.primary.withValues(alpha: 0.15),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Icon(
//                   Icons.medical_services_rounded,
//                   color: colorScheme.primary,
//                   size: 20,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     '$count Doctors Available',
//                     style: theme.textTheme.titleMedium?.copyWith(
//                       fontWeight: FontWeight.w700,
//                       color: colorScheme.onSurface,
//                     ),
//                   ),
//                   Text(
//                     'Choose the best for you',
//                     style: theme.textTheme.bodySmall?.copyWith(
//                       color: colorScheme.onSurfaceVariant,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           _buildSortButton(theme, colorScheme),
//         ],
//       ),
//     );
//   }

//   Widget _buildSortButton(ThemeData theme, ColorScheme colorScheme) {
//     return Container(
//       decoration: BoxDecoration(
//         color: colorScheme.surface,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: colorScheme.onSurface.withValues(alpha: 0.08),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: PopupMenuButton(
//         color: colorScheme.surfaceVariant.withValues(alpha: 0.1),
//         icon: Icon(
//           Icons.tune_rounded,
//           color: colorScheme.primary,
//           size: 22,
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         offset: const Offset(0, 50),
//         itemBuilder: (BuildContext context) {
//           return [
//             _buildPopupMenuItem(
//               'Experience: Low to High',
//               Icons.trending_up_rounded,
//               colorScheme,
//               theme,
//             ),
//             _buildPopupMenuItem(
//               'Experience: High to Low',
//               Icons.trending_down_rounded,
//               colorScheme,
//               theme,
//             ),
//             _buildPopupMenuItem(
//               'Price: Low to High',
//               Icons.attach_money_rounded,
//               colorScheme,
//               theme,
//             ),
//             _buildPopupMenuItem(
//               'Price: High to Low',
//               Icons.money_off_rounded,
//               colorScheme,
//               theme,
//             ),
//           ];
//         },
//       ),
//     );
//   }

//   PopupMenuItem _buildPopupMenuItem(
//       String text, IconData icon, ColorScheme colorScheme, ThemeData theme) {
//     return PopupMenuItem(
//       value: text,
//       child: Row(
//         children: [
//           Icon(icon, size: 20, color: colorScheme.primary),
//           const SizedBox(width: 12),
//           Text(
//             text,
//             style: theme.textTheme.bodyMedium?.copyWith(
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:vistacall/utils/premium_theme.dart';

class DoctorListHeader extends StatelessWidget {
  final int count;

  const DoctorListHeader({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: PremiumColors.line),
        boxShadow: PremiumColors.softShadow(0.06),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              gradient: PremiumColors.navyGradient,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.medical_services_rounded,
              color: PremiumColors.accent,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$count Doctors Available',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.2,
                    color: PremiumColors.ink,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Choose the best for you',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    color: PremiumColors.muted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          _buildSortButton(),
        ],
      ),
    );
  }

  Widget _buildSortButton() {
    return PopupMenuButton(
      tooltip: 'Sort',
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 10,
      shadowColor: PremiumColors.navy900.withValues(alpha: 0.25),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: PremiumColors.line),
      ),
      offset: const Offset(0, 50),
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: PremiumColors.navy800.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(
          Icons.tune_rounded,
          color: PremiumColors.navy700,
          size: 21,
        ),
      ),
      itemBuilder: (BuildContext context) {
        return [
          _buildPopupMenuItem(
            'Experience: Low to High',
            Icons.trending_up_rounded,
          ),
          _buildPopupMenuItem(
            'Experience: High to Low',
            Icons.trending_down_rounded,
          ),
          _buildPopupMenuItem(
            'Price: Low to High',
            Icons.attach_money_rounded,
          ),
          _buildPopupMenuItem(
            'Price: High to Low',
            Icons.money_off_rounded,
          ),
        ];
      },
    );
  }

  PopupMenuItem _buildPopupMenuItem(String text, IconData icon) {
    return PopupMenuItem(
      value: text,
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: PremiumColors.navy800.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(icon, size: 18, color: PremiumColors.navy700),
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: PremiumColors.ink,
            ),
          ),
        ],
      ),
    );
  }
}
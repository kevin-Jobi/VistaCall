// // lib/utils/premium_theme.dart
// import 'package:flutter/material.dart';

// /// Single source of truth for the premium deep-blue look.
// class PremiumColors {
//   PremiumColors._();

//   static const navy900 = Color(0xFF061128);
//   static const navy800 = Color(0xFF0A1F44);
//   static const navy700 = Color(0xFF102C5C);
//   static const navy600 = Color(0xFF1B3F7A);
//   static const accent = Color(0xFFC9A961); // champagne gold
//   static const surface = Color(0xFFF4F6FB);
//   static const ink = Color(0xFF0B1B3A);
//   static const muted = Color(0xFF6B7A99);
//   static const line = Color(0xFFE3E8F2);
//   static const success = Color(0xFF2E8B6E);
//   static const danger = Color(0xFFB3412F);

//   static const LinearGradient navyGradient = LinearGradient(
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//     colors: [navy800, navy600],
//   );

//   static const LinearGradient headerGradient = LinearGradient(
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//     colors: [navy900, navy700],
//   );

//   static List<BoxShadow> softShadow([double alpha = 0.07]) => [
//         BoxShadow(
//           color: navy800.withValues(alpha: alpha),
//           blurRadius: 20,
//           offset: const Offset(0, 10),
//         ),
//       ];
// }

// /// Thin gold vertical accent used beside section titles.
// class PremiumAccentBar extends StatelessWidget {
//   final double height;
//   const PremiumAccentBar({super.key, this.height = 22});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 4,
//       height: height,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [
//             PremiumColors.accent,
//             PremiumColors.accent.withValues(alpha: 0.35),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(2),
//       ),
//     );
//   }
// }

// /// Drop-in replacement for SectionHeader (same parameters).
// class PremiumSectionHeader extends StatelessWidget {
//   final String title;
//   final String? actionLabel;
//   final VoidCallback? onAction;
//   final EdgeInsetsGeometry padding;

//   const PremiumSectionHeader({
//     super.key,
//     required this.title,
//     this.actionLabel,
//     this.onAction,
//     this.padding = EdgeInsets.zero,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: padding,
//       child: Row(
//         children: [
//           const PremiumAccentBar(),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Text(
//               title,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//               style: const TextStyle(
//                 fontSize: 17,
//                 height: 1.25,
//                 fontWeight: FontWeight.w800,
//                 letterSpacing: -0.2,
//                 color: PremiumColors.ink,
//               ),
//             ),
//           ),
//           if (actionLabel != null)
//             GestureDetector(
//               behavior: HitTestBehavior.opaque,
//               onTap: onAction,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 12),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       actionLabel!,
//                       style: const TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w700,
//                         color: PremiumColors.navy600,
//                       ),
//                     ),
//                     const Icon(Icons.chevron_right_rounded,
//                         size: 18, color: PremiumColors.navy600),
//                   ],
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }


// lib/utils/premium_theme.dart
import 'package:flutter/material.dart';

class PremiumColors {
  PremiumColors._();

  static const navy900 = Color(0xFF061128);
  static const navy800 = Color(0xFF0A1F44);
  static const navy700 = Color(0xFF102C5C);
  static const navy600 = Color(0xFF1B3F7A);
  static const accent = Color(0xFFC9A961); // champagne gold
  static const surface = Color(0xFFF4F6FB);
  static const ink = Color(0xFF0B1B3A);
  static const muted = Color(0xFF6B7A99);
  static const line = Color(0xFFE3E8F2);
  static const danger = Color(0xFFB3412F);

  static const LinearGradient navyGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [navy800, navy600],
  );

  static const LinearGradient headerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [navy900, navy700],
  );

  static List<BoxShadow> softShadow([double alpha = 0.07]) => [
        BoxShadow(
          color: navy800.withValues(alpha: alpha),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ];
}

String premiumInitials(String name) {
  final cleaned =
      name.replaceFirst(RegExp(r'^dr\.?\s+', caseSensitive: false), '').trim();
  final parts =
      cleaned.split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
  if (parts.isEmpty) return '?';
  if (parts.length == 1) return parts.first[0].toUpperCase();
  return (parts.first[0] + parts.last[0]).toUpperCase();
}

/// "Specialities  ……  See all"
class PremiumSectionTitle extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;
  final EdgeInsetsGeometry padding;

  const PremiumSectionTitle({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.2,
                color: PremiumColors.ink,
              ),
            ),
          ),
          if (actionLabel != null)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onAction,
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  actionLabel!,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: PremiumColors.navy600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Round navy avatar with initials (optionally shows a network image).
class PremiumAvatar extends StatelessWidget {
  final String initials;
  final double size;
  final bool ring;
  final String? imageUrl;

  const PremiumAvatar({
    super.key,
    required this.initials,
    required this.size,
    this.ring = false,
    this.imageUrl,
  });

  Widget _initialsText() => Center(
        child: Text(
          initials,
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.34,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [PremiumColors.navy600, PremiumColors.navy800],
        ),
        border: Border.all(
          color: ring
              ? PremiumColors.accent
              : Colors.white.withValues(alpha: 0.18),
          width: ring ? 1.5 : 1,
        ),
      ),
      child: ClipOval(
        child: (imageUrl != null && imageUrl!.isNotEmpty)
            ? Image.network(
                imageUrl!,
                width: size,
                height: size,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _initialsText(),
              )
            : _initialsText(),
      ),
    );
  }
}
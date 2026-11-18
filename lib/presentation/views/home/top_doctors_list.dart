// lib/presentation/views/home/top_doctors_list.dart
import 'package:flutter/material.dart';
import 'package:vistacall/utils/premium_theme.dart';

/// Static for now. Replace [_doctors] with your model list when ready,
/// and use [onDoctorTap] for navigation.
class TopDoctorsList extends StatelessWidget {
  final ValueChanged<int>? onDoctorTap;
  const TopDoctorsList({super.key, this.onDoctorTap});

  static const _doctors = [
    ('Dr. Sophia Martin', 'Cardiologist', '4.9', '₹800'),
    ('Dr. James Whitfield', 'Neurologist', '4.8', '₹950'),
    ('Dr. Amelia Brooks', 'Dermatologist', '4.9', '₹700'),
    ('Dr. Daniel Hayes', 'Orthopedic', '4.7', '₹850'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 214,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _doctors.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (_, i) {
          final (name, spec, rating, fee) = _doctors[i];
          return GestureDetector(
            onTap: onDoctorTap == null ? null : () => onDoctorTap!(i),
            child: Container(
              width: 176,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: PremiumColors.line),
                boxShadow: PremiumColors.softShadow(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      PremiumAvatar(
                          initials: premiumInitials(name), size: 48),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: PremiumColors.accent.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star_rounded,
                                size: 14, color: PremiumColors.accent),
                            const SizedBox(width: 3),
                            Text(
                              rating,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: PremiumColors.ink,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: PremiumColors.ink,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    spec,
                    style: const TextStyle(
                        fontSize: 12.5, color: PremiumColors.muted),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: fee,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: PremiumColors.navy800,
                              ),
                            ),
                            const TextSpan(
                              text: ' /visit',
                              style: TextStyle(
                                  fontSize: 11, color: PremiumColors.muted),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          gradient: PremiumColors.navyGradient,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.arrow_outward_rounded,
                            size: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
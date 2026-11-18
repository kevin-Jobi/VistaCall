

// import 'package:flutter/material.dart';
// import 'package:vistacall/data/models/doctor.dart';

// class DoctorCard extends StatelessWidget {
//   final DoctorModel doctor;
//   final VoidCallback onTap;

//   const DoctorCard({super.key, required this.doctor, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;
//     final fullName = doctor.personal?['fullName']?.toString() ?? 'Unknown';
//     final experience = doctor.availability?['yearsOfExperience']?.toString() ?? 'N/A';
//     final fees = doctor.availability?['fees']?.toString() ?? 'N/A';
//     final imageUrl = doctor.personal?['profileImageUrl']?.toString();

//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: colorScheme.surface,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: colorScheme.onSurface.withValues(alpha: 0.06),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(20),
//           onTap: onTap,
//           child: Padding(
//             padding: const EdgeInsets.all(12),
//             child: Row(
//               children: [
//                 _buildDoctorAvatar(imageUrl, theme, colorScheme),
//                 const SizedBox(width: 16),
//                 Expanded(child: _buildDoctorInfo(fullName, experience, fees, theme, colorScheme)),
//                 _buildBookButton(context, theme, colorScheme),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDoctorAvatar(String? imageUrl, ThemeData theme, ColorScheme colorScheme) {
//     return Container(
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         gradient: LinearGradient(
//           colors: [
//             colorScheme.primary.withValues(alpha: 0.2),
//             colorScheme.primary.withValues(alpha: 0.1),
//           ],
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: colorScheme.primary.withValues(alpha: 0.2),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: CircleAvatar(
//         radius: 32,
//         backgroundColor: Colors.transparent,
//         backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
//         child: imageUrl == null
//             ? Icon(
//                 Icons.person_rounded,
//                 color: colorScheme.primary,
//                 size: 32,
//               )
//             : null,
//       ),
//     );
//   }

//   Widget _buildDoctorInfo(
//       String name, String experience, String fees, ThemeData theme, ColorScheme colorScheme) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           name,
//           style: theme.textTheme.titleMedium?.copyWith(
//             fontWeight: FontWeight.w700,
//             color: colorScheme.onSurface,
//           ),
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//         ),
//         const SizedBox(height: 8),
//         Wrap(
//           spacing: 8,
//           runSpacing: 6,
//           children: [
//             _buildInfoChip(
//               Icons.work_outline_rounded,
//               '$experience yrs',
//               colorScheme.secondary,
//               theme,
//               colorScheme,
//             ),
//             _buildInfoChip(
//               Icons.payments_outlined,
//               '₹$fees',
//               colorScheme.tertiary,
//               theme,
//               colorScheme,
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildInfoChip(
//       IconData icon, String text, Color color, ThemeData theme, ColorScheme colorScheme) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         color: color.withValues(alpha: 0.1),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//           color: color.withValues(alpha: 0.3),
//           width: 1,
//         ),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 14, color: color),
//           const SizedBox(width: 4),
//           Text(
//             text,
//             style: theme.textTheme.bodySmall?.copyWith(
//               fontWeight: FontWeight.w600,
//               color: color,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBookButton(BuildContext context, ThemeData theme, ColorScheme colorScheme) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [colorScheme.primary, colorScheme.primaryContainer],
//         ),
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(
//             color: colorScheme.primary.withValues(alpha: 0.4),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(14),
//           onTap: onTap,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(Icons.calendar_today_rounded, color: colorScheme.onPrimary, size: 16),
//                 const SizedBox(width: 6),
//                 Text(
//                   'Book',
//                   style: theme.textTheme.bodyMedium?.copyWith(
//                     color: colorScheme.onPrimary,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }






// lib/presentation/widgets/home/doctor_card.dart
import 'package:flutter/material.dart';
import 'package:vistacall/data/models/doctor.dart';
import 'package:vistacall/utils/premium_theme.dart';

class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;
  final VoidCallback onTap;

  const DoctorCard({
    super.key,
    required this.doctor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final fullName =
        doctor.personal['fullName']?.toString() ?? 'Unknown Doctor';
    final department = doctor.personal['department']?.toString() ?? 'General';
    final experience =
        doctor.availability?['yearsOfExperience']?.toString() ?? 'N/A';
    final fees = doctor.availability?['fees']?.toString() ?? 'N/A';
    final imageUrl = doctor.personal?['profileImageUrl']?.toString();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: PremiumColors.line),
          boxShadow: PremiumColors.softShadow(),
        ),
        child: Row(
          children: [
            PremiumAvatar(
              initials: premiumInitials(fullName),
              size: 56,
              imageUrl: imageUrl,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fullName,
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
                    department,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 12.5, color: PremiumColors.muted),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: PremiumColors.accent.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.workspace_premium_rounded,
                                size: 14, color: PremiumColors.accent),
                            const SizedBox(width: 3),
                            Text(
                              '$experience yrs',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: PremiumColors.ink,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Flexible(
                        child: RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '₹$fees',
                                style: const TextStyle(
                                  fontSize: 15,
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
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
      ),
    );
  }
}
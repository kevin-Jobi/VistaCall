// // lib/presentation/widgets/home/doctor_card.dart
// import 'package:flutter/material.dart';
// import 'package:vistacall/data/models/doctor.dart';
// import 'package:vistacall/utils/constants.dart';

// class DoctorCard extends StatelessWidget {
//   final DoctorModel doctor;
//   final VoidCallback onTap;

//   const DoctorCard({
//     super.key,
//     required this.doctor,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final fullName =
//         doctor.personal['fullName']?.toString() ?? 'Unknown Doctor';
//     final department = doctor.personal['department']?.toString() ?? 'General';
//     final experience =
//         doctor.availability?['yearsOfExperience']?.toString() ?? 'N/A';
//     final fees = doctor.availability?['fees']?.toString() ?? 'N/A';
//     final imageUrl = doctor.personal?['profileImageUrl']?.toString();

//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.white, Colors.grey[50]!],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: Colors.grey[200]!, width: 1),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: .05),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(18),
//           onTap: onTap,
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               children: [
//                 _buildDoctorAvatar(imageUrl),
//                 const SizedBox(width: 14),
//                 Expanded(
//                     child: _buildDoctorInfo(
//                         fullName, department, experience, fees)),
//                 _buildViewButton(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDoctorAvatar(String? imageUrl) {
//     return Container(
//       width: 60,
//       height: 60,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             AppConstants.primaryColor,
//             AppConstants.primaryColor.withValues(alpha: 0.8),
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(16),
//         child: imageUrl != null
//             ? Image.network(
//                 imageUrl,
//                 fit: BoxFit.cover,
//                 width: 60,
//                 height: 60,
//                 errorBuilder: (context, error, stackTrace) =>
//                     _buildDefaultAvatar(),
//               )
//             : _buildDefaultAvatar(),
//       ),
//     );
//   }

//   Widget _buildDefaultAvatar() {
//     return const Icon(Icons.person_rounded, color: Colors.white, size: 32);
//   }

//   Widget _buildDoctorInfo(
//       String fullName, String department, String experience, String fees) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           fullName,
//           style: const TextStyle(
//             fontSize: 17,
//             fontWeight: FontWeight.w700,
//             color: Color(0xFF1A1A1A),
//           ),
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//         ),
//         const SizedBox(height: 6),
//         _buildDepartmentTag(department),
//         const SizedBox(height: 10),
//         Row(
//           children: [
//             _buildInfoChip(Icons.work_outline_rounded, '$experience yrs',
//                 const Color(0xFF4CAF50)),
//             const SizedBox(width: 8),
//             _buildInfoChip(
//                 Icons.payments_outlined, '₹$fees', const Color(0xFFFF9800)),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildDepartmentTag(String department) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       decoration: BoxDecoration(
//         color: AppConstants.primaryColor.withValues(alpha: 0.1),
//         borderRadius: BorderRadius.circular(8),
//         border:
//             Border.all(color: AppConstants.primaryColor.withValues(alpha: 0.2)),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(Icons.medical_services_rounded,
//               size: 13, color: AppConstants.primaryColor),
//           const SizedBox(width: 6),
//           Flexible(
//             child: Text(
//               department,
//               style: const TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//                 color: AppConstants.primaryColor,
//               ),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoChip(IconData icon, String text, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         color: color.withValues(alpha: 0.1),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: color.withValues(alpha: 0.3)),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 13, color: color),
//           const SizedBox(width: 5),
//           Text(
//             text,
//             style: TextStyle(
//                 fontSize: 11, fontWeight: FontWeight.w600, color: color),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildViewButton() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xFF42A5F5), Color(0xFF1E88E5)],
//         ),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: const Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
//           SizedBox(height: 3),
//           // Text(
//           //   'View',
//           //   style: TextStyle(
//           //     color: Colors.white,
//           //     fontSize: 10,
//           //     fontWeight: FontWeight.w700,
//           //   ),
//           // ),
//         ],
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
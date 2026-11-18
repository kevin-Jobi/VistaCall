// import 'dart:io';
// import 'package:flutter/material.dart';

// class ProfileHeader extends StatelessWidget {
//   final String name;
//   final String email;
//   final String? photoUrl;
//   final VoidCallback? onEdit;

//   const ProfileHeader({
//     super.key,
//     required this.name,
//     required this.email,
//     this.photoUrl,
//     this.onEdit,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(20),
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           _buildAvatar(),
//           const SizedBox(width: 16),
//           Expanded(child: _buildUserInfo()),
//           _buildEditButton(),
//         ],
//       ),
//     );
//   }

//   Widget _buildAvatar() {
//     return Stack(
//       children: [
//         Container(
//           width: 80,
//           height: 80,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             gradient: const LinearGradient(
//               colors: [Color(0xFF42A5F5), Color(0xFF64B5F6)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           child: ClipOval(
//             child: photoUrl != null
//                 ? Image.file(
//                     File(photoUrl!),
//                     fit: BoxFit.cover,
//                     width: 80,
//                     height: 80,
//                     errorBuilder: (context, error, stackTrace) =>
//                         _buildDefaultAvatar(),
//                   )
//                 : _buildDefaultAvatar(),
//           ),
//         ),
//         Positioned(
//           bottom: 0,
//           right: 0,
//           child: GestureDetector(
//             onTap: onEdit,
//             child: Container(
//               padding: const EdgeInsets.all(6),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF4CAF50),
//                 shape: BoxShape.circle,
//                 border: Border.all(color: Colors.white, width: 2),
//               ),
//               child: const Icon(
//                 Icons.camera_alt,
//                 size: 14,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDefaultAvatar() {
//     return const Center(
//       child: Icon(
//         Icons.person,
//         size: 40,
//         color: Colors.white,
//       ),
//     );
//   }

//   Widget _buildUserInfo() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           name.isEmpty ? 'Your Name' : name,
//           style: const TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//             color: Color(0xFF1A1A1A),
//           ),
//         ),
//         const SizedBox(height: 6),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//           decoration: BoxDecoration(
//             color: const Color(0xFFE8F5E9),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: const Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 Icons.verified,
//                 color: Color(0xFF4CAF50),
//                 size: 14,
//               ),
//               SizedBox(width: 4),
//               Text(
//                 'Verified Profile',
//                 style: TextStyle(
//                   color: Color(0xFF4CAF50),
//                   fontWeight: FontWeight.w500,
//                   fontSize: 11,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 10),
//         Row(
//           children: [
//             Icon(
//               Icons.email_outlined,
//               color: Colors.grey[600],
//               size: 16,
//             ),
//             const SizedBox(width: 6),
//             Expanded(
//               child: Text(
//                 email,
//                 style: TextStyle(
//                   color: Colors.grey[600],
//                   fontSize: 13,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildEditButton() {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(0xFFF5F5F5),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: IconButton(
//         onPressed: onEdit,
//         icon: Icon(
//           Icons.settings,
//           color: Colors.grey[700],
//           size: 20,
//         ),
//         padding: const EdgeInsets.all(8),
//         constraints: const BoxConstraints(),
//         tooltip: 'Settings',
//       ),
//     );
//   }
// }




import 'dart:io';
import 'package:flutter/material.dart';
import 'package:vistacall/utils/premium_theme.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String? photoUrl;
  final VoidCallback? onEdit;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    this.photoUrl,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: PremiumColors.line),
        boxShadow: PremiumColors.softShadow(0.07),
      ),
      child: Row(
        children: [
          _buildAvatar(),
          const SizedBox(width: 16),
          Expanded(child: _buildUserInfo()),
          const SizedBox(width: 8),
          _buildEditButton(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Stack(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [PremiumColors.navy600, PremiumColors.navy800],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: PremiumColors.accent, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: PremiumColors.navy800.withValues(alpha: 0.25),
                blurRadius: 14,
                offset: const Offset(0, 6),
                spreadRadius: -2,
              ),
            ],
          ),
          child: ClipOval(
            child: photoUrl != null
                ? Image.file(
                    File(photoUrl!),
                    fit: BoxFit.cover,
                    width: 80,
                    height: 80,
                    errorBuilder: (context, error, stackTrace) =>
                        _buildDefaultAvatar(),
                  )
                : _buildDefaultAvatar(),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: onEdit,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: PremiumColors.accent,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(
                Icons.camera_alt_rounded,
                size: 13,
                color: PremiumColors.navy900,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDefaultAvatar() {
    final initials = name.trim().isEmpty ? null : premiumInitials(name);
    return Center(
      child: initials == null
          ? const Icon(Icons.person_rounded, size: 40, color: Colors.white)
          : Text(
              initials,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
    );
  }

  Widget _buildUserInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name.isEmpty ? 'Your Name' : name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.2,
            color: PremiumColors.ink,
          ),
        ),
        const SizedBox(height: 7),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: PremiumColors.accent.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.verified_rounded,
                color: Color(0xFF9C7F36),
                size: 14,
              ),
              SizedBox(width: 5),
              Text(
                'Verified Profile',
                style: TextStyle(
                  color: PremiumColors.navy800,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Icon(
              Icons.email_outlined,
              color: PremiumColors.muted,
              size: 15,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                email,
                style: const TextStyle(
                  color: PremiumColors.muted,
                  fontSize: 12.5,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEditButton() {
    return Container(
      decoration: BoxDecoration(
        color: PremiumColors.navy800.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(13),
      ),
      child: IconButton(
        onPressed: onEdit,
        icon: const Icon(
          Icons.settings_rounded,
          color: PremiumColors.navy700,
          size: 20,
        ),
        padding: const EdgeInsets.all(10),
        constraints: const BoxConstraints(),
        tooltip: 'Settings',
      ),
    );
  }
}
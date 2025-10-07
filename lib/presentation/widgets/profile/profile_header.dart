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
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(24),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 20,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 _buildModernProfileAvatar(),
//                 const SizedBox(width: 20),
//                 Expanded(child: _buildProfileInfo()),
//                 _buildEditButton(),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildModernProfileAvatar() {
//     return Stack(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             boxShadow: [
//               BoxShadow(
//                 color: const Color(0xFF2196F3).withOpacity(0.3),
//                 blurRadius: 20,
//                 offset: const Offset(0, 10),
//               ),
//             ],
//           ),
//           child: CircleAvatar(
//             radius: 45,
//             backgroundColor: Colors.grey.shade200,
//             child: ClipOval(
//               child: photoUrl != null
//                   ? Image.file(
//                       File(photoUrl!),
//                       fit: BoxFit.cover,
//                       width: 90,
//                       height: 90,
//                       errorBuilder: (context, error, stackTrace) {
//                         print('Image.file error: $error');
//                         return _buildDefaultAvatar();
//                       },
//                     )
//                   : Image.asset(
//                       'assets/images/default_profile.png',
//                       fit: BoxFit.cover,
//                       width: 90,
//                       height: 90,
//                       errorBuilder: _buildImageError,
//                     ),
//             ),
//           ),
//         ),
//         Positioned(
//           bottom: 4,
//           right: 4,
//           child: GestureDetector(
//             onTap: onEdit,
//             child: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
//                 ),
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 8,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: const Icon(
//                 Icons.camera_alt_rounded,
//                 size: 16,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDefaultAvatar() {
//     return Container(
//       width: 90,
//       height: 90,
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         shape: BoxShape.circle,
//       ),
//       child: const Icon(
//         Icons.person_rounded,
//         size: 40,
//         color: Colors.white,
//       ),
//     );
//   }

//   Widget _buildProfileInfo() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           name.isEmpty ? 'Your Name' : name,
//           style: const TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.w700,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//           decoration: BoxDecoration(
//             color: Colors.green.shade50,
//             borderRadius: BorderRadius.circular(20),
//             border: Border.all(color: Colors.green.shade200),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 Icons.verified_rounded,
//                 color: Colors.green.shade700,
//                 size: 16,
//               ),
//               const SizedBox(width: 4),
//               Text(
//                 'Verified Doctor',
//                 style: TextStyle(
//                   color: Colors.green.shade700,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 12,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 12),
//         Container(
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: Colors.grey.shade50,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: Colors.grey.shade200),
//           ),
//           child: Row(
//             children: [
//               Icon(
//                 Icons.email_rounded,
//                 color: Colors.grey.shade600,
//                 size: 16,
//               ),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Text(
//                     email,
//                     style: TextStyle(
//                       color: Colors.grey.shade700,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildEditButton() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.grey.shade100,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: IconButton(
//         onPressed: onEdit,
//         icon: const Icon(
//           Icons.settings_rounded,
//           color: Colors.grey,
//           size: 20,
//         ),
//         tooltip: 'Edit profile',
//       ),
//     );
//   }

//   Widget _buildStatItem({
//     required IconData icon,
//     required String title,
//     required String value,
//     required Color color,
//   }) {
//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Icon(
//             icon,
//             color: color,
//             size: 20,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w700,
//             color: color,
//           ),
//         ),
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 12,
//             color: Colors.grey.shade600,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildImageError(
//       BuildContext context, Object error, StackTrace? stackTrace) {
//     return _buildDefaultAvatar();
//   }
// }



import 'dart:io';
import 'package:flutter/material.dart';

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
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildAvatar(),
          const SizedBox(width: 16),
          Expanded(child: _buildUserInfo()),
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
              colors: [Color(0xFF42A5F5), Color(0xFF64B5F6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ClipOval(
            child: photoUrl != null
                ? Image.file(
                    File(photoUrl!),
                    fit: BoxFit.cover,
                    width: 80,
                    height: 80,
                    errorBuilder: (context, error, stackTrace) => _buildDefaultAvatar(),
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
                color: const Color(0xFF4CAF50),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(
                Icons.camera_alt,
                size: 14,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDefaultAvatar() {
    return const Center(
      child: Icon(
        Icons.person,
        size: 40,
        color: Colors.white,
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
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.verified,
                color: Color(0xFF4CAF50),
                size: 14,
              ),
              SizedBox(width: 4),
              Text(
                'Verified Profile',
                style: TextStyle(
                  color: Color(0xFF4CAF50),
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(
              Icons.email_outlined,
              color: Colors.grey[600],
              size: 16,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                email,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 13,
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
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        onPressed: onEdit,
        icon: Icon(
          Icons.settings,
          color: Colors.grey[700],
          size: 20,
        ),
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(),
        tooltip: 'Settings',
      ),
    );
  }
}
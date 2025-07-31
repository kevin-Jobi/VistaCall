import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String? photoUrl;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          _buildProfileAvatar(),
          const SizedBox(width: 16),
          _buildProfileInfo(),
        ],
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return CircleAvatar(
      radius: 40,
      backgroundColor: Colors.grey.shade200,
      foregroundColor: Colors.transparent,
      child: ClipOval(
        child: photoUrl != null
            ? Image.network(
                photoUrl!,
                fit: BoxFit.cover,
                width: 80,
                height: 80,
                errorBuilder: _buildImageError,
              )
            : Image.asset(
                'assets/images/profile_image.png',
                fit: BoxFit.cover,
                width: 80,
                height: 80,
                errorBuilder: _buildImageError,
              ),
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A3C34),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(
              Icons.email,
              color: Colors.grey,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              email,
              style: const TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImageError(BuildContext context, Object error, StackTrace? stackTrace) {
    return const Text(
      'Profile Image\n(assets/images/profile_image.png)',
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.grey),
    );
  }
}
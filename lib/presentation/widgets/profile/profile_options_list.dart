import 'package:flutter/material.dart';

class ProfileOptionsList extends StatelessWidget {
  final VoidCallback onLogout;

  const ProfileOptionsList({
    super.key,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildOptionItem(
          icon: Icons.group,
          title: 'Invite Friends',
          onTap: () => _showComingSoon(context, 'Invite Friends feature'),
        ),
        _buildOptionItem(
          icon: Icons.feedback,
          title: 'Feed Back',
          onTap: () => _showComingSoon(context, 'Feedback feature'),
        ),
        _buildOptionItem(
          icon: Icons.lock,
          title: 'Privacy And Policy',
          onTap: () => _showComingSoon(context, 'Privacy And Policy page'),
        ),
        _buildOptionItem(
          icon: Icons.favorite,
          title: 'Favorite',
          onTap: () => _showComingSoon(context, 'Favorite page'),
        ),
        _buildOptionItem(
          icon: Icons.description,
          title: 'Terms And Conditions',
          onTap: () => _showComingSoon(context, 'Terms And Conditions page'),
        ),
        _buildOptionItem(
          icon: Icons.logout,
          title: 'LogOut',
          textColor: Colors.red,
          onTap: onLogout,
        ),
      ],
    );
  }

  Widget _buildOptionItem({
    required IconData icon,
    required String title,
    Color? textColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? Colors.grey),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? Colors.black,
          fontWeight: title == 'LogOut' ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$feature coming soon!')),
    );
  }
}

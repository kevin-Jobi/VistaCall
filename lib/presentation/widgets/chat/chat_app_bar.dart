import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String doctorName;
  final VoidCallback onBackPressed;

  const ChatAppBar({
    super.key,
    required this.doctorName,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness:
            theme.brightness == Brightness.dark ? Brightness.dark : Brightness.light,
        statusBarColor: colorScheme.surface,
      ),
      backgroundColor: colorScheme.surface,
      elevation: 0,
      shadowColor: colorScheme.onSurface.withValues(alpha: 0.1),
      surfaceTintColor: colorScheme.surface,
      leading: Container(
        margin: const EdgeInsets.only(left: 8),
        child: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: colorScheme.surfaceVariant.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: colorScheme.onSurface,
              size: 18,
            ),
          ),
          onPressed: onBackPressed,
        ),
      ),
      title: Row(
        children: [
          Hero(
            tag: 'avatar_$doctorName',
            child: _buildDoctorAvatar(theme, colorScheme),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctorName,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: colorScheme.secondary, // Green for online status
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Online',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        // IconButton(
        //   icon: Container(
        //     padding: const EdgeInsets.all(8),
        //     decoration: BoxDecoration(
        //       color: colorScheme.surfaceVariant.withValues(alpha: 0.1),
        //       borderRadius: BorderRadius.circular(12),
        //     ),
        //     child: Icon(
        //       Icons.videocam_rounded,
        //       color: colorScheme.onSurface,
        //       size: 22,
        //     ),
        //   ),
        //   onPressed: () {},
        // ),
        // IconButton(
        //   icon: Container(
        //     padding: const EdgeInsets.all(8),
        //     decoration: BoxDecoration(
        //       color: colorScheme.surfaceVariant.withValues(alpha: 0.1),
        //       borderRadius: BorderRadius.circular(12),
        //     ),
        //     child: Icon(
        //       Icons.phone_rounded,
        //       color: colorScheme.onSurface,
        //       size: 20,
        //     ),
        //   ),
        //   onPressed: () {},
        // ),
        // const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildDoctorAvatar(ThemeData theme, ColorScheme colorScheme) {
    final initials = _getInitials(doctorName);
    return Stack(
      children: [
        Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colorScheme.primary,
                colorScheme.primaryContainer,
              ],
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: colorScheme.primary.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              initials,
              style: theme.textTheme.titleMedium?.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: colorScheme.secondary, // Green for online status
              shape: BoxShape.circle,
              border: Border.all(color: colorScheme.onPrimary, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  String _getInitials(String name) {
    final nameParts = name.trim().split(' ');
    if (nameParts.length >= 2) {
      return '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
    } else if (nameParts.isNotEmpty) {
      return nameParts[0][0].toUpperCase();
    }
    return '';
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Use surface color for bottom nav background (white in light, dark surface in dark)
    final surfaceColor = colorScheme.surface;
    final primaryColor = colorScheme.primary;
    final onSurfaceVariant =
        colorScheme.onSurfaceVariant ?? Colors.grey.shade500;
    final shadowColor = theme.shadowColor.withValues(alpha: .08);

    return Container(
      decoration: BoxDecoration(
        color: surfaceColor, // Dynamic surface color
        boxShadow: [
          BoxShadow(
            color: shadowColor, // Theme shadow color
            blurRadius: 20,
            offset: const Offset(0, -4),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: primaryColor.withOpacity(0.05), // Dynamic primary shadow
            blurRadius: 30,
            offset: const Offset(0, -8),
            spreadRadius: 0,
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: SafeArea(
          top: false,
          child: Container(
            height: 75,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  icon: Icons.home_rounded,
                  label: 'Home',
                  index: 0,
                  theme: theme,
                  colorScheme: colorScheme,
                  onSurfaceVariant: onSurfaceVariant,
                  primaryColor: primaryColor,
                ),
                _buildNavItem(
                  icon: Icons.calendar_today_rounded,
                  label: 'Appointment',
                  index: 1,
                  theme: theme,
                  colorScheme: colorScheme,
                  onSurfaceVariant: onSurfaceVariant,
                  primaryColor: primaryColor,
                ),
                _buildNavItem(
                  icon: Icons.chat_bubble_rounded,
                  label: 'Messages',
                  index: 2,
                  theme: theme,
                  colorScheme: colorScheme,
                  onSurfaceVariant: onSurfaceVariant,
                  primaryColor: primaryColor,
                ),
                _buildNavItem(
                  icon: Icons.person_rounded,
                  label: 'Profile',
                  index: 3,
                  theme: theme,
                  colorScheme: colorScheme,
                  onSurfaceVariant: onSurfaceVariant,
                  primaryColor: primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required ThemeData theme,
    required ColorScheme colorScheme,
    required Color onSurfaceVariant,
    required Color primaryColor,
  }) {
    final isSelected = currentIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  if (isSelected)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      width: 48,
                      height: 26,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            primaryColor.withOpacity(0.15), // Dynamic primary
                            primaryColor.withOpacity(0.08),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      icon,
                      size: isSelected ? 24 : 22,
                      color: isSelected
                          ? primaryColor // Dynamic primary for selected
                          : onSurfaceVariant, // Dynamic unselected color
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                style: theme.textTheme.labelSmall?.copyWith(
                      // Use theme text style
                      fontSize: isSelected ? 11.5 : 10.5,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected
                          ? primaryColor // Dynamic primary for selected
                          : onSurfaceVariant, // Dynamic unselected color
                      letterSpacing: 0.2,
                    ) ??
                    TextStyle(
                      // Fallback if theme text is null
                      fontSize: isSelected ? 11.5 : 10.5,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected ? primaryColor : onSurfaceVariant,
                      letterSpacing: 0.2,
                    ),
                child: Text(label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

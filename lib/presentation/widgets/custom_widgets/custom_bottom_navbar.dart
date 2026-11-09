import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const BorderRadius _radius = BorderRadius.only(
    topLeft: Radius.circular(28),
    topRight: Radius.circular(28),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final surfaceColor = colorScheme.surface;
    final primaryColor = colorScheme.primary;
    final onSurfaceVariant = colorScheme.onSurfaceVariant;
    final shadowColor = theme.shadowColor.withValues(alpha: 0.08);

    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: _radius,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 24,
            offset: const Offset(0, -6),
          ),
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.05),
            blurRadius: 32,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: _radius,
        child: Material(
          color: surfaceColor,
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
              child: SizedBox(
                height: 60,
                child: Row(
                  children: [
                    _buildNavItem(
                      icon: Icons.home_outlined,
                      selectedIcon: Icons.home_rounded,
                      label: 'Home',
                      index: 0,
                      theme: theme,
                      onSurfaceVariant: onSurfaceVariant,
                      primaryColor: primaryColor,
                    ),
                    _buildNavItem(
                      icon: Icons.calendar_month_outlined,
                      selectedIcon: Icons.calendar_month_rounded,
                      label: 'Appointment',
                      index: 1,
                      theme: theme,
                      onSurfaceVariant: onSurfaceVariant,
                      primaryColor: primaryColor,
                    ),
                    _buildNavItem(
                      icon: Icons.chat_bubble_outline_rounded,
                      selectedIcon: Icons.chat_bubble_rounded,
                      label: 'Messages',
                      index: 2,
                      theme: theme,
                      onSurfaceVariant: onSurfaceVariant,
                      primaryColor: primaryColor,
                    ),
                    _buildNavItem(
                      icon: Icons.person_outline_rounded,
                      selectedIcon: Icons.person_rounded,
                      label: 'Profile',
                      index: 3,
                      theme: theme,
                      onSurfaceVariant: onSurfaceVariant,
                      primaryColor: primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData selectedIcon,
    required String label,
    required int index,
    required ThemeData theme,
    required Color onSurfaceVariant,
    required Color primaryColor,
  }) {
    final isSelected = currentIndex == index;
    final contentColor = isSelected ? primaryColor : onSurfaceVariant;

    return Expanded(
      child: Semantics(
        button: true,
        selected: isSelected,
        label: label,
        child: InkWell(
          onTap: () => onTap(index),
          borderRadius: BorderRadius.circular(18),
          splashColor: primaryColor.withValues(alpha: 0.08),
          highlightColor: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Pill indicator behind the icon
              AnimatedContainer(
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeOutCubic,
                width: isSelected ? 60 : 40,
                height: 32,
                decoration: BoxDecoration(
                  color: isSelected
                      ? primaryColor.withValues(alpha: 0.12)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: (child, animation) =>
                        ScaleTransition(scale: animation, child: child),
                    child: Icon(
                      isSelected ? selectedIcon : icon,
                      key: ValueKey(isSelected),
                      size: 24,
                      color: contentColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeOutCubic,
                style:
                    (theme.textTheme.labelSmall ?? const TextStyle()).copyWith(
                  fontSize: 11,
                  height: 1.2,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: contentColor,
                  letterSpacing: 0.2,
                ),
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

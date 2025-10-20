import 'package:flutter/material.dart';

class DoctorListHeader extends StatelessWidget {
  final int count;

  const DoctorListHeader({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primary.withValues(alpha: 0.1),
            colorScheme.primary.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.medical_services_rounded,
                  color: colorScheme.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$count Doctors Available',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    'Choose the best for you',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          _buildSortButton(theme, colorScheme),
        ],
      ),
    );
  }

  Widget _buildSortButton(ThemeData theme, ColorScheme colorScheme) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onSurface.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: PopupMenuButton(
        color: colorScheme.surfaceVariant.withValues(alpha: 0.1),
        icon: Icon(
          Icons.tune_rounded,
          color: colorScheme.primary,
          size: 22,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        offset: const Offset(0, 50),
        itemBuilder: (BuildContext context) {
          return [
            _buildPopupMenuItem(
              'Experience: Low to High',
              Icons.trending_up_rounded,
              colorScheme,
              theme,
            ),
            _buildPopupMenuItem(
              'Experience: High to Low',
              Icons.trending_down_rounded,
              colorScheme,
              theme,
            ),
            _buildPopupMenuItem(
              'Price: Low to High',
              Icons.attach_money_rounded,
              colorScheme,
              theme,
            ),
            _buildPopupMenuItem(
              'Price: High to Low',
              Icons.money_off_rounded,
              colorScheme,
              theme,
            ),
          ];
        },
      ),
    );
  }

  PopupMenuItem _buildPopupMenuItem(
      String text, IconData icon, ColorScheme colorScheme, ThemeData theme) {
    return PopupMenuItem(
      value: text,
      child: Row(
        children: [
          Icon(icon, size: 20, color: colorScheme.primary),
          const SizedBox(width: 12),
          Text(
            text,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
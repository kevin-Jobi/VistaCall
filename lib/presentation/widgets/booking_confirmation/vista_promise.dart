import 'package:flutter/material.dart';

class VistaPromise extends StatelessWidget {
  final ThemeData theme;
  final ColorScheme colorScheme;

  const VistaPromise({
    super.key,
    required this.theme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.secondary.withValues(alpha: .1),
            colorScheme.secondaryContainer.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.secondary.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colorScheme.secondary, colorScheme.secondaryContainer],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.verified_rounded,
              color: colorScheme.onSecondary,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'VistaCall Promise',
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.secondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.info_outline_rounded,
            color: colorScheme.secondary.withValues(alpha: 0.7),
            size: 20,
          ),
        ],
      ),
    );
  }
}
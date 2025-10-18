import 'package:flutter/material.dart';
import '../../../viewmodels/booking_confirmation_viewmodel.dart';

class AppointmentCard extends StatelessWidget {
  final BookingConfirmationViewModel viewModel;
  final ThemeData theme;
  final ColorScheme colorScheme;

  const AppointmentCard({
    super.key,
    required this.viewModel,
    required this.theme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: _buildCardDecoration(colorScheme),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(theme, colorScheme),
            const SizedBox(height: 16),
            _buildAppointmentTimeContainer(theme, colorScheme),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildCardDecoration(ColorScheme colorScheme) {
    return BoxDecoration(
      color: colorScheme.surface,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: colorScheme.primary.withValues(alpha: .1),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(ThemeData theme, ColorScheme colorScheme) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colorScheme.secondary, colorScheme.secondaryContainer],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.access_time_rounded, 
              color: colorScheme.onSecondary, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          'Appointment Time',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildAppointmentTimeContainer(ThemeData theme, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.tertiaryContainer, 
                  colorScheme.tertiaryContainer.withValues(alpha: 0.3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppointmentDateRow(theme, colorScheme),
          const SizedBox(height: 8),
          _buildTimeDifferenceRow(theme, colorScheme),
        ],
      ),
    );
  }

  Widget _buildAppointmentDateRow(ThemeData theme, ColorScheme colorScheme) {
    return Row(
      children: [
        Icon(Icons.calendar_today_rounded, size: 18, 
            color: colorScheme.onTertiaryContainer),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            viewModel.formatAppointmentTime(),
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.onTertiaryContainer,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeDifferenceRow(ThemeData theme, ColorScheme colorScheme) {
    return Row(
      children: [
        Icon(Icons.timer_outlined, size: 18, color: colorScheme.onSurfaceVariant),
        const SizedBox(width: 8),
        Text(
          viewModel.getTimeDifference(),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import '../../../viewmodels/booking_confirmation_viewmodel.dart';

class DoctorCard extends StatelessWidget {
  final BookingConfirmationViewModel viewModel;
  final ThemeData theme;
  final ColorScheme colorScheme;

  const DoctorCard({
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
        child: Row(
          children: [
            _buildDoctorAvatar(colorScheme),
            const SizedBox(width: 16),
            Expanded(child: _buildDoctorInfo(theme, colorScheme)),
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

  Widget _buildDoctorAvatar(ColorScheme colorScheme) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: .3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 35,
        backgroundColor: colorScheme.surfaceVariant,
        backgroundImage: const AssetImage('assets/images/generalphysician.png'),
        child: const Icon(Icons.person, color: Colors.white, size: 30),
      ),
    );
  }

  Widget _buildDoctorInfo(ThemeData theme, ColorScheme colorScheme) {
    final doctor = viewModel.model.doctor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dr. ${doctor.personal['fullName'] as String}',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 6),
        _buildDepartmentBadge(theme, colorScheme),
        const SizedBox(height: 8),
        _buildHospitalInfo(theme, colorScheme),
      ],
    );
  }

  Widget _buildDepartmentBadge(ThemeData theme, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Text(
        viewModel.model.doctor.personal['department'],
        style: theme.textTheme.labelSmall?.copyWith(
          color: colorScheme.onTertiaryContainer,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildHospitalInfo(ThemeData theme, ColorScheme colorScheme) {
    return Row(
      children: [
        Icon(Icons.location_on_rounded, size: 16, color: colorScheme.onSurfaceVariant),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            viewModel.model.doctor.personal['hospitalName'],
            style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
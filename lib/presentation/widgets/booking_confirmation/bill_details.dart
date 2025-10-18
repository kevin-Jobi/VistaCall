import 'package:flutter/material.dart';
import '../../../viewmodels/booking_confirmation_viewmodel.dart';

class BillDetails extends StatelessWidget {
  final BookingConfirmationViewModel viewModel;
  final ThemeData theme;
  final ColorScheme colorScheme;

  const BillDetails({
    super.key,
    required this.viewModel,
    required this.theme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final fee = viewModel.model.doctor.availability['fees'].toString();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: _buildCardDecoration(colorScheme),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(theme, colorScheme),
            const SizedBox(height: 20),
            _buildBillRow(theme, colorScheme, 'Consultation Fee', '₹$fee', false),
            _buildBillRow(theme, colorScheme, 'Service Fee & Tax', 'FREE', false,
                color: colorScheme.tertiary),
            const SizedBox(height: 12),
            Container(height: 1, color: colorScheme.outline),
            const SizedBox(height: 12),
            _buildBillRow(theme, colorScheme, 'Total Payable', '₹$fee', true),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(ThemeData theme, ColorScheme colorScheme) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colorScheme.secondaryContainer, colorScheme.secondary],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.receipt_long_rounded,
            color: colorScheme.onSecondaryContainer,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Bill Details',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildBillRow(ThemeData theme, ColorScheme colorScheme, String title,
      String amount, bool isTotal, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontSize: isTotal ? 16 : 15,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
              color: isTotal
                  ? colorScheme.onSurface
                  : colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            amount,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontSize: isTotal ? 18 : 15,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w600,
              color: color ?? (isTotal ? colorScheme.onSurface : colorScheme.onSurfaceVariant),
            ),
          ),
        ],
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
}
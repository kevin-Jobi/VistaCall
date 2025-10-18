import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/payment/payment_bloc.dart';
import '../../../bloc/payment/payment_event.dart';
import '../../../viewmodels/booking_confirmation_viewmodel.dart';

class PaymentSection extends StatelessWidget {
  final BookingConfirmationViewModel viewModel;
  final ThemeData theme;
  final ColorScheme colorScheme;

  const PaymentSection({
    super.key,
    required this.viewModel,
    required this.theme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        final selectedPayment = state is PaymentSelected ? state.paymentMethod : null;
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
                _buildPaymentOption(
                  context,
                  'Pay Online',
                  Icons.credit_card_rounded,
                  colorScheme.primary,
                  'Secure & Quick',
                  selectedPayment,
                ),
                const SizedBox(height: 12),
                _buildPaymentOption(
                  context,
                  'Pay At Clinic',
                  Icons.store_rounded,
                  colorScheme.secondary,
                  'Pay when you visit',
                  selectedPayment,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(ThemeData theme, ColorScheme colorScheme) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colorScheme.tertiary, colorScheme.tertiaryContainer],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.payment_rounded, 
              color: colorScheme.onTertiary, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          'Payment Method',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentOption(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    String subtitle,
    String? selectedPayment,
  ) {
    final isSelected = selectedPayment == title;
    return GestureDetector(
      onTap: () => context.read<PaymentBloc>().add(SelectPayment(title)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: .1) : colorScheme.surfaceVariant.withValues(alpha: .1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : colorScheme.outline.withValues(alpha: .3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            _buildPaymentIcon(icon, color),
            const SizedBox(width: 12),
            Expanded(child: _buildPaymentInfo(title, subtitle, isSelected, theme, color)),
            _buildPaymentPriceAndSelector(isSelected, color, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentIcon(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }

  Widget _buildPaymentInfo(String title, String subtitle, bool isSelected, ThemeData theme, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isSelected ? color : theme.colorScheme.onSurface,
          ),
        ),
        Text(
          subtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentPriceAndSelector(bool isSelected, Color color, ThemeData theme) {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            viewModel.consultationFee,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: isSelected ? color : theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          _buildRadioIndicator(isSelected, color, theme.colorScheme),
        ],
      ),
    );
  }

  Widget _buildRadioIndicator(bool isSelected, Color color, ColorScheme colorScheme) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? color : colorScheme.outlineVariant,
          width: 2,
        ),
      ),
      child: isSelected
          ? Container(
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
            )
          : null,
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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/payment/payment_bloc.dart';
import '../../../bloc/payment/payment_event.dart';
import '../../../viewmodels/booking_confirmation_viewmodel.dart';

class ConfirmButton extends StatelessWidget {
  final BookingConfirmationViewModel viewModel;
  final ThemeData theme;
  final ColorScheme colorScheme;

  const ConfirmButton({
    super.key,
    required this.viewModel,
    required this.theme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        final isLoading = state is PaymentLoading;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colorScheme.primary, colorScheme.primaryContainer],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: colorScheme.primary.withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: isLoading ? null : () => _handleConfirmPress(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: isLoading
                ? CircularProgressIndicator(color: colorScheme.onPrimary)
                : _buildButtonContent(theme, colorScheme),
          ),
        );
      },
    );
  }

  Widget _buildButtonContent(ThemeData theme, ColorScheme colorScheme) {
    final fee = viewModel.model.doctor.availability['fees'].toString();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '₹$fee',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'View Bill',
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.onPrimary.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
        const SizedBox(width: 20),
        Container(width: 1, height: 40, color: colorScheme.onPrimary.withValues(alpha: 0.3)),
        const SizedBox(width: 20),
        Flexible(
          flex: 2,
          child: Text(
            'confirm clinic visit',
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ),
        const SizedBox(width: 4),
        Icon(Icons.arrow_forward_rounded, color: colorScheme.onPrimary, size: 18),
      ],
    );
  }

  void _handleConfirmPress(BuildContext context) {
    if (viewModel.model.selectedDate == null || viewModel.model.selectedSlot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid date or slot', style: TextStyle(color: colorScheme.onErrorContainer)),
          backgroundColor: colorScheme.errorContainer,
        ),
      );
      return;
    }

    final paymentBloc = context.read<PaymentBloc>();
    final state = paymentBloc.state;
    final paymentMethod = state is PaymentSelected ? state.paymentMethod : 'Pay At Clinic';

    paymentBloc.add(ConfirmBooking(
      doctor: viewModel.model.doctor,
      selectedDate: viewModel.model.selectedDate!,
      selectedSlot: viewModel.model.selectedSlot!,
      paymentMethod: paymentMethod,
      userName: viewModel.model.selectedPatientName,
    ));
  }
}
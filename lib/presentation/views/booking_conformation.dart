import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:vistacall/presentation/widgets/booking_confirmation/bill_details.dart';
import 'package:vistacall/presentation/widgets/booking_confirmation/confirm_button.dart';
import 'package:vistacall/presentation/widgets/booking_confirmation/patient_section.dart';
import 'package:vistacall/presentation/widgets/booking_confirmation/vista_promise.dart';
import '../../bloc/add_patient/patient_bloc.dart';
import '../../bloc/payment/payment_bloc.dart';
import '../../viewmodels/booking_confirmation_viewmodel.dart';
import '../widgets/booking_confirmation/doctor_card.dart';
import '../widgets/booking_confirmation/appointment_card.dart';
import '../widgets/booking_confirmation/payment_section.dart';

import '../../data/models/doctor.dart';
import '../../presentation/views/booking_successpage.dart';

class BookingConformation extends StatefulWidget {
  final DoctorModel doctor;
  final DateTime? selectedDate;
  final String? selectedSlot;

  const BookingConformation({
    super.key,
    required this.doctor,
    this.selectedDate,
    this.selectedSlot,
  });

  @override
  State<BookingConformation> createState() => _BookingConfirmationPageState();
}

class _BookingConfirmationPageState extends State<BookingConformation> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookingConfirmationViewModel(
        doctor: widget.doctor,
        selectedDate: widget.selectedDate,
        selectedSlot: widget.selectedSlot,
      ),
      child: Consumer<BookingConfirmationViewModel>(
        builder: (context, viewModel, child) {
          final theme = Theme.of(context);
          final colorScheme = theme.colorScheme;

          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => PaymentBloc()),
              BlocProvider(
                  create: (context) => PatientBloc()..add(LoadPatients())),
            ],
            child: BlocListener<PaymentBloc, PaymentState>(
              listener: (context, state) =>
                  _handlePaymentState(context, state, colorScheme),
              child: Scaffold(
                backgroundColor: colorScheme.background,
                appBar: _buildAppBar(context, colorScheme),
                body: SafeArea(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        DoctorCard(
                            viewModel: viewModel,
                            theme: theme,
                            colorScheme: colorScheme),
                        const SizedBox(height: 20),
                        AppointmentCard(
                            viewModel: viewModel,
                            theme: theme,
                            colorScheme: colorScheme),
                        const SizedBox(height: 20),
                        VistaPromise(theme: theme, colorScheme: colorScheme),
                        const SizedBox(height: 30),
                        PaymentSection(
                            viewModel: viewModel,
                            theme: theme,
                            colorScheme: colorScheme),
                        const SizedBox(height: 30),
                        BillDetails(
                            viewModel: viewModel,
                            theme: theme,
                            colorScheme: colorScheme),
                        const SizedBox(height: 30),
                        PatientSection(
                            viewModel: viewModel,
                            theme: theme,
                            colorScheme: colorScheme),
                        const SizedBox(height: 30),
                        ConfirmButton(
                            viewModel: viewModel,
                            theme: theme,
                            colorScheme: colorScheme),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
      BuildContext context, ColorScheme colorScheme) {
    return AppBar(
      backgroundColor: colorScheme.surface,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: colorScheme.surfaceVariant.withValues(alpha: .1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.arrow_back_ios_new,
              size: 18, color: colorScheme.onSurface),
        ),
      ),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [colorScheme.primary, colorScheme.primaryContainer]),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.local_hospital_rounded,
                color: colorScheme.onPrimary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Booking Confirmation',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  void _handlePaymentState(
      BuildContext context, PaymentState state, ColorScheme colorScheme) {
    if (state is PaymentSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Booking confirmed!',
                style: TextStyle(color: colorScheme.onInverseSurface)),
            backgroundColor: colorScheme.inverseSurface),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BookingSuccessPage(
            doctor: state.doctor!,
            selectedDate: state.selectedDate!,
            selectedSlot: state.selectedSlot!,
            paymentMethod: state.paymentMethod!,
          ),
        ),
      );
    } else if (state is PaymentError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(state.error,
                style: TextStyle(color: colorScheme.onErrorContainer)),
            backgroundColor: colorScheme.errorContainer),
      );
    }
  }
}

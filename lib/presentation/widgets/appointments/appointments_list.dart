
import 'package:flutter/material.dart';
import 'package:vistacall/bloc/appointments/appointments_state.dart';
import 'package:vistacall/presentation/widgets/appointments/appointment_card.dart';
import 'package:vistacall/viewmodels/appointments_viewmodel.dart';

class AppointmentsList extends StatelessWidget {
  final AppointmentsViewModel viewModel;
  final AppointmentsLoadedState state;

  const AppointmentsList({
    super.key,
    required this.viewModel,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final appointments = viewModel.getFilteredAppointments(state);

    return Expanded(
      child: appointments.isEmpty
          ? const Center(child: Text('No appointments found'))
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                return AppointmentCard(
                  appointment: appointments[index],
                  viewModel: viewModel,
                );
              },
            ),
    );
  }
}
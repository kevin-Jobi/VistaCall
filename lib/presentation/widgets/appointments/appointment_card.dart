
import 'package:flutter/material.dart';
import 'package:vistacall/data/models/appointment.dart';
import 'package:vistacall/viewmodels/appointments_viewmodel.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final AppointmentsViewModel viewModel;

  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text(
          appointment.doctorName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${appointment.specialty}\n${appointment.date}  ${appointment.time}',
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          color: viewModel.getStatusColor(appointment.status),
          child: Text(
            appointment.status,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
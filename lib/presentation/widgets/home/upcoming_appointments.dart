// lib/presentation/widgets/home/upcoming_appointments.dart

import 'package:flutter/material.dart';
import 'package:vistacall/data/models/appointment.dart';

class UpcomingAppointments extends StatelessWidget {
  final List<Appointment> appointments;

  const UpcomingAppointments({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    if (appointments.isEmpty) return const SizedBox();

    return Card(
      elevation: 2,
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text(appointments[0].doctorName),
        subtitle: Text(
          '${appointments[0].specialty}\n${appointments[0].date} - ${appointments[0].time}',
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          color: Colors.green,
          child: Text(
            appointments[0].status,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:vistacall/data/models/appointment.dart';
// import 'package:vistacall/viewmodels/appointments_viewmodel.dart';

// class AppointmentCard extends StatelessWidget {
//   final Appointment appointment;
//   final AppointmentsViewModel viewModel;

//   const AppointmentCard({
//     super.key,
//     required this.appointment,
//     required this.viewModel,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       margin: const EdgeInsets.only(bottom: 16),
//       child: ListTile(
//         leading: const CircleAvatar(
//           backgroundColor: Colors.grey,
//           child: Icon(Icons.person, color: Colors.white),
//         ),
//         title: Text(
//           appointment.doctorName,
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         subtitle: Text(
//           '${appointment.specialty}\n${appointment.date}  ${appointment.time}',
//         ),
//         trailing: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//           color: viewModel.getStatusColor(appointment.status),
//           child: Text(
//             appointment.status,
//             style: const TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }
// }

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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F3FF),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildAvatar(),
          const SizedBox(width: 16),
          Expanded(child: _buildAppointmentInfo()),
          const SizedBox(width: 12),
          _buildStatusBadge(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.person,
        color: Colors.white,
        size: 28,
      ),
    );
  }

  Widget _buildAppointmentInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          appointment.doctorName,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          appointment.specialty,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          appointment.date,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
          ),
        ),
        Text(
          appointment.time,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge() {
    final color = viewModel.getStatusColor(appointment.status);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        appointment.status,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
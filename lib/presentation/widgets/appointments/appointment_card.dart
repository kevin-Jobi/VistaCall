import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    return GestureDetector(
      // onTap: () {
      //   Navigator.pushNamed(context, '/booking-details',
      //       arguments: appointment);
      // },
      onTap: () {
    try {
      final appointmentDate = DateFormat('yyyy-MM-dd').parse(appointment.date);
      final isPast = appointmentDate.isBefore(DateTime.now());
      final route = isPast ? '/booking-details-with-rating' : '/booking-details';
      Navigator.pushNamed(context, route, arguments: appointment);
    } catch (e) {
      Navigator.pushNamed(context, '/booking-details', arguments: appointment);
    }
  },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 210, 226, 253),
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
            // _buildStatusBadge(),
            _buildMessageButton(),
          ],
        ),
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
          // appointment.date,
          _formatDate(appointment.date),
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

  Widget _buildMessageButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF42A5F5), Color(0xFF1E88E5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF42A5F5).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.chat_bubble_rounded,
            color: Colors.white,
            size: 14,
          ),
          SizedBox(width: 4),
          Text(
            'Chat',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd-MM-yyyy').format(date);
    } catch (_) {
      return dateStr;
    }
  }
}

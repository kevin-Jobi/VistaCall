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
      onTap: () {
        Navigator.pushNamed(context, '/booking-details',
            arguments: appointment);
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

  // Widget _buildStatusBadge() {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
  //     decoration: BoxDecoration(
  //       color: const Color.fromARGB(255, 116, 167, 255),
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //     child: const Text(
  //       'Message',
  //       style: TextStyle(
  //         color: Colors.white,
  //         fontSize: 12,
  //         fontWeight: FontWeight.w500,
  //       ),
  //     ),
  //   );
  // }

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



// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:vistacall/data/models/appointment.dart';
// import 'package:vistacall/viewmodels/appointments_viewmodel.dart';

// class AppointmentCard extends StatefulWidget {
//   final Appointment appointment;
//   final AppointmentsViewModel viewModel;

//   const AppointmentCard({
//     super.key,
//     required this.appointment,
//     required this.viewModel,
//   });

//   @override
//   State<AppointmentCard> createState() => _AppointmentCardState();
// }

// class _AppointmentCardState extends State<AppointmentCard> {
//   bool _isPressed = false;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: (_) => setState(() => _isPressed = true),
//       onTapUp: (_) {
//         setState(() => _isPressed = false);
//         Navigator.pushNamed(context, '/booking-details',
//             arguments: widget.appointment);
//       },
//       onTapCancel: () => setState(() => _isPressed = false),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 150),
//         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         transform: Matrix4.identity()..scale(_isPressed ? 0.98 : 1.0),
//         child: Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Colors.white,
//                 Colors.grey[50]!,
//               ],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.circular(18),
//             border: Border.all(
//               color: Colors.grey[200]!,
//               width: 1,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.06),
//                 blurRadius: 12,
//                 offset: const Offset(0, 3),
//                 spreadRadius: 0,
//               ),
//             ],
//           ),
//           child: Row(
//             children: [
//               _buildAvatar(),
//               const SizedBox(width: 14),
//               Expanded(child: _buildAppointmentInfo()),
//               const SizedBox(width: 10),
//               _buildMessageButton(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildAvatar() {
//     return Container(
//       width: 52,
//       height: 52,
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xFF42A5F5), Color(0xFF64B5F6)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         shape: BoxShape.circle,
//         boxShadow: [
//           BoxShadow(
//             color: const Color(0xFF42A5F5).withOpacity(0.25),
//             blurRadius: 10,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Stack(
//         children: [
//           // Shine effect
//           Positioned(
//             top: 6,
//             right: 6,
//             child: Container(
//               width: 16,
//               height: 16,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Colors.white.withOpacity(0.5),
//                     Colors.white.withOpacity(0.0),
//                   ],
//                 ),
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//           const Center(
//             child: Icon(
//               Icons.person_rounded,
//               color: Colors.white,
//               size: 26,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAppointmentInfo() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           widget.appointment.doctorName,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w700,
//             color: Color(0xFF1A1A1A),
//             letterSpacing: 0.1,
//           ),
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//         ),
//         const SizedBox(height: 3),
//         Row(
//           children: [
//             Icon(
//               Icons.medical_services_rounded,
//               size: 12,
//               color: const Color(0xFF42A5F5),
//             ),
//             const SizedBox(width: 4),
//             Expanded(
//               child: Text(
//                 widget.appointment.specialty,
//                 style: const TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                   color: Color(0xFF42A5F5),
//                 ),
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 6),
//         Row(
//           children: [
//             Icon(
//               Icons.calendar_today_rounded,
//               size: 11,
//               color: Colors.grey[600],
//             ),
//             const SizedBox(width: 4),
//             Text(
//               _formatDate(widget.appointment.date),
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.grey[700],
//               ),
//             ),
//             const SizedBox(width: 8),
//             Icon(
//               Icons.access_time_rounded,
//               size: 11,
//               color: Colors.grey[600],
//             ),
//             const SizedBox(width: 4),
//             Text(
//               widget.appointment.time,
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.grey[700],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildMessageButton() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xFF42A5F5), Color(0xFF1E88E5)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: const Color(0xFF42A5F5).withOpacity(0.3),
//             blurRadius: 8,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: const Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             Icons.chat_bubble_rounded,
//             color: Colors.white,
//             size: 14,
//           ),
//           SizedBox(width: 4),
//           Text(
//             'Chat',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 12,
//               fontWeight: FontWeight.w700,
//               letterSpacing: 0.2,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   String _formatDate(String dateStr) {
//     try {
//       final date = DateTime.parse(dateStr);
//       return DateFormat('dd MMM').format(date);
//     } catch (_) {
//       return dateStr;
//     }
//   }
// }
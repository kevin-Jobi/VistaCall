// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:vistacall/bloc/messages/messages_bloc.dart';
// import 'package:vistacall/bloc/messages/messages_event.dart';
// import 'package:vistacall/data/models/appointment.dart';
// import 'package:vistacall/presentation/views/chatDetailScreen.dart';
// import 'package:vistacall/viewmodels/appointments_viewmodel.dart';
// import 'package:vistacall/viewmodels/messages_viewmodel.dart';

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
//         final messagesBloc = BlocProvider.of<MessagesBloc>(context);
//     messagesBloc.add(LoadMessagesEvent()); // Trigger loading once

//     final viewModel = MessagesViewModel(messagesBloc);
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;

//     // Light blue container background equivalent
//     final primaryContainer = colorScheme.primaryContainer;
//     final shadowColor = theme.primaryColor.withValues(alpha: 0.20);

//     return GestureDetector(
//       onTap: () {
//         try {
//           final appointmentDate =
//               DateFormat('yyyy-MM-dd').parse(appointment.date);
//           final isPast = appointmentDate.isBefore(DateTime.now());
//           final route =
//               isPast ? '/booking-details-with-rating' : '/booking-details';
//           Navigator.pushNamed(context, route, arguments: appointment);
//         } catch (e) {
//           Navigator.pushNamed(context, '/booking-details',
//               arguments: appointment);
//         }
//       },
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: primaryContainer, // Dynamic light primary container
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: shadowColor, // Dynamic shadow
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             _buildAvatar(colorScheme),
//             const SizedBox(width: 16),
//             Expanded(child: _buildAppointmentInfo(theme, colorScheme)),
//             const SizedBox(width: 12),

// Column(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   children: [
//     Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: _buildChatButton(
//       context,
//       theme,
//       colorScheme,
//       colorScheme.primary.withValues(alpha: 0.3),
//     ),
//     ),
    
    
//     _buildDetailsButton(theme, colorScheme,
//                     colorScheme.primary.withValues(alpha: 0.3)),
//   ],
// )



//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAvatar(ColorScheme colorScheme) {
//     return Container(
//       width: 56,
//       height: 56,
//       decoration: BoxDecoration(
//         color: colorScheme.primaryContainer, // Dynamic avatar background
//         shape: BoxShape.circle,
//       ),
//       child: Icon(
//         Icons.person,
//         color: colorScheme.onPrimaryContainer, // Dynamic icon color
//         size: 28,
//       ),
//     );
//   }

//   Widget _buildAppointmentInfo(ThemeData theme, ColorScheme colorScheme) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           appointment.doctorName,
//           style: theme.textTheme.titleMedium?.copyWith(
//                 fontWeight: FontWeight.w600,
//                 color: colorScheme.onSurface, // Dynamic dark text
//               ) ??
//               const TextStyle(
//                 fontSize: 17,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black87,
//               ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           appointment.specialty,
//           style: theme.textTheme.bodyMedium?.copyWith(
//                 color: colorScheme.onSurfaceVariant, // Dynamic grey text
//               ) ??
//               TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey.shade700,
//               ),
//         ),
//         const SizedBox(height: 6),
//         Text(
//           _formatDate(appointment.date),
//           style: theme.textTheme.bodySmall?.copyWith(
//                 color: colorScheme.onSurfaceVariant, // Dynamic grey text
//               ) ??
//               TextStyle(
//                 fontSize: 13,
//                 color: Colors.grey.shade600,
//               ),
//         ),
//         Text(
//           appointment.time,
//           style: theme.textTheme.bodySmall?.copyWith(
//                 color: colorScheme.onSurfaceVariant, // Dynamic grey text
//               ) ??
//               TextStyle(
//                 fontSize: 13,
//                 color: Colors.grey.shade600,
//               ),
//         ),
//       ],
//     );
//   }



// Widget _buildDetailsButton(
//     ThemeData theme, ColorScheme colorScheme, Color shadowColor) {
//   return Container(
//     padding: const EdgeInsets.all(8),
//     decoration: BoxDecoration(
//       color: colorScheme.primary.withValues(alpha: 0.1),
//       shape: BoxShape.circle,
//       boxShadow: [
//         BoxShadow(
//           color: shadowColor,
//           blurRadius: 6,
//           offset: const Offset(0, 2),
//         ),
//       ],
//     ),
//     child: Icon(
//       Icons.arrow_forward_ios, // Simple arrow icon
//       color: colorScheme.onPrimary,
//       size: 14,
//     ),
//   );
// }

//   Widget _buildChatButton(
//       BuildContext context, ThemeData theme, ColorScheme colorScheme, Color shadowColor) {
//     return GestureDetector(
//       onTap: ()async{
//         final patientId = FirebaseAuth.instance.currentUser?.uid;
//       if (patientId == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Please log in to chat')),
//         );
//         return;
//       }
//       final doctorId = appointment.doctorId;          // <-- make sure this field exists
//       if (doctorId == null || doctorId.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Doctor information missing')),
//         );
//         return;
//       }
//       final chatId = _getChatId(patientId, doctorId);
//       await FirebaseFirestore.instance.collection('chats').doc(chatId).set({
//         'participants': [patientId, doctorId],
//         'lastMessage': '',
//         'timestamp': FieldValue.serverTimestamp(),
//       }, SetOptions(merge: true));

//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => ChatDetailScreen(
//             doctorId: doctorId,
//             doctorName: appointment.doctorName,
//             chatId: chatId,
//           ),
//         ),
//       );
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               colorScheme.primary, // Dynamic primary gradient
//               colorScheme.primary.withValues(alpha: 0.8),
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: shadowColor, // Dynamic primary shadow
//               blurRadius: 8,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               'Message',
//               style: theme.textTheme.labelSmall?.copyWith(
//                     color: colorScheme.onPrimary, // Dynamic white text
//                     fontWeight: FontWeight.w700,
//                     letterSpacing: 0.2,
//                     fontSize: 12,
//                   ) ??
//                   const TextStyle(
//                     color: Colors.white,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w700,
//                     letterSpacing: 0.2,
//                   ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String _formatDate(String dateStr) {
//     try {
//       final date = DateTime.parse(dateStr);
//       return DateFormat('d MMM yyyy').format(date);
//     } catch (_) {
//       return dateStr;
//     }
//   }
// }
// String _getChatId(String a, String b) =>
//     a.compareTo(b) < 0 ? '$a-$b' : '$b-$a';




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vistacall/bloc/messages/messages_bloc.dart';
import 'package:vistacall/bloc/messages/messages_event.dart';
import 'package:vistacall/data/models/appointment.dart';
import 'package:vistacall/presentation/views/chatDetailScreen.dart';
import 'package:vistacall/utils/premium_theme.dart';
import 'package:vistacall/viewmodels/appointments_viewmodel.dart';
import 'package:vistacall/viewmodels/messages_viewmodel.dart';

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
    final messagesBloc = BlocProvider.of<MessagesBloc>(context);
    messagesBloc.add(LoadMessagesEvent()); // Trigger loading once

    final viewModel = MessagesViewModel(messagesBloc);

    return GestureDetector(
      onTap: () {
        try {
          final appointmentDate =
              DateFormat('yyyy-MM-dd').parse(appointment.date);
          final isPast = appointmentDate.isBefore(DateTime.now());
          final route =
              isPast ? '/booking-details-with-rating' : '/booking-details';
          Navigator.pushNamed(context, route, arguments: appointment);
        } catch (e) {
          Navigator.pushNamed(context, '/booking-details',
              arguments: appointment);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 7),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: PremiumColors.line),
          boxShadow: PremiumColors.softShadow(0.07),
        ),
        child: Column(
          children: [
            Row(
              children: [
                PremiumAvatar(
                  initials: premiumInitials(appointment.doctorName),
                  size: 52,
                ),
                const SizedBox(width: 14),
                Expanded(child: _buildAppointmentInfo()),
                const SizedBox(width: 10),
                _buildDetailsButton(),
              ],
            ),
            const SizedBox(height: 14),
            Container(height: 1, color: PremiumColors.line),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Wrap(
                    spacing: 14,
                    runSpacing: 6,
                    children: [
                      _meta(Icons.calendar_today_rounded,
                          _formatDate(appointment.date)),
                      _meta(Icons.access_time_rounded, appointment.time),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                _buildChatButton(context),
              ],
            ),
          ],
        ),
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
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.1,
            color: PremiumColors.ink,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          appointment.specialty,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 13,
            color: PremiumColors.muted,
          ),
        ),
      ],
    );
  }

  Widget _meta(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: PremiumColors.navy600),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
            color: PremiumColors.ink,
          ),
        ),
      ],
    );
  }

  // Decorative only: the whole card is already tappable.
  Widget _buildDetailsButton() {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: PremiumColors.navy800.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 14,
        color: PremiumColors.navy700,
      ),
    );
  }

  Widget _buildChatButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final patientId = FirebaseAuth.instance.currentUser?.uid;
        if (patientId == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please log in to chat')),
          );
          return;
        }
        final doctorId = appointment.doctorId; // <-- make sure this field exists
        if (doctorId == null || doctorId.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Doctor information missing')),
          );
          return;
        }
        final chatId = _getChatId(patientId, doctorId);
        await FirebaseFirestore.instance.collection('chats').doc(chatId).set({
          'participants': [patientId, doctorId],
          'lastMessage': '',
          'timestamp': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatDetailScreen(
              doctorId: doctorId,
              doctorName: appointment.doctorName,
              chatId: chatId,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          gradient: PremiumColors.navyGradient,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              color: PremiumColors.navy800.withValues(alpha: 0.28),
              blurRadius: 12,
              offset: const Offset(0, 5),
              spreadRadius: -2,
            ),
          ],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.chat_bubble_outline_rounded,
                size: 14, color: PremiumColors.accent),
            SizedBox(width: 7),
            Text(
              'Message',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('d MMM yyyy').format(date);
    } catch (_) {
      return dateStr;
    }
  }
}

String _getChatId(String a, String b) =>
    a.compareTo(b) < 0 ? '$a-$b' : '$b-$a';
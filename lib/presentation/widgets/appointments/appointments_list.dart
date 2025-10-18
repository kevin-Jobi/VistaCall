// import 'package:flutter/material.dart';
// import 'package:vistacall/bloc/appointments/appointments_state.dart';
// import 'package:vistacall/presentation/widgets/appointments/appointment_card.dart';
// import 'package:vistacall/viewmodels/appointments_viewmodel.dart';

// class AppointmentsList extends StatelessWidget {
//   final AppointmentsViewModel viewModel;
//   final AppointmentsLoadedState state;

//   const AppointmentsList({
//     super.key,
//     required this.viewModel,
//     required this.state,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final appointments = viewModel.getFilteredAppointments(state);

//     return appointments.isEmpty
//         ? _buildEmptyState(context)
//         : ListView.builder(
//             physics: const BouncingScrollPhysics(),
//             padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
//             itemCount: appointments.length,
//             itemBuilder: (context, index) {
//               return TweenAnimationBuilder<double>(
//                 duration: Duration(milliseconds: 300 + (index * 100)),
//                 tween: Tween(begin: 0, end: 1),
//                 builder: (context, value, child) {
//                   return Transform.translate(
//                     offset: Offset(0, 30 * (1 - value)),
//                     child: Opacity(
//                       opacity: value,
//                       child: AppointmentCard(
//                         appointment: appointments[index],
//                         viewModel: viewModel,
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//   }

//   Widget _buildEmptyState(BuildContext context) {
//     final isUpcoming = state.showUpcoming;

//     return Center(
//       child: Container(
//         margin: const EdgeInsets.all(32),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 120,
//               height: 120,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade100,
//                 borderRadius: BorderRadius.circular(60),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 20,
//                     offset: const Offset(0, 10),
//                   ),
//                 ],
//               ),
//               child: Icon(
//                 isUpcoming ? Icons.calendar_month : Icons.history,
//                 size: 50,
//                 color: Colors.grey.shade400,
//               ),
//             ),
//             const SizedBox(height: 24),
//             Text(
//               isUpcoming ? 'No Upcoming Appointments' : 'No Past Appointments',
//               style: const TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.black87,
//               ),
//             ),
//             const SizedBox(height: 12),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Text(
//                 isUpcoming
//                     ? 'When you schedule appointments, they\'ll appear here'
//                     : 'Your completed appointments will show up here',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.grey.shade600,
//                   height: 1.4,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             if (isUpcoming) ...[
//               const SizedBox(height: 32),
//               ElevatedButton.icon(
//                 onPressed: () {
//                   // Navigate to booking screen
//                 },
//                 icon: const Icon(Icons.add, size: 18),
//                 label: const Text(
//                   'Book Appointment',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue.shade600,
//                   foregroundColor: Colors.white,
//                   elevation: 0,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 24,
//                     vertical: 12,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }



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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final appointments = viewModel.getFilteredAppointments(state);

    return appointments.isEmpty
        ? _buildEmptyState(context, theme, colorScheme)
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              return TweenAnimationBuilder<double>(
                duration: Duration(milliseconds: 300 + (index * 100)),
                tween: Tween(begin: 0, end: 1),
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset(0, 30 * (1 - value)),
                    child: Opacity(
                      opacity: value,
                      child: AppointmentCard(
                        appointment: appointments[index],
                        viewModel: viewModel,
                      ),
                    ),
                  );
                },
              );
            },
          );
  }

  Widget _buildEmptyState(
    BuildContext context, 
    ThemeData theme, 
    ColorScheme colorScheme
  ) {
    final isUpcoming = state.showUpcoming;
    final onSurface = colorScheme.onSurface;
    final onSurfaceVariant = colorScheme.onSurfaceVariant ?? Colors.grey.shade600;
    final surfaceContainer = colorScheme.surfaceVariant.withOpacity(0.3);
    final shadowColor = theme.shadowColor;

    return Center(
      child: Container(
        margin: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: surfaceContainer, // Dynamic light grey
                borderRadius: BorderRadius.circular(60),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor, // Dynamic shadow
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(
                isUpcoming ? Icons.calendar_month : Icons.history,
                size: 50,
                color: onSurfaceVariant, // Dynamic grey icon
              ),
            ),
            const SizedBox(height: 24),
            Text(
              isUpcoming ? 'No Upcoming Appointments' : 'No Past Appointments',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: onSurface, // Dynamic dark text
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                isUpcoming
                    ? 'When you schedule appointments, they\'ll appear here'
                    : 'Your completed appointments will show up here',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: onSurfaceVariant, // Dynamic grey text
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (isUpcoming) ...[
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  // Navigate to booking screen
                },
                icon: const Icon(Icons.add, size: 18),
                label: Text(
                  'Book Appointment',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onPrimary,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary, // Dynamic primary
                  foregroundColor: colorScheme.onPrimary, // Dynamic white text
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:vistacall/bloc/appointments/appointments_state.dart';
// import 'package:vistacall/utils/constants.dart';
// import 'package:vistacall/viewmodels/appointments_viewmodel.dart';

// class ToggleButtons extends StatelessWidget {
//   final AppointmentsViewModel viewModel;
//   final AppointmentsLoadedState state;

//   const ToggleButtons({
//     super.key,
//     required this.viewModel,
//     required this.state,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade100,
//         borderRadius: BorderRadius.circular(30),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(4),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             _buildToggleButton(
//               context: context,
//               text: 'Upcoming',
//               icon: Icons.schedule,
//               isSelected: state.showUpcoming,
//               onTap: () => viewModel.toggleAppointmentsView(true),
//             ),
//             _buildToggleButton(
//               context: context,
//               text: 'Past',
//               icon: Icons.history,
//               isSelected: !state.showUpcoming,
//               onTap: () => viewModel.toggleAppointmentsView(false),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildToggleButton({
//     required BuildContext context,
//     required String text,
//     required IconData icon,
//     required bool isSelected,
//     required VoidCallback onTap,
//   }) {
//     return TweenAnimationBuilder<double>(
//       duration: const Duration(milliseconds: 200),
//       tween: Tween(begin: 0, end: isSelected ? 1 : 0),
//       builder: (context, value, child) {
//         return GestureDetector(
//           onTap: onTap,
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 200),
//             curve: Curves.easeInOut,
//             width: 140,
//             padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//             decoration: BoxDecoration(
//               color: isSelected ? AppConstants.primaryColor : Colors.transparent,
//               borderRadius: BorderRadius.circular(26),
//               boxShadow: isSelected
//                   ? [
//                       BoxShadow(
//                         color: AppConstants.primaryColor.withOpacity(0.3),
//                         blurRadius: 8,
//                         offset: const Offset(0, 4),
//                       ),
//                     ]
//                   : [],
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 AnimatedScale(
//                   scale: isSelected ? 1.0 : 0.9,
//                   duration: const Duration(milliseconds: 200),
//                   child: Icon(
//                     icon,
//                     size: 18,
//                     color: isSelected ? Colors.white : Colors.grey.shade600,
//                   ),
//                 ),
//                 const SizedBox(width: 6),
//                 AnimatedDefaultTextStyle(
//                   duration: const Duration(milliseconds: 200),
//                   style: TextStyle(
//                     color: isSelected ? Colors.white : Colors.grey.shade700,
//                     fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
//                     fontSize: 14,
//                   ),
//                   child: Text(text),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:vistacall/bloc/appointments/appointments_state.dart';
import 'package:vistacall/viewmodels/appointments_viewmodel.dart';

class ToggleButtons extends StatelessWidget {
  final AppointmentsViewModel viewModel;
  final AppointmentsLoadedState state;

  const ToggleButtons({
    super.key,
    required this.viewModel,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Light grey background equivalent
    final lightGreyContainer =
        colorScheme.surfaceVariant.withValues(alpha: 0.3);
    final shadowColor = colorScheme.onPrimary;

    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: lightGreyContainer, // Dynamic light grey
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: shadowColor, // Dynamic shadow
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildToggleButton(
              context: context,
              text: 'Upcoming',
              icon: Icons.schedule,
              isSelected: state.showUpcoming,
              onTap: () => viewModel.toggleAppointmentsView(true),
            ),
            _buildToggleButton(
              context: context,
              text: 'Past',
              icon: Icons.history,
              isSelected: !state.showUpcoming,
              onTap: () => viewModel.toggleAppointmentsView(false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton({
    required BuildContext context,
    required String text,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final onPrimary = colorScheme.onPrimary; // White text on primary
    // final onSurfaceVariant = colorScheme.onSurfaceVariant ?? Colors.grey.shade600;
    final onSurfaceVariant = colorScheme.onSurfaceVariant; // Dynamic grey text

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 200),
      tween: Tween(begin: 0, end: isSelected ? 1 : 0),
      builder: (context, value, child) {
        return GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            width: 140,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: isSelected
                  ? colorScheme.primary
                  : const Color.fromARGB(0, 245, 244, 244), // Dynamic primary
              borderRadius: BorderRadius.circular(26),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: colorScheme.primary
                            .withValues(alpha: 0.3), // Dynamic primary shadow
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedScale(
                  scale: isSelected ? 1.0 : 0.9,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    icon,
                    size: 18,
                    color: isSelected
                        ? onPrimary
                        : onSurfaceVariant, // Dynamic colors
                  ),
                ),
                const SizedBox(width: 6),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: theme.textTheme.labelLarge?.copyWith(
                        color: isSelected
                            ? onPrimary
                            : onSurfaceVariant, // Dynamic text colors
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w600,
                        fontSize: 14,
                      ) ??
                      TextStyle(
                        color: isSelected ? onPrimary : onSurfaceVariant,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w600,
                        fontSize: 14,
                      ),
                  child: Text(text),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// import 'package:flutter/material.dart' hide ToggleButtons;
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vistacall/bloc/appointments/appointments_bloc.dart';
// import 'package:vistacall/bloc/appointments/appointments_state.dart';
// import 'package:vistacall/presentation/widgets/appointments/appointments_app_bar.dart';
// import 'package:vistacall/presentation/widgets/appointments/appointments_list.dart';
// import 'package:vistacall/presentation/widgets/appointments/toggle_buttons.dart';
// import 'package:vistacall/presentation/widgets/custom_bottom_navbar.dart';
// import 'package:vistacall/utils/constants.dart';
// import 'package:vistacall/viewmodels/appointments_viewmodel.dart';

// class AppointmentsScreen extends StatelessWidget {
//   const AppointmentsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final viewModel = AppointmentsViewModel(
//       BlocProvider.of<AppointmentsBloc>(context),
//     )..loadAppointments();

//     return Scaffold(
//       backgroundColor: Colors.grey.shade50,
//       appBar: const AppointmentsAppBar(),
//       body: StreamBuilder<AppointmentsState>(
//         stream: viewModel.appointmentsState,
//         builder: (context, snapshot) {
//           final state = snapshot.data;

//           if (state == null || state is AppointmentsLoadingState) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.05),
//                           blurRadius: 10,
//                           offset: const Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: const CircularProgressIndicator(
//                       strokeWidth: 3,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     'Loading appointments...',
//                     style: TextStyle(
//                       color: Colors.grey.shade600,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }

//           if (state is AppointmentsErrorState) {
//             return Center(
//               child: Container(
//                 margin: const EdgeInsets.all(24),
//                 padding: const EdgeInsets.all(24),
//                 decoration: BoxDecoration(
//                   color: Colors.red.shade50,
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(color: Colors.red.shade100),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(
//                       Icons.error_outline,
//                       color: Colors.red.shade400,
//                       size: 48,
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       'Something went wrong',
//                       style: TextStyle(
//                         color: Colors.red.shade700,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       state.error,
//                       style: TextStyle(
//                         color: Colors.red.shade600,
//                         fontSize: 14,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }

//           if (state is AppointmentsLoadedState) {
//             return Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Colors.white,
//                     Colors.grey.shade50,
//                   ],
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   Container(
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Color(0x0F000000),
//                           blurRadius: 4,
//                           offset: Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: ToggleButtons(viewModel: viewModel, state: state),
//                   ),
//                   Expanded(
//                     child: AppointmentsList(viewModel: viewModel, state: state),
//                   ),
//                 ],
//               ),
//             );
//           }

//           return const SizedBox.shrink();
//         },
//       ),
//       bottomNavigationBar: CustomBottomNavBar(
//         currentIndex: 1,
//         onTap: (index) => _handleNavigation(index, context),
//       ),
//     );
//   }

//   void _handleNavigation(int index, BuildContext context) {
//     if (index == 0) {
//       Navigator.pushReplacementNamed(context, AppConstants.homeRoute);
//     } else if (index == 2) {
//       Navigator.pushReplacementNamed(context, AppConstants.messagesRoute);
//     } else if (index == 3) {
//       Navigator.pushReplacementNamed(context, AppConstants.profileRoute);
//     }
//     // index 1 is current screen (appointments), so no navigation needed
//   }
// }

import 'package:flutter/material.dart' hide ToggleButtons;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/appointments/appointments_bloc.dart';
import 'package:vistacall/bloc/appointments/appointments_state.dart';
import 'package:vistacall/presentation/widgets/appointments/appointments_app_bar.dart';
import 'package:vistacall/presentation/widgets/appointments/appointments_list.dart';
import 'package:vistacall/presentation/widgets/appointments/toggle_buttons.dart';
import 'package:vistacall/presentation/widgets/custom_bottom_navbar.dart';
import 'package:vistacall/utils/constants.dart';
import 'package:vistacall/viewmodels/appointments_viewmodel.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final viewModel = AppointmentsViewModel(
      BlocProvider.of<AppointmentsBloc>(context),
    )..loadAppointments();

    return Scaffold(
      // backgroundColor: lightGreyBackground, // Dynamic light grey
      appBar: const AppointmentsAppBar(),
      body: StreamBuilder<AppointmentsState>(
        stream: viewModel.appointmentsState,
        builder: (context, snapshot) {
          final state = snapshot.data;

          if (state == null || state is AppointmentsLoadingState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: colorScheme.surface, // Dynamic white surface
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.surface, // Dynamic shadow
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(colorScheme.primary),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Loading appointments...',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant, // Dynamic grey
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is AppointmentsErrorState) {
            return Center(
              child: Container(
                margin: const EdgeInsets.all(24),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: colorScheme.errorContainer, // Dynamic error container
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: colorScheme.error
                          .withValues(alpha: 0.2)), // Dynamic error border
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: colorScheme.error, // Dynamic error color
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Something went wrong',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: colorScheme.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.error,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.error,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is AppointmentsLoadedState) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    colorScheme.surface, // Dynamic white
                    colorScheme.surface, // Dynamic light grey gradient
                  ],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: colorScheme.surface, // Dynamic white
                      boxShadow: [
                        BoxShadow(
                          color: theme.shadowColor.withValues(
                              alpha:
                                  0.1), // Dynamic shadow (0x0F000000 equivalent)
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ToggleButtons(viewModel: viewModel, state: state),
                  ),
                  Expanded(
                    child: AppointmentsList(viewModel: viewModel, state: state),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
        onTap: (index) => _handleNavigation(index, context),
      ),
    );
  }

  void _handleNavigation(int index, BuildContext context) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, AppConstants.homeRoute);
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, AppConstants.messagesRoute);
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, AppConstants.profileRoute);
    }
    // index 1 is current screen (appointments), so no navigation needed
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vistacall/bloc/appointments/appointments_bloc.dart';
// import 'package:vistacall/bloc/appointments/appointments_event.dart';
// import 'package:vistacall/bloc/appointments/appointments_state.dart';
// import 'package:vistacall/utils/constants.dart';

// class AppointmentsScreen extends StatelessWidget {
//   const AppointmentsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final appointmentsBloc = BlocProvider.of<AppointmentsBloc>(context);
//     appointmentsBloc.add(LoadAppointmentsEvent());

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppConstants.primaryColor,
//         title: const Text('Appointments'),
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(20),
//             bottomRight: Radius.circular(20),
//           ),
//         ),
//       ),
//       body: BlocBuilder<AppointmentsBloc, AppointmentsState>(
//         builder: (context, state) {
//           if (state is AppointmentsLoadingState) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is AppointmentsErrorState) {
//             return Center(child: Text(state.error));
//           } else if (state is AppointmentsLoadedState) {
//             final appointments = state.showUpcoming ? state.upcomingAppointments : state.pastAppointments;

//             return Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       _buildToggleButton(
//                         text: 'Upcoming',
//                         isSelected: state.showUpcoming,
//                         onTap: () {
//                           appointmentsBloc.add(ToggleAppointmentsEvent(true));
//                         },
//                       ),
//                       _buildToggleButton(
//                         text: 'Past',
//                         isSelected: !state.showUpcoming,
//                         onTap: () {
//                           appointmentsBloc.add(ToggleAppointmentsEvent(false));
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: appointments.isEmpty
//                       ? const Center(child: Text('No appointments found'))
//                       : ListView.builder(
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           itemCount: appointments.length,
//                           itemBuilder: (context, index) {
//                             final appointment = appointments[index];
//                             return Card(
//                               elevation: 2,
//                               margin: const EdgeInsets.only(bottom: 16),
//                               child: ListTile(
//                                 leading: const CircleAvatar(
//                                   backgroundColor: Colors.grey,
//                                   child: Icon(Icons.person, color: Colors.white),
//                                 ),
//                                 title: Text(
//                                   appointment.doctorName,
//                                   style: const TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 subtitle: Text(
//                                   '${appointment.specialty}\n${appointment.date} - ${appointment.time}',
//                                 ),
//                                 trailing: Container(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 10,
//                                     vertical: 5,
//                                   ),
//                                   color: appointment.status == 'Confirmed'
//                                       ? Colors.green
//                                       : appointment.status == 'Canceled'
//                                           ? Colors.red
//                                           : Colors.grey,
//                                   child: Text(
//                                     appointment.status,
//                                     style: const TextStyle(color: Colors.white),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                 ),
//               ],
//             );
//           }
//           return const SizedBox.shrink();
//         },
//       ),
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: AppConstants.backgroundColor,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 10,
//               offset: const Offset(0, -2),
//             ),
//           ],
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: BottomNavigationBar(
//           currentIndex: 1,
//           selectedItemColor: AppConstants.primaryColor,
//           unselectedItemColor: Colors.grey.shade500,
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           type: BottomNavigationBarType.fixed,
//           selectedLabelStyle: const TextStyle(
//             fontWeight: FontWeight.w600,
//             fontSize: 12,
//           ),
//           unselectedLabelStyle: const TextStyle(
//             fontWeight: FontWeight.w400,
//             fontSize: 12,
//           ),
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               activeIcon: Icon(Icons.home, size: 28),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.calendar_today),
//               activeIcon: Icon(Icons.calendar_today, size: 28),
//               label: 'Appointment',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.chat),
//               activeIcon: Icon(Icons.chat, size: 28),
//               label: 'Messages',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person),
//               activeIcon: Icon(Icons.person, size: 28),
//               label: 'Profile',
//             ),
//           ],
//           onTap: (index) {
//             if (index == 0) {
//               Navigator.pushReplacementNamed(context, AppConstants.homeRoute);
//             } else if (index == 2) {
//               Navigator.pushReplacementNamed(context, AppConstants.messagesRoute);
//             } else if (index == 3) {
//               Navigator.pushReplacementNamed(context, AppConstants.profileRoute);
//             }
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildToggleButton({
//     required String text,
//     required bool isSelected,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 120,
//         padding: const EdgeInsets.symmetric(vertical: 10),
//         decoration: BoxDecoration(
//           color: isSelected ? AppConstants.primaryColor : Colors.grey.shade200,
//           borderRadius: BorderRadius.horizontal(
//             left: text == 'Upcoming' ? const Radius.circular(20) : Radius.zero,
//             right: text == 'Past' ? const Radius.circular(20) : Radius.zero,
//           ),
//         ),
//         child: Center(
//           child: Text(
//             text,
//             style: TextStyle(
//               color: isSelected ? Colors.white : Colors.black54,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//       ),
//     );
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
    final viewModel = AppointmentsViewModel(
      BlocProvider.of<AppointmentsBloc>(context),
    )..loadAppointments();

    return Scaffold(
      appBar: const AppointmentsAppBar(),
      body: StreamBuilder<AppointmentsState>(
        stream: viewModel.appointmentsState,
        builder: (context, snapshot) {
          final state = snapshot.data;
          if (state == null || state is AppointmentsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AppointmentsErrorState) {
            return Center(child: Text(state.error));
          }
          if (state is AppointmentsLoadedState) {
            return Column(
              children: [
                ToggleButtons(viewModel: viewModel, state: state),
                AppointmentsList(viewModel: viewModel, state: state),
              ],
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

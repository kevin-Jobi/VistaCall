// import 'package:flutter/material.dart';

// // Dummy Appointment Model (since we don't have a backend yet)
// class Appointment {
//   final String doctorName;
//   final String specialty;
//   final String date;
//   final String time;
//   final String status;

//   Appointment({
//     required this.doctorName,
//     required this.specialty,
//     required this.date,
//     required this.time,
//     required this.status,
//   });
// }

// class AppointmentsScreen extends StatefulWidget {
//   const AppointmentsScreen({super.key});

//   @override
//   State<AppointmentsScreen> createState() => _AppointmentsScreenState();
// }

// class _AppointmentsScreenState extends State<AppointmentsScreen> {
//   bool _showUpcoming = true;

//   // Dummy data for appointments
//   final List<Appointment> upcomingAppointments = [
//     Appointment(
//       doctorName: 'Dr. John Smith',
//       specialty: 'Cardiologist',
//       date: '20 May 2025',
//       time: '10:00 AM',
//       status: 'Confirmed',
//     ),
//     Appointment(
//       doctorName: 'Dr. Emily Johnson',
//       specialty: 'Dermatologist',
//       date: '22 May 2025',
//       time: '02:00 PM',
//       status: 'Confirmed',
//     ),
//   ];

//   final List<Appointment> pastAppointments = [
//     Appointment(
//       doctorName: 'Dr. Sarah Davis',
//       specialty: 'Neurologist',
//       date: '15 May 2025',
//       time: '11:00 AM',
//       status: 'Canceled',
//     ),
//     Appointment(
//       doctorName: 'Dr. Michael Brown',
//       specialty: 'Pediatrician',
//       date: '10 May 2025',
//       time: '09:00 AM',
//       status: 'Completed',
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final appointments = _showUpcoming ? upcomingAppointments : pastAppointments;

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF4A90E2), // Blue
//         title: const Text('Appointments'),
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(20),
//             bottomRight: Radius.circular(20),
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           // Segmented Control for Upcoming/Past
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 _buildToggleButton(
//                   text: 'Upcoming',
//                   isSelected: _showUpcoming,
//                   onTap: () {
//                     setState(() {
//                       _showUpcoming = true;
//                     });
//                   },
//                 ),
//                 _buildToggleButton(
//                   text: 'Past',
//                   isSelected: !_showUpcoming,
//                   onTap: () {
//                     setState(() {
//                       _showUpcoming = false;
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//           // Appointments List
//           Expanded(
//             child: appointments.isEmpty
//                 ? const Center(child: Text('No appointments found'))
//                 : ListView.builder(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     itemCount: appointments.length,
//                     itemBuilder: (context, index) {
//                       final appointment = appointments[index];
//                       return Card(
//                         elevation: 2,
//                         margin: const EdgeInsets.only(bottom: 16),
//                         child: ListTile(
//                           leading: const CircleAvatar(
//                             backgroundColor: Colors.grey,
//                             child: Icon(Icons.person, color: Colors.white),
//                           ),
//                           title: Text(
//                             appointment.doctorName,
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           subtitle: Text(
//                             '${appointment.specialty}\n${appointment.date} - ${appointment.time}',
//                           ),
//                           trailing: Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 10,
//                               vertical: 5,
//                             ),
//                             color: appointment.status == 'Confirmed'
//                                 ? Colors.green
//                                 : appointment.status == 'Canceled'
//                                     ? Colors.red
//                                     : Colors.grey,
//                             child: Text(
//                               appointment.status,
//                               style: const TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
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
//           currentIndex: 1, // Appointments tab selected
//           selectedItemColor: const Color(0xFF4A90E2), // Blue
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
//               Navigator.pushReplacementNamed(context, '/home');
//             } else if (index == 2) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Messages feature coming soon!')),
//               );
//             } else if (index == 3) {
//               Navigator.pushReplacementNamed(context, '/profile');
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
//         width: 120, // Fixed width to ensure both buttons are the same size
//         padding: const EdgeInsets.symmetric(vertical: 10),
//         decoration: BoxDecoration(
//           color: isSelected ? const Color(0xFF4A90E2) : Colors.grey.shade200,
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


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/viewmodels/appointments_bloc.dart';
import 'package:vistacall/utils/constants.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appointmentsBloc = BlocProvider.of<AppointmentsBloc>(context);
    appointmentsBloc.add(LoadAppointmentsEvent());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        title: const Text('Appointments'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: BlocBuilder<AppointmentsBloc, AppointmentsState>(
        builder: (context, state) {
          if (state is AppointmentsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AppointmentsErrorState) {
            return Center(child: Text(state.error));
          } else if (state is AppointmentsLoadedState) {
            final appointments = state.showUpcoming ? state.upcomingAppointments : state.pastAppointments;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildToggleButton(
                        text: 'Upcoming',
                        isSelected: state.showUpcoming,
                        onTap: () {
                          appointmentsBloc.add(ToggleAppointmentsEvent(true));
                        },
                      ),
                      _buildToggleButton(
                        text: 'Past',
                        isSelected: !state.showUpcoming,
                        onTap: () {
                          appointmentsBloc.add(ToggleAppointmentsEvent(false));
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: appointments.isEmpty
                      ? const Center(child: Text('No appointments found'))
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: appointments.length,
                          itemBuilder: (context, index) {
                            final appointment = appointments[index];
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
                                  '${appointment.specialty}\n${appointment.date} - ${appointment.time}',
                                ),
                                trailing: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  color: appointment.status == 'Confirmed'
                                      ? Colors.green
                                      : appointment.status == 'Canceled'
                                          ? Colors.red
                                          : Colors.grey,
                                  child: Text(
                                    appointment.status,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppConstants.backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: 1,
          selectedItemColor: AppConstants.primaryColor,
          unselectedItemColor: Colors.grey.shade500,
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              activeIcon: Icon(Icons.home, size: 28),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              activeIcon: Icon(Icons.calendar_today, size: 28),
              label: 'Appointment',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              activeIcon: Icon(Icons.chat, size: 28),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              activeIcon: Icon(Icons.person, size: 28),
              label: 'Profile',
            ),
          ],
          onTap: (index) {
            if (index == 0) {
              Navigator.pushReplacementNamed(context, AppConstants.homeRoute);
            } else if (index == 2) {
              Navigator.pushReplacementNamed(context, AppConstants.messagesRoute);
            } else if (index == 3) {
              Navigator.pushReplacementNamed(context, AppConstants.profileRoute);
            }
          },
        ),
      ),
    );
  }

  Widget _buildToggleButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppConstants.primaryColor : Colors.grey.shade200,
          borderRadius: BorderRadius.horizontal(
            left: text == 'Upcoming' ? const Radius.circular(20) : Radius.zero,
            right: text == 'Past' ? const Radius.circular(20) : Radius.zero,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/appointments/appointments_event.dart';
import 'package:vistacall/bloc/appointments/appointments_state.dart';
import 'package:vistacall/data/models/appointment.dart';

class AppointmentsBloc extends Bloc<AppointmentsEvent, AppointmentsState> {
  AppointmentsBloc() : super(AppointmentsLoadingState()) {
    on<LoadAppointmentsEvent>(_onLoadAppointments
        //   (event, emit) async {
        //   emit(AppointmentsLoadingState());
        //   try {
        //     // Simulate fetching upcoming appointments
        //     final List<Appointment> upcomingAppointments = [
        //       Appointment(
        //         doctorName: 'Dr. John Smith',
        //         specialty: 'Cardiologist',
        //         date: '22 May 2025',
        //         time: '10:00 AM',
        //         status: 'Confirmed',
        //       ),
        //       Appointment(
        //         doctorName: 'Dr. Emily Johnson',
        //         specialty: 'Dermatologist',
        //         date: '25 May 2025',
        //         time: '02:00 PM',
        //         status: 'Confirmed',
        //       ),
        //     ];

        //     // Simulate fetching past appointments
        //     final List<Appointment> pastAppointments = [
        //       Appointment(
        //         doctorName: 'Dr. Sarah Davis',
        //         specialty: 'Neurologist',
        //         date: '15 May 2025',
        //         time: '11:00 AM',
        //         status: 'Canceled',
        //       ),
        //       Appointment(
        //         doctorName: 'Dr. Michael Brown',
        //         specialty: 'Pediatrician',
        //         date: '10 May 2025',
        //         time: '09:00 AM',
        //         status: 'Completed',
        //       ),
        //     ];

        //     emit(
        //       AppointmentsLoadedState(
        //         upcomingAppointments: upcomingAppointments,
        //         pastAppointments: pastAppointments,
        //         showUpcoming: true,
        //       ),
        //     );
        //   } catch (e) {
        //     emit(AppointmentsErrorState('Failed to load appointments: $e'));
        //   }
        // }
        );

    on<ToggleAppointmentsEvent>(
      _onToggleAppointments
        //   (event, emit) async {
        //   if (state is AppointmentsLoadedState) {
        //     final currentState = state as AppointmentsLoadedState;
        //     emit(
        //       AppointmentsLoadedState(
        //         upcomingAppointments: currentState.upcomingAppointments,
        //         pastAppointments: currentState.pastAppointments,
        //         showUpcoming: event.showUpcoming,
        //       ),
        //     );
        //   }
        // }

        );
  }
  Future<void> _onLoadAppointments(
      LoadAppointmentsEvent event, Emitter<AppointmentsState> emit) async {
    emit(AppointmentsLoadingState());
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(AppointmentsErrorState('Not authenticated'));
        return;
      }

      final db = FirebaseFirestore.instance;
      final allBookings = await db
          .collectionGroup('bookings')
          .where('userId', isEqualTo: user.uid)
          .orderBy('CreatedAt', descending: true)
          .get();

      final List<Appointment> appointments = allBookings.docs.map((doc) {
        final data = doc.data();
        final parentDoc = doc.reference.parent.parent!.id;
        return Appointment(
            id: doc.id,
            doctorName: data['userName'] ?? 'Unknown Doctor',
            specialty: 'Unknown specialty',
            date: data['date'],
            time: data['slot'],
            status: data['status'] ?? 'Pending',
            patientName: data['userName']);
      }).toList();

      final now = DateTime.now();
      final upcoming = appointments
          .where((app) => DateTime.parse(app.date).isAfter(now))
          .toList();
      final past = appointments
          .where((app) => DateTime.parse(app.date).isBefore(now))
          .toList();

      emit(AppointmentsLoadedState(
        upcomingAppointments: upcoming,
        pastAppointments: past,
        showUpcoming: true,
      ));
    } catch (e) {
      emit(AppointmentsErrorState('Failed to load appointments: $e'));
    }
  }

  void _onToggleAppointments(
      ToggleAppointmentsEvent event, Emitter<AppointmentsState> emit) {
    if (state is AppointmentsLoadedState) {
      final currentState = state as AppointmentsLoadedState;
      emit(AppointmentsLoadedState(
        upcomingAppointments: currentState.upcomingAppointments,
        pastAppointments: currentState.pastAppointments,
        showUpcoming: event.showUpcoming,
      ));
    }
  }
}




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/appointments/appointments_event.dart';
import 'package:vistacall/bloc/appointments/appointments_state.dart';
import 'package:vistacall/data/models/appointment.dart';
import 'package:intl/intl.dart';

class AppointmentsBloc extends Bloc<AppointmentsEvent, AppointmentsState> {
  AppointmentsBloc() : super(AppointmentsLoadingState()) {
    on<LoadAppointmentsEvent>(_onLoadAppointments);
    on<ToggleAppointmentsEvent>(_onToggleAppointments);
  }

  Future<void> _onLoadAppointments(
      LoadAppointmentsEvent event, Emitter<AppointmentsState> emit) async {
    emit(AppointmentsLoadingState());
    try {
      final user = FirebaseAuth.instance.currentUser;
      print('Current User: $user'); // Debug: Check authentication
      if (user == null) {
        emit(AppointmentsErrorState('User not authenticated'));
        return;
      }

      final db = FirebaseFirestore.instance;
      print('Querying bookings for userId: ${user.uid}'); // Debug: Log user ID

      final allBookings = await db
          .collectionGroup('bookings')
          .where('userId', isEqualTo: user.uid)
          .orderBy('createdAt', descending: true)
          .get();

      print('Found ${allBookings.docs.length} booking documents');
      if (allBookings.docs.isEmpty) {
        print('No bookings found for userId: ${user.uid}');
        emit(AppointmentsLoadedState(
          upcomingAppointments: [],
          pastAppointments: [],
          showUpcoming: true,
        ));
        return;
      }

      final List<Appointment> appointments =
          await Future.wait(allBookings.docs.map((doc) async {
        final data = doc.data();
        final parentDocRef = doc.reference.parent.parent; // Refers to doctors/{doctorId}
        print('Document ID: ${doc.id}, Parent Doc: ${parentDocRef?.id}, Data: $data');

        if (data == null ||
            !data.containsKey('date') ||
            !data.containsKey('slot')) {
          print('Skipping document ${doc.id} due to missing required fields');
          return Appointment(
            id: doc.id,
            doctorId: parentDocRef?.id ?? 'unknown',
            doctorName: 'Unknown Doctor',
            specialty: 'Unknown specialty',
            date: '',
            time: '',
            status: 'Pending',
            patientName: 'Unknown Patient',
            reviewed: false,
            paymentMethod: data['paymentMethod'],
            paymentStatus: data['paymentStatus'],
          );
        }

        String doctorName = 'Unknown Doctor';
        String speciality = 'Unknown specialty';
        if (parentDocRef != null) {
          final doctorDoc = await parentDocRef.get();
          if (doctorDoc.exists) {
            final doctorData = doctorDoc.data();
            print('Doctor Data for ${parentDocRef.id}: $doctorData');
            final personalData = doctorData?['personal'] as Map<String, dynamic>?;
            doctorName = personalData?['fullName'] ?? 'Unknown Doctor';
            speciality = personalData?['department'] ?? 'Unknown specialty';
          } else {
            print('Doctor document not found for ${parentDocRef.id}');
          }
        } else {
          print('Parent document reference is null for ${doc.id}');
        }

        return Appointment(
          id: doc.id,
          doctorId: parentDocRef?.id ?? 'unknown',
          doctorName: doctorName,
          specialty: speciality,
          date: data['date'] ?? '',
          time: data['slot'] ?? '',
          status: data['status'] ?? 'Pending',
          patientName: data['userName'] ?? 'Unknown Patient',
          reviewed: data['reviewed'] ?? false,
          paymentMethod: data['paymentMethod'],
          paymentStatus: data['paymentStatus'],
        );
      }));

      final now = DateTime.now();
      print('Current time for filtering: $now');
      final upcoming = appointments.where((app) {
        try {
          final appointmentDate = DateFormat('yyyy-MM-dd').parse(app.date);
          print('Parsing date: ${app.date} -> $appointmentDate');
          return appointmentDate.isAfter(now);
        } catch (e) {
          print('Error parsing date ${app.date}: $e');
          return false;
        }
      }).toList();
      final past = appointments.where((app) {
        try {
          final appointmentDate = DateFormat('yyyy-MM-dd').parse(app.date);
          return appointmentDate.isBefore(now);
        } catch (e) {
          print('Error parsing date ${app.date}: $e');
          return false;
        }
      }).toList();

      print('Upcoming appointments: ${upcoming.length}, Past appointments: ${past.length}');
      emit(AppointmentsLoadedState(
        upcomingAppointments: upcoming,
        pastAppointments: past,
        showUpcoming: true,
      ));
    } catch (e, stackTrace) {
      print('Exception in _onLoadAppointments: $e\nStack Trace: $stackTrace');
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
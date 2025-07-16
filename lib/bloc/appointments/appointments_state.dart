import 'package:vistacall/data/models/appointment.dart';

abstract class AppointmentsState {}

class AppointmentsLoadingState extends AppointmentsState {}

class AppointmentsLoadedState extends AppointmentsState {
  final List<Appointment> upcomingAppointments;
  final List<Appointment> pastAppointments;
  final bool showUpcoming;

  AppointmentsLoadedState({
    required this.upcomingAppointments,
    required this.pastAppointments,
    required this.showUpcoming,
  });
}

class AppointmentsErrorState extends AppointmentsState {
  final String error;

  AppointmentsErrorState(this.error);
}
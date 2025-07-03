import 'package:bloc/bloc.dart';
import 'package:vistacall/data/models/appointment.dart';

abstract class AppointmentsEvent {}

class LoadAppointmentsEvent extends AppointmentsEvent {}

class ToggleAppointmentsEvent extends AppointmentsEvent {
  final bool showUpcoming;

  ToggleAppointmentsEvent(this.showUpcoming);
}

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

class AppointmentsBloc extends Bloc<AppointmentsEvent, AppointmentsState> {
  AppointmentsBloc() : super(AppointmentsLoadingState()) {
    on<LoadAppointmentsEvent>((event, emit) async {
      emit(AppointmentsLoadingState());
      try {
        // Simulate fetching upcoming appointments
        final List<Appointment> upcomingAppointments = [
          Appointment(
            doctorName: 'Dr. John Smith',
            specialty: 'Cardiologist',
            date: '22 May 2025',
            time: '10:00 AM',
            status: 'Confirmed',
          ),
          Appointment(
            doctorName: 'Dr. Emily Johnson',
            specialty: 'Dermatologist',
            date: '25 May 2025',
            time: '02:00 PM',
            status: 'Confirmed',
          ),
        ];

        // Simulate fetching past appointments
        final List<Appointment> pastAppointments = [
          Appointment(
            doctorName: 'Dr. Sarah Davis',
            specialty: 'Neurologist',
            date: '15 May 2025',
            time: '11:00 AM',
            status: 'Canceled',
          ),
          Appointment(
            doctorName: 'Dr. Michael Brown',
            specialty: 'Pediatrician',
            date: '10 May 2025',
            time: '09:00 AM',
            status: 'Completed',
          ),
        ];

        emit(AppointmentsLoadedState(
          upcomingAppointments: upcomingAppointments,
          pastAppointments: pastAppointments,
          showUpcoming: true,
        ));
      } catch (e) {
        emit(AppointmentsErrorState('Failed to load appointments: $e'));
      }
    });

    on<ToggleAppointmentsEvent>((event, emit) async {
      if (state is AppointmentsLoadedState) {
        final currentState = state as AppointmentsLoadedState;
        emit(AppointmentsLoadedState(
          upcomingAppointments: currentState.upcomingAppointments,
          pastAppointments: currentState.pastAppointments,
          showUpcoming: event.showUpcoming,
        ));
      }
    });
  }
}
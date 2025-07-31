abstract class AppointmentsEvent {}

class LoadAppointmentsEvent extends AppointmentsEvent {}

class ToggleAppointmentsEvent extends AppointmentsEvent {
  final bool showUpcoming;

  ToggleAppointmentsEvent(this.showUpcoming);
}
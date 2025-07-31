import 'package:vistacall/data/models/appointment.dart';

abstract class AppointmentsRepository {
  Future<List<Appointment>> getUpcomingAppointments();
  Future<List<Appointment>> getPastAppointments();
    Future<List<Appointment>> getAllAppointments();
}
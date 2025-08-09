import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vistacall/bloc/appointments/appointments_bloc.dart';
import 'package:vistacall/bloc/appointments/appointments_event.dart';
import 'package:vistacall/bloc/appointments/appointments_state.dart';
import 'package:vistacall/data/models/appointment.dart';
import 'package:vistacall/utils/constants.dart';

/// Handles all business logic for AppointmentsScreen
class AppointmentsViewModel {
  final AppointmentsBloc _appointmentsBloc;

  AppointmentsViewModel(this._appointmentsBloc);

  /// Stream of appointment states for the UI to observe
  Stream<AppointmentsState> get appointmentsState => _appointmentsBloc.stream;

  /// Loads appointments from the repository
  void loadAppointments() => _appointmentsBloc.add(LoadAppointmentsEvent());

  /// Toggles between upcoming and past appointments view
  void toggleAppointmentsView(bool showUpcoming) => 
      _appointmentsBloc.add(ToggleAppointmentsEvent(showUpcoming));

  /// Filters appointments based on current view preference
  List<Appointment> getFilteredAppointments(AppointmentsLoadedState state) => 
      state.showUpcoming ? state.upcomingAppointments : state.pastAppointments;

  /// Determines color based on appointment status
  Color getStatusColor(String status) {
    switch (status) {
      case 'Confirmed': return Colors.green;
      case 'Canceled': return Colors.red;
      default: return Colors.grey;
    }
  }

  /// Handles bottom navigation bar taps
  void handleNavigation(int index, BuildContext context) {
    const routes = [
      AppConstants.homeRoute,
      null, // Current screen
      AppConstants.messagesRoute,
      AppConstants.profileRoute,
    ];
    
    if (index != 1 && routes[index] != null) {
      Navigator.pushReplacementNamed(context, routes[index]!);
    }
  }
}
part of 'home_bloc.dart';

// import 'package:flutter/material.dart';
// import '../models/doctor_category.dart';
// import '../models/appointment.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<DoctorCategory> doctorCategories;
  final List<Appointment> appointments;

  HomeLoaded(this.doctorCategories, this.appointments);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}

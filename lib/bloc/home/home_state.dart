part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<DoctorCategory> doctorCategories;
  final List<Appointment> appointments;
  final List<DoctorModel> doctors;

  HomeLoaded(this.doctorCategories, this.appointments, this.doctors);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}

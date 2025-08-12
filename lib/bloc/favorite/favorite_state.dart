import 'package:equatable/equatable.dart';
import 'package:vistacall/data/models/doctor.dart';

abstract class FavoriteDoctorsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavoriteDoctorsInitial extends FavoriteDoctorsState {}

class FavoriteDoctorsLoading extends FavoriteDoctorsState {}

class FavoriteDoctorsLoaded extends FavoriteDoctorsState {
  final List<DoctorModel> doctors;
  FavoriteDoctorsLoaded(this.doctors);

  @override
  List<Object?> get props => [doctors];
}

class FavoriteDoctorsError extends FavoriteDoctorsState {
  final String message;
  FavoriteDoctorsError(this.message);

  @override
  List<Object?> get props => [message];
}

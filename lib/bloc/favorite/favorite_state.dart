// part of 'favorite_bloc.dart';

// sealed class FavoriteState extends Equatable {
//   const FavoriteState();
  
//   @override
//   List<Object> get props => [];
// }

// final class FavoriteInitial extends FavoriteState {}


import 'package:vistacall/data/models/doctor.dart';

abstract class FavoriteDoctorsState{}

class FavoriteDoctorsInitial extends FavoriteDoctorsState{}

class FavoriteDoctorsLoading extends FavoriteDoctorsState{}

class FavoriteDoctorsLoaded extends FavoriteDoctorsState{
  final List<DoctorModel> doctors;
  FavoriteDoctorsLoaded(this.doctors);
}

class FavoriteDoctorsError extends FavoriteDoctorsState{
  final String message;
  FavoriteDoctorsError(this.message);
}


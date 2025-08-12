import 'package:equatable/equatable.dart';

abstract class FavoriteDoctorsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadFavoriteDoctors extends FavoriteDoctorsEvent {}

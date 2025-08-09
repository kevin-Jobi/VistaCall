import 'package:vistacall/data/models/doctor.dart';

abstract class DoctorListState {}

class DoctorListInitial extends DoctorListState {}

class DoctorListLoading extends DoctorListState {}

class DoctorListLoaded extends DoctorListState {
  final List<DoctorModel> doctors;
  final String? selectedPriceRange;

  DoctorListLoaded(this.doctors, {this.selectedPriceRange});
}

class DoctorListErrorState extends DoctorListState {
  final String error;

  DoctorListErrorState(this.error);
}
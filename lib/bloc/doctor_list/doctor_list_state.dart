// class Doctor {
//   final String name;
//   final String specialty;
//   final String department;

//   Doctor({
//     required this.name,
//     required this.specialty,
//     required this.department,
//   });
// }

// abstract class DoctorListState {}

// class DoctorListLoadingState extends DoctorListState {}

// class DoctorListLoadedState extends DoctorListState {
//   final List<Doctor> doctors;

//   DoctorListLoadedState(this.doctors);
// }

// class DoctorListErrorState extends DoctorListState {
//   final String error;

//   DoctorListErrorState(this.error);
// }


import 'package:vistacall/data/models/doctor.dart';

abstract class DoctorListState {}

class DoctorListInitial extends DoctorListState {}

// class DoctorListLoadingState extends DoctorListState {}

class DoctorListLoading extends DoctorListState {}

class DoctorListLoaded extends DoctorListState {
  final List<DoctorModel> doctors;

  DoctorListLoaded(this.doctors);
}

class DoctorListErrorState extends DoctorListState {
  final String error;

  DoctorListErrorState(this.error);
}

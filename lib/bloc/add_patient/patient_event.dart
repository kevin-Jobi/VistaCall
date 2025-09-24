part of 'patient_bloc.dart';

abstract class PatientEvent extends Equatable {
  const PatientEvent();

  @override
  List<Object> get props => [];
}

class AddPatient extends PatientEvent{
  final Map<String,String> patient;

  const AddPatient(this.patient);

  @override
  List<Object> get props => [patient];
}

class LoadPatients extends PatientEvent{}
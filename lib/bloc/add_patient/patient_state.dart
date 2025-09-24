part of 'patient_bloc.dart';

 class PatientState extends Equatable {
  const PatientState();
  
  @override
  List<Object> get props => [];
}

 class PatientInitial extends PatientState {}

 class PatientLoading extends PatientState {}

 class PatientLoaded extends PatientState{
  final List<Map<String,String>> patients;

  const PatientLoaded(this.patients);

  @override
  List<Object> get props => [patients];

  
 }

  class PatientError extends PatientState {
    final String message;

    const PatientError(this.message);

    @override
    List<Object> get props => [message];
  }


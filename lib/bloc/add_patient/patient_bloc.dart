import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'patient_event.dart';
part 'patient_state.dart';

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  final List<Map<String, String>> _patients = [];
  PatientBloc() : super(PatientInitial()) {
    on<AddPatient>(_onaddPatient);
    on<LoadPatients>(_onloadPatients);
  }

  void _onaddPatient(AddPatient event, Emitter<PatientState> emit) {
    _patients.add(event.patient);
    emit(PatientLoaded(_patients));
  }

  void _onloadPatients(LoadPatients event, Emitter<PatientState>emit){
    emit(PatientLoaded(_patients));
  
  }
}

import 'package:bloc/bloc.dart';

// Dummy Doctor Model
class Doctor {
  final String name;
  final String specialty;
  final String department;

  Doctor({
    required this.name,
    required this.specialty,
    required this.department,
  });
}

// Events
abstract class DoctorListEvent {}

class LoadDoctorsEvent extends DoctorListEvent {
  final String department;

  LoadDoctorsEvent(this.department);
}

// States
abstract class DoctorListState {}

class DoctorListLoadingState extends DoctorListState {}

class DoctorListLoadedState extends DoctorListState {
  final List<Doctor> doctors;

  DoctorListLoadedState(this.doctors);
}

class DoctorListErrorState extends DoctorListState {
  final String error;

  DoctorListErrorState(this.error);
}

class DoctorListBloc extends Bloc<DoctorListEvent, DoctorListState> {
  DoctorListBloc() : super(DoctorListLoadingState()) {
    on<LoadDoctorsEvent>((event, emit) async {
      emit(DoctorListLoadingState());
      try {
        // Dummy data (replace with API call in the future)
        final allDoctors = [
          Doctor(
            name: 'Dr. John Smith',
            specialty: 'Senior Cardiologist',
            department: 'Cardiology',
          ),
          Doctor(
            name: 'Dr. Emily Johnson',
            specialty: 'Dermatologist',
            department: 'Dermatology',
          ),
          Doctor(
            name: 'Dr. Sarah Davis',
            specialty: 'Neurologist',
            department: 'Neurology',
          ),
          Doctor(
            name: 'Dr. Michael Brown',
            specialty: 'Pediatrician',
            department: 'Pediatrics',
          ),
          Doctor(
            name: 'Dr. Anna Lee',
            specialty: 'Cardiologist',
            department: 'Cardiology',
          ),
          Doctor(
            name: 'Dr. Robert Wilson',
            specialty: 'Dermatologist',
            department: 'Dermatology',
          ),
        ];

        final doctors =
            allDoctors
                .where((doctor) => doctor.department == event.department)
                .toList();
        emit(DoctorListLoadedState(doctors));
      } catch (e) {
        emit(DoctorListErrorState('Failed to load doctors: $e'));
      }
    });
  }
}

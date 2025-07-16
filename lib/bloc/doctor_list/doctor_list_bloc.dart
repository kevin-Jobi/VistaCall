import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_event.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_state.dart';

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

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vistacall/bloc/doctor_list/doctor_list_event.dart';
// import 'package:vistacall/bloc/doctor_list/doctor_list_state.dart';

// class DoctorListBloc extends Bloc<DoctorListEvent, DoctorListState> {
//   DoctorListBloc() : super(DoctorListLoadingState()) {
//     on<LoadDoctorsEvent>((event, emit) async {
//       emit(DoctorListLoadingState());
//       try {
//         // Dummy data (replace with API call in the future)
//         final allDoctors = [
//           Doctor(
//             name: 'Dr. John Smith',
//             specialty: 'Senior Cardiologist',
//             department: 'Cardiology',
//           ),
//           Doctor(
//             name: 'Dr. Emily Johnson',
//             specialty: 'Dermatologist',
//             department: 'Dermatology',
//           ),
//           Doctor(
//             name: 'Dr. Sarah Davis',
//             specialty: 'Neurologist',
//             department: 'Neurology',
//           ),
//           Doctor(
//             name: 'Dr. Michael Brown',
//             specialty: 'Pediatrician',
//             department: 'Pediatrics',
//           ),
//           Doctor(
//             name: 'Dr. Anna Lee',
//             specialty: 'Cardiologist',
//             department: 'Cardiology',
//           ),
//           Doctor(
//             name: 'Dr. Robert Wilson',
//             specialty: 'Dermatologist',
//             department: 'Dermatology',
//           ),
//         ];

//         final doctors =
//             allDoctors
//                 .where((doctor) => doctor.department == event.department)
//                 .toList();
//         emit(DoctorListLoadedState(doctors));
//       } catch (e) {
//         emit(DoctorListErrorState('Failed to load doctors: $e'));
//       }
//     });
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_event.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_state.dart';
import 'package:vistacall/data/models/doctor.dart';

class DoctorListBloc extends Bloc<DoctorListEvent, DoctorListState> {
  final FirebaseFirestore _firestore;
  DoctorListBloc({required FirebaseFirestore firestore})
      : _firestore = firestore,
        super(DoctorListInitial()) {
    on<FetchDoctorsByDepartment>(_onFetchDoctorsByDepartment);
  }

  Future<void> _onFetchDoctorsByDepartment(
    FetchDoctorsByDepartment event,
    Emitter<DoctorListState> emit,
  ) async {
    emit(DoctorListLoading());
    print('Fetching doctors for department: ${event.department}');
    try {
      final snapshot = await _firestore
          .collection('doctors')
          .where('personal.department', isEqualTo: event.department)
          .where('verificationStatus', isEqualTo: 'approved')
          .get();
          print('Query returned ${snapshot.docs.length} documents');
          if (snapshot.docs.isEmpty) {
      print('No documents found - check department and verificationStatus');
    }
      final doctors =
          snapshot.docs.map((doc) => DoctorModel.fromFirestore(doc)).toList();
      emit(DoctorListLoaded(doctors));
    } catch (e) {
      emit(DoctorListErrorState('Failed to load doctors: $e'));
    }
  }
}

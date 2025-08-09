import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_event.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_state.dart';
import 'package:vistacall/data/models/doctor.dart';

class DoctorListBloc extends Bloc<DoctorListEvent, DoctorListState> {
  final FirebaseFirestore _firestore;
  List<DoctorModel> allDoctors = [];
  DoctorListBloc({required FirebaseFirestore firestore})
      : _firestore = firestore,
        super(DoctorListInitial()) {
    on<FetchDoctorsByDepartment>(_onFetchDoctorsByDepartment);
    on<FilteredDoctorsByPrice>(_onFilterDoctorsByPrice);

    print('DoctoListBloc initialized with state: ${state.runtimeType}');
  }

  Future<void> _onFetchDoctorsByDepartment(
    FetchDoctorsByDepartment event,
    Emitter<DoctorListState> emit,
  ) async {
    emit(DoctorListLoading());
    print(
        'Fetching doctors for department: ${event.department}, current state: ${state.runtimeType}');
    try {
      final snapshot = event.department == 'all'
          ? await _firestore
              .collection('doctors')
              .where('verificationStatus', isEqualTo: 'approved')
              .get()
          : await _firestore
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
      allDoctors = doctors; // Store all doctors for initial state
      emit(DoctorListLoaded(doctors));
      print('Emitted DoctorListLoaded with ${doctors.length} doctors');
    } catch (e) {
      emit(DoctorListErrorState('Failed to load doctors: $e'));
      print('Emitted DoctorListErrorState: $e, state: ${state.runtimeType}');
    }
  }

  Future<void> _onFilterDoctorsByPrice(
    FilteredDoctorsByPrice event,
    Emitter<DoctorListState> emit,
  ) async {
    print(
        'Filtering doctors by price range: ${event.priceRange}, current state: ${state.runtimeType}');
    // final currentState = state;
    if (state is DoctorListLoaded) {
      // final currentDoctors =  (state as DoctorListLoaded).doctors ;
      final currentState = state as DoctorListLoaded;

      print('Found ${currentState.doctors.length} doctors in current state');

      if (event.priceRange == '') {
        emit(DoctorListLoaded(allDoctors));
        print(
            'Emitted DoctorListLoaded with ${allDoctors.length} doctors after reset');
      } else {
        final filteredDoctors = currentState.doctors.where((doctor) {
          final fees =
              int.tryParse(doctor.availability['fees'].toString()) ?? 0;

          switch (event.priceRange) {
            case '100 - 500':
              return fees >= 100 && fees <= 500;
            case '500 - 1000':
              return fees > 500 && fees <= 1000;
            case '1000 - 2000':
              return fees > 1000 && fees <= 2000;
            case '2000 - 3000':
              return fees > 2000 && fees <= 3000;
            case '3000+':
              return fees > 3000;
            default:
              return true;
          }
        }).toList();
        emit(DoctorListLoaded(filteredDoctors,
            selectedPriceRange: event.priceRange));
        print(
            'Emitted DoctorListLoaded with ${filteredDoctors.length} filtered doctors, state: ${state.runtimeType}');
      }
    } else if (state is DoctorListInitial) {
      print('Handling initial state with ${allDoctors.length} allDoctors');
      final filteredDoctors = allDoctors.where((doctor) {
        final fees = int.tryParse(doctor.availability['fees'].toString()) ?? 0;
        switch (event.priceRange) {
          case '100 - 500':
            return fees >= 100 && fees <= 500;
          case '500 - 1000':
            return fees > 500 && fees <= 1000;
          case '1000 - 2000':
            return fees > 1000 && fees <= 2000;
          case '2000 - 3000':
            return fees > 2000 && fees <= 3000;
          case '3000+':
            return fees > 3000;
          default:
            return true;
        }
      }).toList();
      emit(DoctorListLoaded(filteredDoctors,
          selectedPriceRange: event.priceRange));
      print(
          'Emitted DoctorListLoaded with ${filteredDoctors.length} filtered doctors from allDoctors');
    } else {
      print('Ignoring filter event for state: $state');
    }
  }
}

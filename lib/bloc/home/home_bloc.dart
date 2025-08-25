import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_bloc.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_event.dart';
import 'package:vistacall/data/models/doctor.dart';
import '../../data/models/doctor_category.dart';
import '../../data/models/appointment.dart';
part 'home_event.dart';
part 'home_state.dart';



class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DoctorListBloc doctorListBloc;
  HomeBloc({required this.doctorListBloc}) : super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
  }

  Future<void> _onLoadHomeData(LoadHomeData event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      // Fetch departments from Firestore
      final QuerySnapshot categorySnapshot =
          await FirebaseFirestore.instance.collection('admin').get();

      // Explicitly type the result as List<DoctorCategory>
      final List<DoctorCategory> doctorCategories =
          categorySnapshot.docs.expand((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final categories = data['categories'] as List<dynamic>? ?? [];
        return categories.map(
          (category) => DoctorCategory.fromFirestore(category.toString()),
        );
      }).toList();

      // Fetch all approved doctors
      final QuerySnapshot doctorSnapshot = await FirebaseFirestore.instance
          .collection('doctors')
          .where('verificationStatus', isEqualTo: 'approved')
          .get();

      final List<DoctorModel> doctors = doctorSnapshot.docs
          .map((doc) => DoctorModel.fromFirestore(doc))
          .toList();
      print(
          'Loaded ${doctors.length} doctors: ${doctors.map((d) => d.personal['fullName']??'unnamed').toList()}'); // Enhanced log      // Static appointments (can be updated to fetch from Firestore if needed)
      // final doctorListBloc = DoctorListBloc(firestore: FirebaseFirestore.instance);
      doctorListBloc.add(FetchDoctorsByDepartment('all'));
      final List<Appointment> appointments = [
        Appointment(patientName: 'patientname',
          doctorName: 'Donald Mathew',
          specialty: 'Cardiology Consultation',
          date: 'May 2, 2025',
          time: '10:30 AM',
          status: 'Confirmed',
        ),
      ];

      emit(HomeLoaded(doctorCategories, appointments, doctors));
    } catch (e) {
      emit(HomeError('Failed to load data: $e'));
    }
  }
}

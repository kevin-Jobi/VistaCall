import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/doctor_category.dart';
import '../data/models/appointment.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      // Simulate data loading (this could be an API call in a real app)
      await Future.delayed(
        const Duration(seconds: 1),
      ); // Simulate network delay

      final doctorCategories = [
        DoctorCategory(
          title: 'General Physician',
          imagePath: 'assets/images/generalphysician.png',
        ),
        DoctorCategory(
          title: 'Dermatology',
          imagePath: 'assets/images/dermatology.png',
        ),
        DoctorCategory(
          title: 'Women\'s Specialist',
          imagePath: 'assets/images/women_specialist.png',
        ),
        DoctorCategory(
          title: 'Dentist',
          imagePath: 'assets/images/dentist.png',
        ),
        DoctorCategory(
          title: 'Pediatrician',
          imagePath: 'assets/images/pediatrician.png',
        ),
        DoctorCategory(title: 'ENT', imagePath: 'assets/images/ent.png'),
        DoctorCategory(
          title: 'Neurosurgeon',
          imagePath: 'assets/images/neuro.png',
        ),
        DoctorCategory(
          title: '15+ MORE',
          imagePath: 'assets/images/generalphysician.png',
        ),
      ];

      final appointments = [
        Appointment(
          doctorName: 'Donald Mathew',
          specialty: 'Cardiology Consultation',
          date: 'May 2, 2025',
          time: '10:30 AM',
          status: 'Confirmed',
        ),
      ];

      emit(HomeLoaded(doctorCategories, appointments));
    } catch (e) {
      emit(HomeError('Failed to load data: $e'));
    }
  }
}

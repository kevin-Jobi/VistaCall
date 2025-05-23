// import 'package:bloc/bloc.dart';
// import 'package:vistacall/data/models/doctor_category.dart';
// import 'package:vistacall/data/models/appointment.dart';

// // Events
// abstract class HomeEvent {}

// class LoadHomeDataEvent extends HomeEvent {}

// // States (Previously in home_state.dart)
// abstract class HomeState {}

// class HomeLoadingState extends HomeState {}

// class HomeLoadedState extends HomeState {
//   final List<DoctorCategory> doctorCategories;
//   final List<Appointment> appointments;

//   HomeLoadedState({required this.doctorCategories, required this.appointments});
// }

// class HomeErrorState extends HomeState {
//   final String error;

//   HomeErrorState(this.error);
// }

// class HomeBloc extends Bloc<HomeEvent, HomeState> {
//   HomeBloc() : super(HomeLoadingState()) {
//     on<LoadHomeDataEvent>((event, emit) async {
//       emit(HomeLoadingState());
//       try {
//         // Simulate fetching doctor categories
//         final List<DoctorCategory> doctorCategories = [
//           DoctorCategory(title: 'Heart', imagePath: 'assets/images/heart.png'),
//           DoctorCategory(title: 'Skin', imagePath: 'assets/images/skin.png'),
//           DoctorCategory(title: 'Brain', imagePath: 'assets/images/brain.png'),
//           DoctorCategory(title: 'Child', imagePath: 'assets/images/child.png'),
//         ];

//         // Simulate fetching appointments
//         final List<Appointment> appointments = [
//           Appointment(
//             doctorName: 'Dr. John Smith',
//             specialty: 'Cardiologist',
//             date: '20 May 2025',
//             time: '10:00 AM',
//             status: 'Confirmed',
//           ),
//         ];

//         emit(
//           HomeLoadedState(
//             doctorCategories: doctorCategories,
//             appointments: appointments,
//           ),
//         );
//       } catch (e) {
//         emit(HomeErrorState('Failed to load home data: $e'));
//       }
//     });

//     // Automatically load data when the bloc is created
//     add(LoadHomeDataEvent());
//   }
// }

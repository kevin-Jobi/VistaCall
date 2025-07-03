import '../bloc/home/home_bloc.dart';
import '../data/models/doctor_category.dart';
import '../data/models/appointment.dart';

class HomeViewModel {
  final HomeBloc _homeBloc;

  HomeViewModel(this._homeBloc) {
    loadData();
  }

  HomeBloc get homeBloc => _homeBloc;

  void loadData() {
    _homeBloc.add(LoadHomeData());
  }

  List<DoctorCategory> getDoctorCategories(HomeState state) {
    if (state is HomeLoaded) {
      return state.doctorCategories;
    }
    return [];
  }

  List<Appointment> getAppointments(HomeState state) {
    if (state is HomeLoaded) {
      return state.appointments;
    }
    return [];
  }

  String? getErrorMessage(HomeState state) {
    if (state is HomeError) {
      return state.message;
    }
    return null;
  }

  bool isLoading(HomeState state) {
    return state is HomeLoading;
  }
}




import 'package:flutter/widgets.dart';
import 'package:vistacall/utils/constants.dart';

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

  void navigateToDepartment(BuildContext context, String categoryTitle) {
    final department = _getDepartmentFromCategory(categoryTitle);
    print('Navigating to department $department');
    Navigator.pushNamed(
      context,
      AppConstants.doctorsRoute,
      arguments: department,
    );
  }

  String _getDepartmentFromCategory(String title) {
    switch (title.toLowerCase()) {
      case 'heart':
        return 'Cardiology';
      case 'skin':
        return 'Dermatology';
      case 'brain':
        return 'Neurology';
      case 'child':
        return 'Child specialist';
      case 'dental':
        return 'Dental';
      default:
        return title;
    }
  }
}

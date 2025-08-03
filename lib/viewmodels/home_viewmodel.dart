import 'package:flutter/widgets.dart';
import 'package:vistacall/data/models/doctor.dart';
import 'package:vistacall/utils/constants.dart';

import '../bloc/home/home_bloc.dart';
import '../data/models/doctor_category.dart';
import '../data/models/appointment.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeBloc _homeBloc;
  String _searchQuery = '';
  List<DoctorCategory> _filteredCategories = [];
  List<DoctorModel> _filteredDoctors = [];

  HomeViewModel(this._homeBloc) {
    loadData();
  }

  HomeBloc get homeBloc => _homeBloc;

  void loadData() {
    _homeBloc.add(LoadHomeData());
  }

  // search query
  void setSearchQuery(String query) {
    _searchQuery = query.toLowerCase();
    print('Setting search query to: $_searchQuery'); // Debug log
    _filterData();
    notifyListeners();
  }

  // Filter categories and doctors
  void _filterData() {
    final state = _homeBloc.state;
    print('Filtering data with state: $state'); // Debug log
    if (state is HomeLoaded) {
      print(
          'All doctors in state: ${state.doctors.map((d) => d.personal['fullName']).toList()}');
      if (_searchQuery.isEmpty) {
        _filteredCategories = []; // Reset categories to empty
        _filteredDoctors = []; // Reset doctors to empty
      } else {
        //filtered departments
        _filteredCategories = state.doctorCategories
            .where((category) =>
                category.title.toLowerCase().contains(_searchQuery))
            .toList();

        // filtered doctors
        _filteredDoctors = state.doctors.where((doctor) {
          final fullName = doctor.personal['fullName']?.toLowerCase() ?? '';
          final department = doctor.personal['department']?.toLowerCase() ?? '';

          print(
              'Checking doctor: $fullName, Dept: $department, Query: $_searchQuery'); // Debug

          final matches = fullName.contains(_searchQuery) ||
              department.contains(_searchQuery);

          if (matches) print('Match found for: $fullName');

          return matches;
        }).toList();
      }

      print(
          'Filtered categoriesKingKing: ${_filteredCategories.length}, Doctors: ${_filteredDoctors.length}');
    }
  }

  List<DoctorCategory> getFilteredCategories() => _filteredCategories;
  List<DoctorModel> getFilteredDoctors() => _filteredDoctors;

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

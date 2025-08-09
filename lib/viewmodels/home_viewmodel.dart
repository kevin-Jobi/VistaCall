import 'package:flutter/widgets.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_state.dart';
import 'package:vistacall/bloc/home/home_bloc.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_bloc.dart';
import 'package:vistacall/data/models/doctor.dart';
import 'package:vistacall/data/models/doctor_category.dart';
import 'package:vistacall/data/models/appointment.dart';
import 'package:vistacall/utils/constants.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeBloc _homeBloc;
  final DoctorListBloc _doctorListBloc;
  String _searchQuery = '';
  List<DoctorCategory> _filteredCategories = [];
  List<DoctorModel> _filteredDoctors = [];

  HomeViewModel(this._homeBloc, this._doctorListBloc) {
    loadData();
    _doctorListBloc.stream.listen((state) {
      print('DoctorListBloc state changed to: ${state.runtimeType}');
      if (state is DoctorListLoaded) {
        _filterData(); // Re-filter when price range changes
      }
    });
  }

  HomeBloc get homeBloc => _homeBloc;

  void loadData() {
    _homeBloc.add(LoadHomeData());
  }

  void setSearchQuery(String query) {
    _searchQuery = query.toLowerCase();
    print('Setting search query to: $_searchQuery'); // Debug log
    _filterData();
    notifyListeners();
  }

  
  void _filterData() {
    final homeState = _homeBloc.state;
    final doctorListState = _doctorListBloc.state;
    print(
        'Filtering data with home state: ${homeState.runtimeType}, doctor list state: ${doctorListState.runtimeType}');
    if (homeState is HomeLoaded && doctorListState is DoctorListLoaded) {
      print(
          'All doctors in state: ${doctorListState.doctors.map((d) => d.personal['fullName']).toList()}');
      if (_searchQuery.isEmpty) {
        _filteredCategories = [];
        _filteredDoctors = [];
      } else {
        // Find the matching category
        final matchedCategory = homeState.doctorCategories.firstWhere(
          (category) => category.title.toLowerCase().contains(_searchQuery),
          orElse: () => DoctorCategory(title: '', imagePath: ''),
        );
        if (matchedCategory.title.isNotEmpty) {
          _filteredCategories = [
            matchedCategory
          ]; // Show only the matched category
          final department =
              _getDepartmentFromCategory(matchedCategory.title).toLowerCase();
          _filteredDoctors = doctorListState.doctors.where((doctor) {
            final fullName = doctor.personal['fullName']?.toLowerCase() ?? '';
            final doctorDept =
                doctor.personal['department']?.toLowerCase() ?? '';
            print(
                'Checking doctor: fullName="$fullName", dept="$doctorDept", query="$_searchQuery"');
            final matches = doctorDept.contains(department) ||
                fullName.contains(_searchQuery); // Global search
            if (matches) print('Match found for: $fullName');
            return matches;
          }).toList();
        } else {
          _filteredCategories = [];
          _filteredDoctors = doctorListState.doctors.where((doctor) {
            final fullName = doctor.personal['fullName']?.toLowerCase() ?? '';
            final department =
                doctor.personal['department']?.toLowerCase() ?? '';
            print(
                'Checking doctor: fullName="$fullName", dept="$department", query="$_searchQuery"');
            final matches = fullName.contains(_searchQuery) ||
                department.contains(_searchQuery); // Global search
            if (matches) print('Match found for: $fullName');
            return matches;
          }).toList();
        }
      }
      print(
          'Filtered categories: ${_filteredCategories.length}, Doctors: ${_filteredDoctors.length}');
    } else {
      print(
          'Skipping filter due to invalid state - homeState: ${homeState.runtimeType}, doctorListState: ${doctorListState.runtimeType}');
      _filteredCategories = [];
      _filteredDoctors = [];
    }
  }

  List<DoctorCategory> getFilteredCategories() => _filteredCategories;
  List<DoctorModel> getFilteredDoctors() => _filteredDoctors;

  List<DoctorCategory> getDoctorCategories(HomeState state) {
    if (state is HomeLoaded) return state.doctorCategories;
    return [];
  }

  List<Appointment> getAppointments(HomeState state) {
    if (state is HomeLoaded) return state.appointments;
    return [];
  }

  String? getErrorMessage(HomeState state) {
    if (state is HomeError) return state.message;
    return null;
  }

  bool isLoading(HomeState state) {
    return state is HomeLoading;
  }

  void navigateToDepartment(BuildContext context, String categoryTitle) {
    final department = _getDepartmentFromCategory(categoryTitle);
    print('Navigating to department $department');
    Navigator.pushNamed(context, AppConstants.doctorsRoute,
        arguments: department);
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
      case 'onc':
        return 'Oncologists';
      default:
        return title;
    }
  }
}

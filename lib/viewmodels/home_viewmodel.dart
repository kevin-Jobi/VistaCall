// import 'package:flutter/widgets.dart';
// import 'package:vistacall/bloc/doctor_list/doctor_list_state.dart';
// import 'package:vistacall/bloc/home/home_bloc.dart';
// import 'package:vistacall/bloc/doctor_list/doctor_list_bloc.dart';
// import 'package:vistacall/data/models/doctor.dart';
// import 'package:vistacall/data/models/doctor_category.dart';
// import 'package:vistacall/data/models/appointment.dart';
// import 'package:vistacall/utils/constants.dart';

// class HomeViewModel extends ChangeNotifier {
//   final HomeBloc _homeBloc;
//   final DoctorListBloc _doctorListBloc;
//   String _searchQuery = '';
//   List<DoctorCategory> _filteredCategories = [];
//   List<DoctorModel> _filteredDoctors = [];

//   HomeViewModel(this._homeBloc, this._doctorListBloc) {
//     loadData();
//     _doctorListBloc.stream.listen((state) {
//       print('DoctorListBloc state changed to: ${state.runtimeType}');
//       if (state is DoctorListLoaded) {
//         _filterData(); // Re-filter when price range changes
//       }
//     });
//   }

//   HomeBloc get homeBloc => _homeBloc;

//   void loadData() {
//     _homeBloc.add(LoadHomeData());
//   }

//   void setSearchQuery(String query) {
//     _searchQuery = query.toLowerCase();
//     print('Setting search query to: $_searchQuery'); // Debug log
//     _filterData();
//     notifyListeners();
//   }

  
//   void _filterData() {
//     final homeState = _homeBloc.state;
//     final doctorListState = _doctorListBloc.state;
//     print(
//         'Filtering data with home state: ${homeState.runtimeType}, doctor list state: ${doctorListState.runtimeType}');
//     if (homeState is HomeLoaded && doctorListState is DoctorListLoaded) {
//       print(
//           'All doctors in state: ${doctorListState.doctors.map((d) => d.personal['fullName']).toList()}');
//       if (_searchQuery.isEmpty) {
//         _filteredCategories = [];
//         _filteredDoctors = [];
//       } else {
//         // Find the matching category
//         final matchedCategory = homeState.doctorCategories.firstWhere(
//           (category) => category.title.toLowerCase().contains(_searchQuery),
//           orElse: () => DoctorCategory(title: '', imagePath: ''),
//         );
//         if (matchedCategory.title.isNotEmpty) {
//           _filteredCategories = [
//             matchedCategory
//           ]; // Show only the matched category
//           final department =
//               _getDepartmentFromCategory(matchedCategory.title).toLowerCase();
//           _filteredDoctors = doctorListState.doctors.where((doctor) {
//             final fullName = doctor.personal['fullName']?.toLowerCase() ?? '';
//             final doctorDept =
//                 doctor.personal['department']?.toLowerCase() ?? '';
//             print(
//                 'Checking doctor: fullName="$fullName", dept="$doctorDept", query="$_searchQuery"');
//             final matches = doctorDept.contains(department) ||
//                 fullName.contains(_searchQuery); // Global search
//             if (matches) print('Match found for: $fullName');
//             return matches;
//           }).toList();
//         } else {
//           _filteredCategories = [];
//           _filteredDoctors = doctorListState.doctors.where((doctor) {
//             final fullName = doctor.personal['fullName']?.toLowerCase() ?? '';
//             final department =
//                 doctor.personal['department']?.toLowerCase() ?? '';
//             print(
//                 'Checking doctor: fullName="$fullName", dept="$department", query="$_searchQuery"');
//             final matches = fullName.contains(_searchQuery) ||
//                 department.contains(_searchQuery); // Global search
//             if (matches) print('Match found for: $fullName');
//             return matches;
//           }).toList();
//         }
//       }
//       print(
//           'Filtered categories: ${_filteredCategories.length}, Doctors: ${_filteredDoctors.length}');
//     } else {
//       print(
//           'Skipping filter due to invalid state - homeState: ${homeState.runtimeType}, doctorListState: ${doctorListState.runtimeType}');
//       _filteredCategories = [];
//       _filteredDoctors = [];
//     }
//   }

//   List<DoctorCategory> getFilteredCategories() => _filteredCategories;
//   List<DoctorModel> getFilteredDoctors() => _filteredDoctors;

//   List<DoctorCategory> getDoctorCategories(HomeState state) {
//     if (state is HomeLoaded) return state.doctorCategories;
//     return [];
//   }

//   List<Appointment> getAppointments(HomeState state) {
//     if (state is HomeLoaded) return state.appointments;
//     return [];
//   }

//   String? getErrorMessage(HomeState state) {
//     if (state is HomeError) return state.message;
//     return null;
//   }

//   bool isLoading(HomeState state) {
//     return state is HomeLoading;
//   }

//   void navigateToDepartment(BuildContext context, String categoryTitle) {
//     final department = _getDepartmentFromCategory(categoryTitle);
//     print('Navigating to department $department');
//     Navigator.pushNamed(context, AppConstants.doctorsRoute,
//         arguments: department);
//   }

//   String _getDepartmentFromCategory(String title) {
//     switch (title.toLowerCase()) {
//       case 'heart':
//         return 'Cardiology';
//       case 'skin':
//         return 'Dermatology';
//       case 'brain':
//         return 'Neurology';
//       case 'child':
//         return 'Child specialist';
//       case 'dental':
//         return 'Dental';
//       case 'onc':
//         return 'Oncologists';
//       default:
//         return title;
//     }
//   }
// }

// lib/viewmodels/home_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:vistacall/bloc/home/home_bloc.dart';
// import 'package:vistacall/bloc/home/home_event.dart';
// import 'package:vistacall/bloc/home/home_state.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_bloc.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_event.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_state.dart';
import 'package:vistacall/data/models/doctor.dart';
import 'package:vistacall/data/models/doctor_category.dart';
import 'package:vistacall/data/models/appointment.dart';
import 'package:vistacall/utils/constants.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeBloc _homeBloc;
  final DoctorListBloc _doctorListBloc;
  
  // Private state
  String _searchQuery = '';
  List<DoctorCategory> _filteredCategories = [];
  List<DoctorModel> _filteredDoctors = [];
  bool _isInitialized = false;
  bool _isLoading = false;

  // Public getters
  String get searchQuery => _searchQuery;
  List<DoctorCategory> get filteredCategories => _filteredCategories;
  List<DoctorModel> get filteredDoctors => _filteredDoctors;
  bool get isLoading => _isLoading;
  bool get hasSearchResults => _filteredCategories.isNotEmpty || _filteredDoctors.isNotEmpty;
  int get searchResultCount => _filteredCategories.length + _filteredDoctors.length;

  HomeViewModel(this._homeBloc, this._doctorListBloc) {
    _initialize();
  }

  HomeBloc get homeBloc => _homeBloc;
  DoctorListBloc get doctorListBloc => _doctorListBloc;

  /// Initialize ViewModel and set up listeners
  void _initialize() {
    if (_isInitialized) return;
    
    _isInitialized = true;
    _setupStreamListeners();
    _loadInitialData();
  }

  /// Set up listeners for both BLoCs
  void _setupStreamListeners() {
    _homeBloc.stream.listen((state) {
      print('HomeBloc state changed: ${state.runtimeType}');
      _handleHomeBlocState(state);
    });

    _doctorListBloc.stream.listen((state) {
      print('DoctorListBloc state changed: ${state.runtimeType}');
      _handleDoctorListBlocState(state);
    });
  }

  /// Load initial data
  void _loadInitialData() {
    _isLoading = true;
    notifyListeners();
    
    _homeBloc.add( LoadHomeData());
    _doctorListBloc.add( FetchDoctorsByDepartment('all'));
  }

  /// Handle HomeBloc state changes
  void _handleHomeBlocState(HomeState state) {
    _isLoading = state is HomeLoading;
    
    if (state is HomeLoaded) {
      _filterData();
      notifyListeners();
    } else if (state is HomeError) {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Handle DoctorListBloc state changes
  void _handleDoctorListBlocState(DoctorListState state) {
    if (state is DoctorListLoaded) {
      _filterData();
      notifyListeners();
    }
  }

  /// Public method to update search query
  void setSearchQuery(String query) {
    _searchQuery = query.toLowerCase().trim();
    print('Search query updated: $_searchQuery');
    _filterData();
    notifyListeners();
  }

  /// Public method to clear search
  void clearSearch() {
    setSearchQuery('');
  }

  /// Public method to refresh data
  void refreshData() {
    _loadInitialData();
  }

  /// Filter data based on current search query
  void _filterData() {
    final homeState = _homeBloc.state;
    final doctorState = _doctorListBloc.state;

    if (homeState is! HomeLoaded || doctorState is! DoctorListLoaded) {
      _filteredCategories = [];
      _filteredDoctors = [];
      return;
    }

    if (_searchQuery.isEmpty) {
      _filteredCategories = [];
      _filteredDoctors = [];
    } else {
      _filterCategoriesAndDoctors(homeState, doctorState);
    }
  }

  /// Filter categories and doctors logic
  void _filterCategoriesAndDoctors(HomeLoaded homeState, DoctorListLoaded doctorState) {
    final matchedCategory = homeState.doctorCategories.firstWhere(
      (category) => category.title.toLowerCase().contains(_searchQuery),
      orElse: () => DoctorCategory(title: '', imagePath: ''),
    );

    if (matchedCategory.title.isNotEmpty) {
      _filteredCategories = [matchedCategory];
      final department = _getDepartmentFromCategory(matchedCategory.title).toLowerCase();
      
      _filteredDoctors = doctorState.doctors.where((doctor) {
        final fullName = doctor.personal['fullName']?.toLowerCase() ?? '';
        final doctorDept = doctor.personal['department']?.toLowerCase() ?? '';
        return doctorDept.contains(department) || fullName.contains(_searchQuery);
      }).toList();
    } else {
      _filteredCategories = [];
      _filteredDoctors = doctorState.doctors.where((doctor) {
        final fullName = doctor.personal['fullName']?.toLowerCase() ?? '';
        final department = doctor.personal['department']?.toLowerCase() ?? '';
        return fullName.contains(_searchQuery) || department.contains(_searchQuery);
      }).toList();
    }
  }

  /// Get all categories from Home state
  List<DoctorCategory> getDoctorCategories(HomeState state) {
    if (state is HomeLoaded) return state.doctorCategories;
    return [];
  }

  /// Get appointments from Home state
  List<Appointment> getAppointments(HomeState state) {
    if (state is HomeLoaded) return state.appointments;
    return [];
  }

  /// State checkers
  bool isHomeLoading(HomeState state) => state is HomeLoading;
  String? getHomeError(HomeState state) => state is HomeError ? state.message : null;
  bool isDoctorListLoading(DoctorListState state) => state is DoctorListLoading;

  /// Navigate to department doctors list
  void navigateToDepartment(BuildContext context, String categoryTitle) {
    final department = _getDepartmentFromCategory(categoryTitle);
    Navigator.pushNamed(
      context,
      AppConstants.doctorsRoute,
      arguments: department,
    );
  }

  /// Map category title to department name
  String _getDepartmentFromCategory(String title) {
    switch (title.toLowerCase()) {
      case 'heart':
      case 'cardiology':
        return 'Cardiology';
      case 'skin':
      case 'dermatology':
        return 'Dermatology';
      case 'brain':
      case 'neurology':
        return 'Neurology';
      case 'child':
      case 'pediatrician':
      case 'child specialist':
        return 'Child specialist';
      case 'dental':
        return 'Dental';
      case 'onc':
      case 'oncologist':
        return 'Oncologists';
      default:
        return title;
    }
  }

  @override
  void dispose() {
    print('HomeViewModel disposed');
    super.dispose();
  }

  // Add these methods to HomeViewModel class

/// Handle HomeBloc state changes (for BlocListener)
void _handleHomeStateChange(HomeState state) {
  _isLoading = state is HomeLoading;
  
  if (state is HomeLoaded) {
    _filterData();
  } else if (state is HomeError) {
    _isLoading = false;
  }
  notifyListeners();
}

/// Handle DoctorListBloc state changes (for BlocListener)
void _handleDoctorListStateChange(DoctorListState state) {
  if (state is DoctorListLoaded) {
    _filterData();
    notifyListeners();
  }
}
}
abstract class DoctorListEvent {}

class FetchDoctorsByDepartment extends DoctorListEvent {
  final String department;

  FetchDoctorsByDepartment(this.department);
}

class FilteredDoctorsByPrice extends DoctorListEvent {
  final String priceRange;

  FilteredDoctorsByPrice(this.priceRange);
}


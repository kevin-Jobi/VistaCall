abstract class DoctorListEvent {}

class FetchDoctorsByDepartment extends DoctorListEvent {
  final String department;

  FetchDoctorsByDepartment(this.department);
}

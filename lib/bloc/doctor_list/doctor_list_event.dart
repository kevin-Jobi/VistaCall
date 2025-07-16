abstract class DoctorListEvent {}

class LoadDoctorsEvent extends DoctorListEvent {
  final String department;

  LoadDoctorsEvent(this.department);
}
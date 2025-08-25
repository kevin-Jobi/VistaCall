class Appointment {
  final String? id;
  final String doctorName;
  final String specialty;
  final String date;
  final String time;
  final String status;
  final String patientName;

  Appointment({
    this.id,
    required this.doctorName,
    required this.specialty,
    required this.date,
    required this.time,
    required this.status,
    required this.patientName
  });
}

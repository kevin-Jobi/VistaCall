// class Appointment {
//   final String? id;
//   final String doctorName;
//   final String specialty;
//   final String date;
//   final String time;
//   final String status;
//   final String patientName;
//   final String? paymentMethod;
//   final String? paymentStatus;

//   Appointment({
//     this.id,
//     required this.doctorName,
//     required this.specialty,
//     required this.date,
//     required this.time,
//     required this.status,
//     required this.patientName,
//     this.paymentMethod,
//     this.paymentStatus,
//   });
// }

import 'package:equatable/equatable.dart';

class Appointment extends Equatable {
  final String? id;
  final String doctorId; // Added for linking to doctor's Firestore document
  final String doctorName;
  final String specialty;
  final String date;
  final String time;
  final String status;
  final String patientName;
  final bool reviewed; // Added to track review status
  final String? paymentMethod;
  final String? paymentStatus;

  Appointment({
    this.id,
    required this.doctorId,
    required this.doctorName,
    required this.specialty,
    required this.date,
    required this.time,
    required this.status,
    required this.patientName,
    required this.reviewed,
    this.paymentMethod,
    this.paymentStatus,
  });

  // Factory method to create Appointment from Firestore data
  factory Appointment.fromFirestore(Map<String, dynamic> data, String id, String doctorId) {
    return Appointment(
      id: id,
      doctorId: doctorId,
      doctorName: data['doctorName'] ?? 'Unknown Doctor',
      specialty: data['specialty'] ?? 'Unknown Specialty',
      date: data['date'] ?? '',
      time: data['slot'] ?? '',
      status: data['status'] ?? 'Pending',
      patientName: data['userName'] ?? 'Unknown Patient',
      reviewed: data['reviewed'] ?? false,
      paymentMethod: data['paymentMethod'],
      paymentStatus: data['paymentStatus'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        doctorId,
        doctorName,
        specialty,
        date,
        time,
        status,
        patientName,
        reviewed,
        paymentMethod,
        paymentStatus,
      ];
}
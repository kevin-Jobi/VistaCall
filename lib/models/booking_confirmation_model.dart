import 'package:vistacall/data/models/doctor.dart';

class BookingConfirmationModel {
  final DoctorModel doctor;
  final DateTime? selectedDate;
  final String? selectedSlot;
  final String? selectedPatientName;

  const BookingConfirmationModel({
    required this.doctor,
    this.selectedDate,
    this.selectedSlot,
    this.selectedPatientName,
  });

  BookingConfirmationModel copyWith({
    DoctorModel? doctor,
    DateTime? selectedDate,
    String? selectedSlot,
    String? selectedPatientName,
  }) {
    return BookingConfirmationModel(
      doctor: doctor ?? this.doctor,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedSlot: selectedSlot ?? this.selectedSlot,
      selectedPatientName: selectedPatientName ?? this.selectedPatientName,
    );
  }
}
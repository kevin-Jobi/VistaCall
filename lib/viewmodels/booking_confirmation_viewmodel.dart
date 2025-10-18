import 'package:flutter/material.dart';
import 'package:vistacall/data/models/doctor.dart';
import '../models/booking_confirmation_model.dart';

class BookingConfirmationViewModel extends ChangeNotifier {
  BookingConfirmationModel _model;
  bool _isLoading = false;

  BookingConfirmationViewModel({
    required DoctorModel doctor,
    DateTime? selectedDate,
    String? selectedSlot,
  }) : _model = BookingConfirmationModel(
          doctor: doctor,
          selectedDate: selectedDate,
          selectedSlot: selectedSlot,
        );

  BookingConfirmationModel get model => _model;
  bool get isLoading => _isLoading;
  String? get selectedPatientName => _model.selectedPatientName;

  String getTimeDifference() {
    if (_model.selectedDate == null || _model.selectedSlot == null) return 'N/A';
    final now = DateTime.now();
    final slotParts = _model.selectedSlot!.split('-');
    if (slotParts.length != 2) return 'N/A';
    final startTime = slotParts[0].split(':');
    if (startTime.length != 2) return 'N/A';
    final appointmentTime = DateTime(
      _model.selectedDate!.year,
      _model.selectedDate!.month,
      _model.selectedDate!.day,
      int.parse(startTime[0]),
      int.parse(startTime[1]),
    );
    final difference = appointmentTime.difference(now);
    if (difference.isNegative) return 'Past due';
    final hours = difference.inHours;
    final minutes = difference.inMinutes.remainder(60);
    return 'in $hours hours and $minutes min';
  }

  String formatAppointmentTime() {
    if (_model.selectedDate == null || _model.selectedSlot == null) {
      return 'Mon, 18 Aug 12:30 PM';
    }
    return '${_getWeekdayAbbreviation(_model.selectedDate!.weekday)}, '
        '${_model.selectedDate!.day} ${_getMonthAbbreviation(_model.selectedDate!.month)} '
        '${_model.selectedSlot!.split('-')[0]} '
        '${_isPM(_model.selectedSlot!.split('-')[0]) ? 'PM' : 'AM'}';
  }

  String get consultationFee => '₹${_model.doctor.availability['fees']}';

  void updateSelectedPatient(String patientName) {
    _model = _model.copyWith(selectedPatientName: patientName);
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Private helpers
  String _getWeekdayAbbreviation(int weekday) {
    const abbreviations = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return abbreviations[weekday - 1];
  }

  String _getMonthAbbreviation(int month) {
    const abbreviations = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return abbreviations[month - 1];
  }

  bool _isPM(String time) {
    final hour = int.parse(time.split(':')[0]);
    return hour >= 12;
  }
}
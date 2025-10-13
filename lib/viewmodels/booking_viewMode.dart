import 'package:intl/intl.dart';
import 'package:vistacall/data/models/doctor.dart';

class BookingViewModel {
  final DoctorModel doctor;

  BookingViewModel(this.doctor);

  // Helper method to safely convert List<dynamic> to List<String>
  List<String> _safeCastToStringList(dynamic value) {
    if (value is List) {
      return value.map((e) => e.toString()).toList();
    }
    return [];
  }

  // Generate available dates for the next 7 days based on doctor's available days
  List<DateTime> generateAvailableDates() {
    final now = DateTime.now();
    final daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final availableDays =
        _safeCastToStringList(doctor.availability['availableDays']);

    return List.generate(7, (index) {
      final currentDate = now.add(Duration(days: index));
      final dayAbbr = daysOfWeek[currentDate.weekday - 1];
      return availableDays.contains(dayAbbr) ? currentDate : null;
    }).whereType<DateTime>().toList();
  }

  // Count available time slots for a given date
  int countAvailableSlots(DateTime date) {
    final dayAbbr =
        ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][date.weekday - 1];
    final timeSlots = _safeCastToStringList(
        doctor.availability['availableTimeSlots'][dayAbbr] ?? []);
    return timeSlots.length;
  }

  // Get time slots for a given date
  List<String> getTimeSlots(DateTime date) {
    final dayAbbr =
        ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][date.weekday - 1];
    return _safeCastToStringList(
        doctor.availability['availableTimeSlots'][dayAbbr] ?? []);
  }

  // Format date for display (e.g., "Mon", "15", "Oct")
  Map<String, String> formatDate(DateTime date) {
    return {
      'weekday': _getWeekdayAbbreviation(date.weekday),
      'day': date.day.toString(),
      'month': getMonthName(date.month),
    };
  }

  Map<String, String> formatTimeSlot(String slot) {
    final parts = slot.split('-');
    if (parts.length != 2) {
      return {'displayTime': slot, 'period': ''};
    }
    final startTime = parts[0];
    final hour = int.parse(startTime.split(':')[0]);
    final isPM = hour >= 12;
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    final displayTime = '$displayHour:${startTime.split(':')[1]}';
    return {
      'displayTime': displayTime,
      'period': isPM ? 'PM' : 'AM',
    };
  }

  // Get current date for "Today" indicator
  Map<String, String> formatCurrentDate() {
    final now = DateTime.now();
    return {
      'day': now.day.toString(),
      'month': getMonthName(now.month),
    };
  }

  String _getWeekdayAbbreviation(int weekday) {
    const abbreviations = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return abbreviations[weekday - 1];
  }

  String getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/booking/booking_bloc.dart';
import 'package:vistacall/bloc/booking/booking_state.dart';
import 'package:vistacall/data/models/doctor.dart';
import 'package:vistacall/presentation/views/booking_conformation.dart';
import 'package:vistacall/presentation/widgets/bookappointments/date_widget.dart';
import 'package:vistacall/presentation/widgets/custom_textfield.dart';
import 'package:moon_icons/moon_icons.dart';

class BookAppointment extends StatelessWidget {
  final DoctorModel doctor;

  const BookAppointment({super.key, required this.doctor});

  // Helper method to safely convert List<dynamic> to List<String>
  List<String> _safeCastToStringList(dynamic value) {
    if (value is List) {
      return value.map((e) => e.toString()).toList();
    }
    return [];
  }

  List<DateTime> generateDatesForAvailableDays() {
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

  int countAvailableSlots(DateTime date) {
    final dayAbbr =
        ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][date.weekday - 1];
    final timeSlots = _safeCastToStringList(
        doctor.availability['availableTimeSlots'][dayAbbr]);
    return timeSlots.length;
  }

  @override
  Widget build(BuildContext context) {
    // final availableDates = generateDatesForAvailableDays();
    // final currentDate = DateTime.now();
    return BlocProvider(
      create: (context) => BookingBloc(),
      child: Builder(
        builder: (context) {
          final availableDates = generateDatesForAvailableDays();
          final currentDate = DateTime.now();
          return Scaffold(
            appBar: AppBar(
              title: Text('Dr. ${doctor.personal['fullName']}'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.local_hospital_rounded,
                            color: Colors.blueAccent),
                        SizedBox(width: 8),
                        Text(
                          'Clinic Visit Slots',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Purpose of consultation .",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    const CustomTextField(),
                    const SizedBox(height: 24),
                    const Text(
                      'Available Dates:',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 120,
                      child: BlocBuilder<BookingBloc, BookingState>(
                        builder: (context, state) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: availableDates.length,
                            itemBuilder: (context, index) {
                              final date = availableDates[index];
                              // final isSelected = false;
                              final isSelected = state.selectedDate == date;
                              return GestureDetector(
                                onTap: () {
                                  context
                                      .read<BookingBloc>()
                                      .add(SelectDate(date));
                                },
                                child: DateWidget(
                                  date: date,
                                  availableSlots: countAvailableSlots(date),
                                  isSelected: isSelected,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (availableDates.isNotEmpty)
                      Center(
                        child: Text(
                          'Today, ${currentDate.day} ${getMonthName(currentDate.month)}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    const Divider(
                      color: Color.fromARGB(255, 105, 102, 102),
                      thickness: 1,
                      height: 30,
                    ),
                    // if (availableDates.isNotEmpty)
                    BlocBuilder<BookingBloc, BookingState>(
                      builder: (context, state) {
                        return state.selectedDate != null
                            ? _buildTimeSlotsSection(context, state.selectedDate!)
                            : const SizedBox.shrink();
                        // _buildTimeSlotsSection(
                        //     context, availableDates.first)
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimeSlotsSection(BuildContext context, DateTime date) {
    final dayAbbr =
        ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][date.weekday - 1];
    final timeSlots = _safeCastToStringList(
        doctor.availability['availableTimeSlots'][dayAbbr]);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(' ${timeSlots.length} slot${timeSlots.length > 1 ? 's' : ''}'),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: timeSlots.map((slot) {
            final parts = slot.split('-');
            if (parts.length == 2) {
              final startTime = parts[0];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingConformation(
                        doctor: doctor,
                        selectedDate: date,
                        selectedSlot: slot,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 75,
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.transparent, width: 2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        startTime,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        startTime.contains('PM') ? 'PM' : 'AM',
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          }).toList(),
        ),
      ],
    );
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

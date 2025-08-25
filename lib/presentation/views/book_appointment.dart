// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vistacall/bloc/booking/booking_bloc.dart';
// import 'package:vistacall/bloc/booking/booking_state.dart';
// import 'package:vistacall/data/models/doctor.dart';
// import 'package:vistacall/presentation/views/booking_conformation.dart';
// import 'package:vistacall/presentation/widgets/bookappointments/date_widget.dart';
// import 'package:vistacall/presentation/widgets/custom_textfield.dart';
// import 'package:moon_icons/moon_icons.dart';

// class BookAppointment extends StatelessWidget {
//   final DoctorModel doctor;

//   const BookAppointment({super.key, required this.doctor});

//   // Helper method to safely convert List<dynamic> to List<String>
//   List<String> _safeCastToStringList(dynamic value) {
//     if (value is List) {
//       return value.map((e) => e.toString()).toList();
//     }
//     return [];
//   }

//   List<DateTime> generateDatesForAvailableDays() {
//     final now = DateTime.now();
//     final daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//     final availableDays =
//         _safeCastToStringList(doctor.availability['availableDays']);
//     return List.generate(7, (index) {
//       final currentDate = now.add(Duration(days: index));
//       final dayAbbr = daysOfWeek[currentDate.weekday - 1];
//       return availableDays.contains(dayAbbr) ? currentDate : null;
//     }).whereType<DateTime>().toList();
//   }

//   int countAvailableSlots(DateTime date) {
//     final dayAbbr =
//         ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][date.weekday - 1];
//     final timeSlots = _safeCastToStringList(
//         doctor.availability['availableTimeSlots'][dayAbbr]);
//     return timeSlots.length;
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final availableDates = generateDatesForAvailableDays();
//     // final currentDate = DateTime.now();
//     return BlocProvider(
//       create: (context) => BookingBloc(),
//       child: Builder(
//         builder: (context) {
//           final availableDates = generateDatesForAvailableDays();
//           final currentDate = DateTime.now();
//           return Scaffold(
//             appBar: AppBar(
//               title: Text('Dr. ${doctor.personal['fullName']}'),
//             ),
//             body: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Row(
//                       children: [
//                         Icon(Icons.local_hospital_rounded,
//                             color: Colors.blueAccent),
//                         SizedBox(width: 8),
//                         Text(
//                           'Clinic Visit Slots',
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 30),
//                     const Text(
//                       "Purpose of consultation .",
//                       style: TextStyle(fontSize: 16),
//                     ),
//                     const SizedBox(height: 16),
//                     const CustomTextField(),
//                     const SizedBox(height: 24),
//                     const Text(
//                       'Available Dates:',
//                       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                     ),
//                     const SizedBox(height: 8),
//                     SizedBox(
//                       height: 120,
//                       child: BlocBuilder<BookingBloc, BookingState>(
//                         builder: (context, state) {
//                           return ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemCount: availableDates.length,
//                             itemBuilder: (context, index) {
//                               final date = availableDates[index];
//                               // final isSelected = false;
//                               final isSelected = state.selectedDate == date;
//                               return GestureDetector(
//                                 onTap: () {
//                                   context
//                                       .read<BookingBloc>()
//                                       .add(SelectDate(date));
//                                 },
//                                 child: DateWidget(
//                                   date: date,
//                                   availableSlots: countAvailableSlots(date),
//                                   isSelected: isSelected,
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     if (availableDates.isNotEmpty)
//                       Center(
//                         child: Text(
//                           'Today, ${currentDate.day} ${getMonthName(currentDate.month)}',
//                           style: const TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     const Divider(
//                       color: Color.fromARGB(255, 105, 102, 102),
//                       thickness: 1,
//                       height: 30,
//                     ),
//                     // if (availableDates.isNotEmpty)
//                     BlocBuilder<BookingBloc, BookingState>(
//                       builder: (context, state) {
//                         return state.selectedDate != null
//                             ? _buildTimeSlotsSection(context, state.selectedDate!)
//                             : const SizedBox.shrink();
//                         // _buildTimeSlotsSection(
//                         //     context, availableDates.first)
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildTimeSlotsSection(BuildContext context, DateTime date) {
//     final dayAbbr =
//         ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][date.weekday - 1];
//     final timeSlots = _safeCastToStringList(
//         doctor.availability['availableTimeSlots'][dayAbbr]);
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Text(' ${timeSlots.length} slot${timeSlots.length > 1 ? 's' : ''}'),
//           ],
//         ),
//         const SizedBox(height: 8),
//         Wrap(
//           spacing: 8,
//           runSpacing: 8,
//           children: timeSlots.map((slot) {
//             final parts = slot.split('-');
//             if (parts.length == 2) {
//               final startTime = parts[0];
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => BookingConformation(
//                         doctor: doctor,
//                         selectedDate: date,
//                         selectedSlot: slot,
//                       ),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   width: 75,
//                   margin: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(color: Colors.transparent, width: 2),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         startTime,
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold, color: Colors.black),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         startTime.contains('PM') ? 'PM' : 'AM',
//                         style: const TextStyle(color: Colors.black),
//                       ),
//                       const SizedBox(height: 8),
//                     ],
//                   ),
//                 ),
//               );
//             }
//             return const SizedBox.shrink();
//           }).toList(),
//         ),
//       ],
//     );
//   }

//   String getMonthName(int month) {
//     const months = [
//       'Jan',
//       'Feb',
//       'Mar',
//       'Apr',
//       'May',
//       'Jun',
//       'Jul',
//       'Aug',
//       'Sep',
//       'Oct',
//       'Nov',
//       'Dec'
//     ];
//     return months[month - 1];
//   }
// }


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
    return BlocProvider(
      create: (context) => BookingBloc(),
      child: Builder(
        builder: (context) {
          final availableDates = generateDatesForAvailableDays();
          final currentDate = DateTime.now();
          return Scaffold(
            backgroundColor: const Color(0xFFF8FAFC),
            body: SafeArea(
              child: Column(
                children: [
                  _buildModernAppBar(context),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          _buildDoctorInfoCard(),
                          const SizedBox(height: 20),
                          _buildPurposeSection(),
                          const SizedBox(height: 30),
                          _buildAvailableDatesSection(context, availableDates),
                          const SizedBox(height: 20),
                          _buildTodayIndicator(currentDate),
                          const SizedBox(height: 30),
                          BlocBuilder<BookingBloc, BookingState>(
                            builder: (context, state) {
                              return state.selectedDate != null
                                  ? _buildTimeSlotsSection(context, state.selectedDate!)
                                  : _buildSelectDatePrompt();
                            },
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildModernAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Book Appointment',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Dr. ${doctor.personal['fullName']}',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorInfoCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.local_hospital_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Clinic Visit Slots',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Select your preferred date and time',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPurposeSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.description_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Purpose of Consultation',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const CustomTextField(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailableDatesSection(BuildContext context, List<DateTime> availableDates) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF9C27B0), Color(0xFFBA68C8)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.calendar_today_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Available Dates',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Text(
                    '${availableDates.length} days',
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 120,
              child: BlocBuilder<BookingBloc, BookingState>(
                builder: (context, state) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    itemCount: availableDates.length,
                    itemBuilder: (context, index) {
                      final date = availableDates[index];
                      final isSelected = state.selectedDate == date;
                      return GestureDetector(
                        onTap: () {
                          context.read<BookingBloc>().add(SelectDate(date));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          child: _buildModernDateWidget(
                            date: date,
                            availableSlots: countAvailableSlots(date),
                            isSelected: isSelected,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernDateWidget({
    required DateTime date,
    required int availableSlots,
    required bool isSelected,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 85,
      decoration: BoxDecoration(
        gradient: isSelected
            ? const LinearGradient(
                colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: isSelected ? null : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? Colors.transparent : Colors.grey.shade300,
          width: 1,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: const Color(0xFF2196F3).withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _getWeekdayAbbreviation(date.weekday),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white70 : Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${date.day}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              getMonthName(date.month),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white70 : Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.2)
                    : Colors.green.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$availableSlots slot${availableSlots > 1 ? 's' : ''}',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : Colors.green.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodayIndicator(DateTime currentDate) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.orange.shade50,
            Colors.orange.shade100.withOpacity(0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.today_rounded,
              color: Colors.orange.shade700,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Today, ${currentDate.day} ${getMonthName(currentDate.month)}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.orange.shade800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectDatePrompt() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.schedule_rounded,
              size: 40,
              color: Colors.blue.shade600,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Select a Date',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Choose an available date above to see time slots',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlotsSection(BuildContext context, DateTime date) {
    final dayAbbr =
        ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][date.weekday - 1];
    final timeSlots = _safeCastToStringList(
        doctor.availability['availableTimeSlots'][dayAbbr]);
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF9800), Color(0xFFFFB74D)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.access_time_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Available Time Slots',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Text(
                    '${timeSlots.length} slot${timeSlots.length > 1 ? 's' : ''}',
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: timeSlots.map((slot) {
                final parts = slot.split('-');
                if (parts.length == 2) {
                  final startTime = parts[0];
                  final hour = int.parse(startTime.split(':')[0]);
                  final isPM = hour >= 12;
                  final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
                  final displayTime = '${displayHour}:${startTime.split(':')[1]}';
                  
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
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.grey.shade100,
                            Colors.grey.shade50,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            displayTime,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: isPM ? Colors.orange.shade100 : Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              isPM ? 'PM' : 'AM',
                              style: TextStyle(
                                color: isPM ? Colors.orange.shade700 : Colors.blue.shade700,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  String _getWeekdayAbbreviation(int weekday) {
    const abbreviations = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return abbreviations[weekday - 1];
  }

  String getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
}
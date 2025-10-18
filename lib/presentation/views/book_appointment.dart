// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vistacall/bloc/booking/booking_bloc.dart';
// import 'package:vistacall/bloc/booking/booking_state.dart';
// import 'package:vistacall/data/models/doctor.dart';
// import 'package:vistacall/presentation/views/booking_conformation.dart';
// import 'package:vistacall/presentation/widgets/custom_textfield.dart';
// import 'package:vistacall/viewmodels/booking_viewMode.dart';

// class BookAppointment extends StatelessWidget {
//   final DoctorModel doctor;

//   const BookAppointment({super.key, required this.doctor});

//   @override
//   Widget build(BuildContext context) {
//     final viewModel = BookingViewModel(doctor);
//     return BlocProvider(
//       create: (context) => BookingBloc(),
//       child: Builder(
//         builder: (context) {
//           final availableDates = viewModel.generateAvailableDates();
//           final currentDate = viewModel.formatCurrentDate();
//           return Scaffold(
//             backgroundColor: const Color(0xFFF8FAFC),
//             body: SafeArea(
//               child: Column(
//                 children: [
//                   _buildModernAppBar(context),
//                   Expanded(
//                     child: SingleChildScrollView(
//                       physics: const BouncingScrollPhysics(),
//                       child: Column(
//                         children: [
//                           const SizedBox(height: 20),
//                           _buildDoctorInfoCard(),
//                           const SizedBox(height: 20),
//                           // _buildPurposeSection(),
//                           // const SizedBox(height: 30),
//                           _buildAvailableDatesSection(
//                               context, viewModel, availableDates),
//                           const SizedBox(height: 20),
//                           _buildTodayIndicator(currentDate),
//                           const SizedBox(height: 30),
//                           BlocBuilder<BookingBloc, BookingState>(
//                             builder: (context, state) {
//                               return state.selectedDate != null
//                                   ? _buildTimeSlotsSection(
//                                       context, viewModel, state.selectedDate!)
//                                   : _buildSelectDatePrompt();
//                             },
//                           ),
//                           const SizedBox(height: 50),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildModernAppBar(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: Row(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: IconButton(
//               onPressed: () => Navigator.of(context).pop(),
//               icon: const Icon(
//                 Icons.arrow_back_ios_new,
//                 color: Colors.white,
//                 size: 20,
//               ),
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Book Appointment',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   'Dr. ${doctor.personal['fullName']}',
//                   style: const TextStyle(
//                     color: Colors.white70,
//                     fontSize: 16,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDoctorInfoCard() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 20,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
//                 ),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: const Icon(
//                 Icons.local_hospital_rounded,
//                 color: Colors.white,
//                 size: 24,
//               ),
//             ),
//             const SizedBox(width: 16),
//             const Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Clinic Visit Slots',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     'Select your preferred date and time',
//                     style: TextStyle(
//                       color: Colors.grey,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAvailableDatesSection(BuildContext context,
//       BookingViewModel viewModel, List<DateTime> availableDates) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 20,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     gradient: const LinearGradient(
//                       colors: [Color(0xFF9C27B0), Color(0xFFBA68C8)],
//                     ),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: const Icon(
//                     Icons.calendar_today_rounded,
//                     color: Colors.white,
//                     size: 20,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 const Text(
//                   'Available Dates',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 18,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 const Spacer(),
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: Colors.green.shade50,
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(color: Colors.green.shade200),
//                   ),
//                   child: Text(
//                     '${availableDates.length} days',
//                     style: TextStyle(
//                       color: Colors.green.shade700,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             SizedBox(
//               height: 120,
//               child: BlocBuilder<BookingBloc, BookingState>(
//                 builder: (context, state) {
//                   return ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     padding: const EdgeInsets.symmetric(horizontal: 4),
//                     itemCount: availableDates.length,
//                     itemBuilder: (context, index) {
//                       final date = availableDates[index];
//                       final isSelected = state.selectedDate == date;
//                       return GestureDetector(
//                         onTap: () {
//                           context.read<BookingBloc>().add(SelectDate(date));
//                         },
//                         child: Container(
//                           margin: const EdgeInsets.only(right: 12),
//                           child: _buildModernDateWidget(
//                             viewModel: viewModel,
//                             date: date,
//                             availableSlots: viewModel.countAvailableSlots(date),
//                             isSelected: isSelected,
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildModernDateWidget({
//     required BookingViewModel viewModel,
//     required DateTime date,
//     required int availableSlots,
//     required bool isSelected,
//   }) {
//     final dateInfo = viewModel.formatDate(date);
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 200),
//       width: 85,
//       height: 120,
//       decoration: BoxDecoration(
//         gradient: isSelected
//             ? const LinearGradient(
//                 colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               )
//             : null,
//         color: isSelected ? null : Colors.grey.shade100,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: isSelected ? Colors.transparent : Colors.grey.shade300,
//           width: 1,
//         ),
//         boxShadow: isSelected
//             ? [
//                 BoxShadow(
//                   color: const Color(0xFF2196F3).withOpacity(0.3),
//                   blurRadius: 12,
//                   offset: const Offset(0, 6),
//                 ),
//               ]
//             : [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 8,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               dateInfo['weekday']!,
//               style: TextStyle(
//                 fontSize: 10,
//                 fontWeight: FontWeight.w500,
//                 color: isSelected ? Colors.white70 : Colors.grey.shade600,
//               ),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//             const SizedBox(height: 2),
//             Text(
//               dateInfo['day']!,
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w700,
//                 color: isSelected ? Colors.white : Colors.black87,
//               ),
//             ),
//             const SizedBox(height: 2),
//             Text(
//               dateInfo['month']!,
//               style: TextStyle(
//                 fontSize: 10,
//                 fontWeight: FontWeight.w500,
//                 color: isSelected ? Colors.white70 : Colors.grey.shade600,
//               ),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//             const SizedBox(height: 4),
//             Container(
//               constraints: const BoxConstraints(maxWidth: 70),
//               padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
//               decoration: BoxDecoration(
//                 color: isSelected
//                     ? Colors.white.withOpacity(0.2)
//                     : Colors.green.shade50,
//                 borderRadius: BorderRadius.circular(6),
//               ),
//               child: Text(
//                 '$availableSlots slot${availableSlots > 1 ? 's' : ''}',
//                 style: TextStyle(
//                   fontSize: 8,
//                   fontWeight: FontWeight.w600,
//                   color: isSelected ? Colors.white : Colors.green.shade700,
//                 ),
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTodayIndicator(Map<String, String> currentDate) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             Colors.orange.shade50,
//             Colors.orange.shade100.withOpacity(0.3),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.orange.shade200),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.orange.shade100,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Icon(
//               Icons.today_rounded,
//               color: Colors.orange.shade700,
//               size: 20,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Text(
//             'Today, ${currentDate['day']} ${currentDate['month']}',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//               color: Colors.orange.shade800,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSelectDatePrompt() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       padding: const EdgeInsets.all(30),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 20,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.blue.shade50,
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               Icons.schedule_rounded,
//               size: 40,
//               color: Colors.blue.shade600,
//             ),
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'Select a Date',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.w600,
//               color: Colors.grey.shade800,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Choose an available date above to see time slots',
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey.shade600,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTimeSlotsSection(
//       BuildContext context, BookingViewModel viewModel, DateTime date) {
//     final timeSlots = viewModel.getTimeSlots(date);
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 20,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                         colors: [Color(0xFFFF9800), Color(0xFFFFB74D)],
//                       ),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: const Icon(
//                       Icons.access_time_rounded,
//                       color: Colors.white,
//                       size: 20,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   const Expanded(
//                     child: Text(
//                       'Available Time Slots',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 18,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: Colors.blue.shade50,
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(color: Colors.blue.shade200),
//                     ),
//                     child: Text(
//                       '${timeSlots.length} slot${timeSlots.length > 1 ? 's' : ''}',
//                       style: TextStyle(
//                         color: Colors.blue.shade700,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               Wrap(
//                 spacing: 12,
//                 runSpacing: 12,
//                 children: timeSlots.map((slot) {
//                   final timeInfo = viewModel.formatTimeSlot(slot);
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => BookingConformation(
//                             doctor: doctor,
//                             selectedDate: date,
//                             selectedSlot: slot,
//                           ),
//                         ),
//                       );
//                     },
//                     child: AnimatedContainer(
//                       duration: const Duration(milliseconds: 200),
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 16, horizontal: 20),
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [
//                             Colors.grey.shade100,
//                             Colors.grey.shade50,
//                           ],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(16),
//                         border: Border.all(color: Colors.grey.shade300),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.05),
//                             blurRadius: 8,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             timeInfo['displayTime']!,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.w700,
//                               fontSize: 16,
//                               color: Colors.black87,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 8, vertical: 2),
//                             decoration: BoxDecoration(
//                               color: timeInfo['period'] == 'PM'
//                                   ? Colors.orange.shade100
//                                   : Colors.blue.shade100,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Text(
//                               timeInfo['period']!,
//                               style: TextStyle(
//                                 color: timeInfo['period'] == 'PM'
//                                     ? Colors.orange.shade700
//                                     : Colors.blue.shade700,
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/booking/booking_bloc.dart';
import 'package:vistacall/bloc/booking/booking_state.dart';
import 'package:vistacall/data/models/doctor.dart';
import 'package:vistacall/presentation/views/booking_conformation.dart';
import 'package:vistacall/presentation/widgets/custom_textfield.dart';
import 'package:vistacall/viewmodels/booking_viewMode.dart';

class BookAppointment extends StatelessWidget {
  final DoctorModel doctor;

  const BookAppointment({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final viewModel = BookingViewModel(doctor);

    return BlocProvider(
      create: (context) => BookingBloc(),
      child: Builder(
        builder: (context) {
          final availableDates = viewModel.generateAvailableDates();
          final currentDate = viewModel.formatCurrentDate();
          return Scaffold(
            backgroundColor: colorScheme.surface, // Dynamic background
            body: SafeArea(
              child: Column(
                children: [
                  _buildModernAppBar(context, theme, colorScheme),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          _buildDoctorInfoCard(context, theme, colorScheme),
                          const SizedBox(height: 20),
                          _buildAvailableDatesSection(context, viewModel,
                              availableDates, theme, colorScheme),
                          const SizedBox(height: 20),
                          _buildTodayIndicator(
                              context, theme, colorScheme, currentDate),
                          const SizedBox(height: 30),
                          BlocBuilder<BookingBloc, BookingState>(
                            builder: (context, state) {
                              return state.selectedDate != null
                                  ? _buildTimeSlotsSection(context, viewModel,
                                      state.selectedDate!, theme, colorScheme)
                                  : _buildSelectDatePrompt(
                                      context, theme, colorScheme);
                            },
                          ),
                          const SizedBox(height: 50),
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

  Widget _buildModernAppBar(
      BuildContext context, ThemeData theme, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.primary, colorScheme.primaryContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: colorScheme.onPrimary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: colorScheme.onPrimary,
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
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontSize: 26,
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Dr. ${doctor.personal['fullName']}',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onPrimary.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorInfoCard(
      BuildContext context, ThemeData theme, ColorScheme colorScheme) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: colorScheme.surface, // Dynamic white surface
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: .3), // Dynamic shadow
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
                gradient: LinearGradient(
                  colors: [colorScheme.primary, colorScheme.primaryContainer],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.local_hospital_rounded,
                color: colorScheme.onPrimary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Clinic Visit Slots',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Select your preferred date and time',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
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

  Widget _buildAvailableDatesSection(
      BuildContext context,
      BookingViewModel viewModel,
      List<DateTime> availableDates,
      ThemeData theme,
      ColorScheme colorScheme) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: .3),
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
                    gradient: LinearGradient(
                      colors: [
                        colorScheme.secondary,
                        colorScheme.secondaryContainer
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.calendar_today_rounded,
                    color: colorScheme.onSecondary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Available Dates',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: colorScheme.tertiaryContainer,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: colorScheme.outlineVariant),
                  ),
                  child: Text(
                    '${availableDates.length} days',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colorScheme.onTertiaryContainer,
                      fontWeight: FontWeight.w600,
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
                            context: context,
                            viewModel: viewModel,
                            date: date,
                            availableSlots: viewModel.countAvailableSlots(date),
                            isSelected: isSelected,
                            theme: theme,
                            colorScheme: colorScheme,
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
    required BuildContext context,
    required BookingViewModel viewModel,
    required DateTime date,
    required int availableSlots,
    required bool isSelected,
    required ThemeData theme,
    required ColorScheme colorScheme,
  }) {
    final dateInfo = viewModel.formatDate(date);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 85,
      height: 120,
      decoration: BoxDecoration(
        gradient: isSelected
            ? LinearGradient(
                colors: [colorScheme.primary, colorScheme.primaryContainer],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: isSelected ? null : colorScheme.surfaceVariant.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? Colors.transparent : colorScheme.outline.withValues(alpha: .3),
          width: 1,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: colorScheme.primary.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ]
            : [
                BoxShadow(
                  color: theme.shadowColor.withValues(alpha: .05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              dateInfo['weekday']!,
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? colorScheme.onPrimary.withOpacity(0.7)
                    : colorScheme.onSurfaceVariant,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              dateInfo['day']!,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color:
                    isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              dateInfo['month']!,
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? colorScheme.onPrimary.withOpacity(0.7)
                    : colorScheme.onSurfaceVariant,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Container(
              constraints: const BoxConstraints(maxWidth: 70),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: isSelected
                    ? colorScheme.onPrimary.withOpacity(0.2)
                    : colorScheme.tertiaryContainer,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '$availableSlots slot${availableSlots > 1 ? 's' : ''}',
                style: theme.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? colorScheme.onPrimary
                      : colorScheme.onTertiaryContainer,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodayIndicator(BuildContext context, ThemeData theme,
      ColorScheme colorScheme, Map<String, String> currentDate) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.tertiaryContainer,
            colorScheme.tertiaryContainer.withOpacity(0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: colorScheme.tertiaryContainer.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.today_rounded,
              color: colorScheme.onTertiaryContainer,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Today, ${currentDate['day']} ${currentDate['month']}',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onTertiaryContainer,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectDatePrompt(
      BuildContext context, ThemeData theme, ColorScheme colorScheme) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: .3),
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
              color: colorScheme.primaryContainer.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.schedule_rounded,
              size: 40,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Select a Date',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Choose an available date above to see time slots',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlotsSection(
      BuildContext context,
      BookingViewModel viewModel,
      DateTime date,
      ThemeData theme,
      ColorScheme colorScheme) {
    final timeSlots = viewModel.getTimeSlots(date);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: .3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          colorScheme.secondaryContainer,
                          colorScheme.secondary
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.access_time_rounded,
                      color: colorScheme.onSecondaryContainer,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Available Time Slots',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: colorScheme.outline),
                    ),
                    child: Text(
                      '${timeSlots.length} slot${timeSlots.length > 1 ? 's' : ''}',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w600,
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
                  final timeInfo = viewModel.formatTimeSlot(slot);
                  final isPM = timeInfo['period'] == 'PM';
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            colorScheme.surfaceVariant.withOpacity(0.3),
                            colorScheme.surfaceVariant.withOpacity(0.1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: colorScheme.outline.withValues(alpha: .3)),
                        boxShadow: [
                          BoxShadow(
                            color: theme.shadowColor.withValues(alpha: .05),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            timeInfo['displayTime']!,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: isPM
                                  ? colorScheme.secondaryContainer
                                  : colorScheme.primaryContainer
                                      .withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              timeInfo['period']!,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: isPM
                                    ? colorScheme.onSecondaryContainer
                                    : colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}















// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vistacall/bloc/booking/booking_bloc.dart';
// import 'package:vistacall/bloc/booking/booking_state.dart';
// import 'package:vistacall/data/models/doctor.dart';
// import 'package:vistacall/presentation/views/booking_conformation.dart';
// import 'package:vistacall/presentation/widgets/custom_textfield.dart';
// import 'package:intl/intl.dart';

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

//     final formatter = DateFormat('dd-MM-yyyy HH:mm:ss.SSS');
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
//     return BlocProvider(
//       create: (context) => BookingBloc(),
//       child: Builder(
//         builder: (context) {
//           final availableDates = generateDatesForAvailableDays();
//           final currentDate = DateTime.now();
//           return Scaffold(
//             backgroundColor: const Color(0xFFF8FAFC),
//             body: SafeArea(
//               child: Column(
//                 children: [
//                   _buildModernAppBar(context),
//                   Expanded(
//                     child: SingleChildScrollView(
//                       physics: const BouncingScrollPhysics(),
//                       child: Column(
//                         children: [
//                           const SizedBox(height: 20),
//                           _buildDoctorInfoCard(),
//                           const SizedBox(height: 20),
//                           _buildPurposeSection(),
//                           const SizedBox(height: 30),
//                           _buildAvailableDatesSection(context, availableDates),
//                           const SizedBox(height: 20),
//                           _buildTodayIndicator(currentDate),
//                           const SizedBox(height: 30),
//                           BlocBuilder<BookingBloc, BookingState>(
//                             builder: (context, state) {
//                               return state.selectedDate != null
//                                   ? _buildTimeSlotsSection(
//                                       context, state.selectedDate!)
//                                   : _buildSelectDatePrompt();
//                             },
//                           ),
//                           const SizedBox(
//                               height:
//                                   50), // Added extra padding to prevent overflow
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildModernAppBar(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: Row(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: IconButton(
//               onPressed: () => Navigator.of(context).pop(),
//               icon: const Icon(
//                 Icons.arrow_back_ios_new,
//                 color: Colors.white,
//                 size: 20,
//               ),
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Book Appointment',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   'Dr. ${doctor.personal['fullName']}',
//                   style: const TextStyle(
//                     color: Colors.white70,
//                     fontSize: 16,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDoctorInfoCard() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 20,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
//                 ),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: const Icon(
//                 Icons.local_hospital_rounded,
//                 color: Colors.white,
//                 size: 24,
//               ),
//             ),
//             const SizedBox(width: 16),
//             const Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Clinic Visit Slots',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     'Select your preferred date and time',
//                     style: TextStyle(
//                       color: Colors.grey,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPurposeSection() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 20,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     gradient: const LinearGradient(
//                       colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
//                     ),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: const Icon(
//                     Icons.description_rounded,
//                     color: Colors.white,
//                     size: 20,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 const Text(
//                   'Purpose of Consultation',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 18,
//                     color: Colors.black87,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade50,
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//               child: const CustomTextField(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAvailableDatesSection(
//       BuildContext context, List<DateTime> availableDates) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 20,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     gradient: const LinearGradient(
//                       colors: [Color(0xFF9C27B0), Color(0xFFBA68C8)],
//                     ),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: const Icon(
//                     Icons.calendar_today_rounded,
//                     color: Colors.white,
//                     size: 20,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 const Text(
//                   'Available Dates',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 18,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 const Spacer(),
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: Colors.green.shade50,
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(color: Colors.green.shade200),
//                   ),
//                   child: Text(
//                     '${availableDates.length} days',
//                     style: TextStyle(
//                       color: Colors.green.shade700,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             SizedBox(
//               height: 120,
//               child: BlocBuilder<BookingBloc, BookingState>(
//                 builder: (context, state) {
//                   return ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     padding: const EdgeInsets.symmetric(horizontal: 4),
//                     itemCount: availableDates.length,
//                     itemBuilder: (context, index) {
//                       final date = availableDates[index];
//                       final isSelected = state.selectedDate == date;
//                       return GestureDetector(
//                         onTap: () {
//                           context.read<BookingBloc>().add(SelectDate(date));
//                         },
//                         child: Container(
//                           margin: const EdgeInsets.only(right: 12),
//                           child: _buildModernDateWidget(
//                             date: date,
//                             availableSlots: countAvailableSlots(date),
//                             isSelected: isSelected,
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildModernDateWidget({
//     required DateTime date,
//     required int availableSlots,
//     required bool isSelected,
//   }) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 200),
//       width: 85,
//       height: 120,
//       decoration: BoxDecoration(
//         gradient: isSelected
//             ? const LinearGradient(
//                 colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               )
//             : null,
//         color: isSelected ? null : Colors.grey.shade100,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: isSelected ? Colors.transparent : Colors.grey.shade300,
//           width: 1,
//         ),
//         boxShadow: isSelected
//             ? [
//                 BoxShadow(
//                   color: const Color(0xFF2196F3).withOpacity(0.3),
//                   blurRadius: 12,
//                   offset: const Offset(0, 6),
//                 ),
//               ]
//             : [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 8,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               _getWeekdayAbbreviation(date.weekday),
//               style: TextStyle(
//                 fontSize: 10,
//                 fontWeight: FontWeight.w500,
//                 color: isSelected ? Colors.white70 : Colors.grey.shade600,
//               ),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//             const SizedBox(height: 2),
//             Text(
//               '${date.day}',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w700,
//                 color: isSelected ? Colors.white : Colors.black87,
//               ),
//             ),
//             const SizedBox(height: 2),
//             Text(
//               getMonthName(date.month),
//               style: TextStyle(
//                 fontSize: 10,
//                 fontWeight: FontWeight.w500,
//                 color: isSelected ? Colors.white70 : Colors.grey.shade600,
//               ),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//             const SizedBox(height: 4),
//             Container(
//               constraints: BoxConstraints(maxWidth: 70),
//               padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
//               decoration: BoxDecoration(
//                 color: isSelected
//                     ? Colors.white.withOpacity(0.2)
//                     : Colors.green.shade50,
//                 borderRadius: BorderRadius.circular(6),
//               ),
//               child: Text(
//                 '$availableSlots slot${availableSlots > 1 ? 's' : ''}',
//                 style: TextStyle(
//                   fontSize: 8,
//                   fontWeight: FontWeight.w600,
//                   color: isSelected ? Colors.white : Colors.green.shade700,
//                 ),
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTodayIndicator(DateTime currentDate) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             Colors.orange.shade50,
//             Colors.orange.shade100.withOpacity(0.3),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.orange.shade200),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.orange.shade100,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Icon(
//               Icons.today_rounded,
//               color: Colors.orange.shade700,
//               size: 20,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Text(
//             'Today, ${currentDate.day} ${getMonthName(currentDate.month)}',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//               color: Colors.orange.shade800,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSelectDatePrompt() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       padding: const EdgeInsets.all(30),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 20,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.blue.shade50,
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               Icons.schedule_rounded,
//               size: 40,
//               color: Colors.blue.shade600,
//             ),
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'Select a Date',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.w600,
//               color: Colors.grey.shade800,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Choose an available date above to see time slots',
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey.shade600,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTimeSlotsSection(BuildContext context, DateTime date) {
//     final dayAbbr =
//         ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][date.weekday - 1];
//     final timeSlots = _safeCastToStringList(
//         doctor.availability['availableTimeSlots'][dayAbbr]);

//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 20,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                         colors: [Color(0xFFFF9800), Color(0xFFFFB74D)],
//                       ),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: const Icon(
//                       Icons.access_time_rounded,
//                       color: Colors.white,
//                       size: 20,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   const Expanded(
//                     child: Text(
//                       'Available Time Slots',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 18,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ),
//                   const Spacer(),
//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: Colors.blue.shade50,
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(color: Colors.blue.shade200),
//                     ),
//                     child: Text(
//                       '${timeSlots.length} slot${timeSlots.length > 1 ? 's' : ''}',
//                       style: TextStyle(
//                         color: Colors.blue.shade700,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               Wrap(
//                 spacing: 12,
//                 runSpacing: 12,
//                 children: timeSlots.map((slot) {
//                   final parts = slot.split('-');
//                   if (parts.length == 2) {
//                     final startTime = parts[0];
//                     final hour = int.parse(startTime.split(':')[0]);
//                     final isPM = hour >= 12;
//                     final displayHour =
//                         hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
//                     final displayTime =
//                         '${displayHour}:${startTime.split(':')[1]}';

//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => BookingConformation(
//                               doctor: doctor,
//                               selectedDate: date,
//                               selectedSlot: slot,
//                             ),
//                           ),
//                         );
//                       },
//                       child: AnimatedContainer(
//                         duration: const Duration(milliseconds: 200),
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 16, horizontal: 20),
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               Colors.grey.shade100,
//                               Colors.grey.shade50,
//                             ],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                           borderRadius: BorderRadius.circular(16),
//                           border: Border.all(color: Colors.grey.shade300),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.05),
//                               blurRadius: 8,
//                               offset: const Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               displayTime,
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 16,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 8, vertical: 2),
//                               decoration: BoxDecoration(
//                                 color: isPM
//                                     ? Colors.orange.shade100
//                                     : Colors.blue.shade100,
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Text(
//                                 isPM ? 'PM' : 'AM',
//                                 style: TextStyle(
//                                   color: isPM
//                                       ? Colors.orange.shade700
//                                       : Colors.blue.shade700,
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }
//                   return const SizedBox.shrink();
//                 }).toList(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   String _getWeekdayAbbreviation(int weekday) {
//     const abbreviations = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//     return abbreviations[weekday - 1];
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
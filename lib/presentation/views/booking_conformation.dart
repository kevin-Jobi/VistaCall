// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vistacall/bloc/add_patient/patient_bloc.dart';
// import 'package:vistacall/bloc/payment/payment_bloc.dart';
// import 'package:vistacall/bloc/payment/payment_event.dart';
// import 'package:vistacall/data/models/doctor.dart';
// import 'package:vistacall/presentation/views/booking_successpage.dart';
// import 'package:vistacall/presentation/widgets/bookappointments/add_patient.dart';

// class BookingConformation extends StatelessWidget {
//   final DoctorModel doctor;
//   final DateTime? selectedDate;
//   final String? selectedSlot;

//   const BookingConformation({
//     super.key,
//     required this.doctor,
//     this.selectedDate,
//     this.selectedSlot,
//   });

//   String getTimeDifference() {
//     if (selectedDate == null || selectedSlot == null) return 'N/A';
//     final now = DateTime.now();
//     final slotParts = selectedSlot!.split('-');
//     if (slotParts.length != 2) return 'N/A';
//     final startTime = slotParts[0].split(':');
//     if (startTime.length != 2) return 'N/A';
//     final appointmentTime = DateTime(
//       selectedDate!.year,
//       selectedDate!.month,
//       selectedDate!.day,
//       int.parse(startTime[0]),
//       int.parse(startTime[1]),
//     );
//     final difference = appointmentTime.difference(now);
//     if (difference.isNegative) return 'Past due';
//     final hours = difference.inHours;
//     final minutes = difference.inMinutes.remainder(60);
//     return 'in $hours hours and $minutes min';
//   }

//   @override
//   Widget build(BuildContext context) {
//     String? selectedPatientName;
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (context) => PaymentBloc()),
//         BlocProvider(create: (context) => PatientBloc()..add(LoadPatients())),
//       ],
//       child: Builder(builder: (context) {
//         return BlocListener<PaymentBloc, PaymentState>(
//           listener: (context, state) {
//             if (state is PaymentSuccess) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Booking confirmed!')),
//               );
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => BookingSuccessPage(
//                     doctor: state.doctor!,
//                     selectedDate: state.selectedDate!,
//                     selectedSlot: state.selectedSlot!,
//                     paymentMethod: state.paymentMethod!,
//                   ),
//                 ),
//               );
//             } else if (state is PaymentError) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text(state.error)),
//               );
//             }
//           },
//           child: Scaffold(
//             backgroundColor: const Color(0xFFF8FAFC),
//             appBar: _buildModernAppBar(context),
//             body: SafeArea(
//               child: SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 20),
//                     _buildDoctorCard(context),
//                     const SizedBox(height: 20),
//                     _buildAppointmentCard(context),
//                     const SizedBox(height: 20),
//                     _buildVistaCallPromise(context),
//                     const SizedBox(height: 30),
//                     _buildPaymentSection(context),
//                     const SizedBox(height: 30),
//                     _buildBillDetails(context),
//                     const SizedBox(height: 30),
//                     _buildPatientInfo(context, selectedPatientName),
//                     const SizedBox(height: 30),
//                     _buildConfirmButton(context, selectedPatientName),
//                     const SizedBox(height: 30),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       }),
//     );
//   }

//   PreferredSizeWidget _buildModernAppBar(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       leading: IconButton(
//         onPressed: () => Navigator.of(context).pop(),
//         icon: Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: Colors.grey.shade100,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: const Icon(
//             Icons.arrow_back_ios_new,
//             size: 18,
//             color: Colors.black87,
//           ),
//         ),
//       ),
//       title: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               gradient: const LinearGradient(
//                 colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
//               ),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: const Icon(
//               Icons.local_hospital_rounded,
//               color: Colors.white,
//               size: 20,
//             ),
//           ),
//           const SizedBox(width: 12),
//           const Expanded(
//             child: Text(
//               'Booking Confirmation',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black87,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDoctorCard(BuildContext context) {
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
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.blue.withOpacity(0.3),
//                     blurRadius: 15,
//                     offset: const Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: CircleAvatar(
//                 radius: 35,
//                 backgroundColor: Colors.grey.shade300,
//                 backgroundImage:
//                     const AssetImage('assets/images/generalphysician.png'),
//                 child: const Icon(
//                   Icons.person,
//                   color: Colors.white,
//                   size: 30,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Dr. ${doctor.personal['fullName'] as String}',
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w700,
//                       fontSize: 20,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: Colors.green.shade50,
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(color: Colors.green.shade200),
//                     ),
//                     child: Text(
//                       doctor.personal['department'],
//                       style: TextStyle(
//                         color: Colors.green.shade700,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.location_on_rounded,
//                         size: 16,
//                         color: Colors.grey.shade600,
//                       ),
//                       const SizedBox(width: 4),
//                       Expanded(
//                         child: Text(
//                           doctor.personal['hospitalName'],
//                           style: TextStyle(
//                             color: Colors.grey.shade600,
//                             fontSize: 14,
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAppointmentCard(BuildContext context) {
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
//                     Icons.access_time_rounded,
//                     color: Colors.white,
//                     size: 20,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 const Text(
//                   'Appointment Time',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 18,
//                     color: Colors.black87,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Colors.green.shade50,
//                     Colors.green.shade100.withOpacity(0.3),
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: Colors.green.shade200),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.calendar_today_rounded,
//                         size: 18,
//                         color: Colors.green.shade700,
//                       ),
//                       const SizedBox(width: 8),
//                       Text(
//                         selectedDate != null && selectedSlot != null
//                             ? '${_getWeekdayAbbreviation(selectedDate!.weekday)}, ${selectedDate!.day} ${_getMonthAbbreviation(selectedDate!.month)} ${selectedSlot!.split('-')[0]} ${_isPM(selectedSlot!.split('-')[0]) ? 'PM' : 'AM'}'
//                             : 'Mon, 18 Aug 12:30 PM',
//                         style: TextStyle(
//                           color: Colors.green.shade800,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.timer_outlined,
//                         size: 18,
//                         color: Colors.grey.shade600,
//                       ),
//                       const SizedBox(width: 8),
//                       Text(
//                         selectedDate != null && selectedSlot != null
//                             ? getTimeDifference()
//                             : 'in 21 hours and 13 min',
//                         style: TextStyle(
//                           color: Colors.grey.shade700,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildVistaCallPromise(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             const Color(0xFF9C27B0).withOpacity(0.1),
//             const Color(0xFFBA68C8).withOpacity(0.05),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: const Color(0xFF9C27B0).withOpacity(0.3)),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               gradient: const LinearGradient(
//                 colors: [Color(0xFF9C27B0), Color(0xFFBA68C8)],
//               ),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: const Icon(
//               Icons.verified_rounded,
//               color: Colors.white,
//               size: 20,
//             ),
//           ),
//           const SizedBox(width: 12),
//           const Text(
//             'VistaCall Promise',
//             style: TextStyle(
//               color: Color(0xFF9C27B0),
//               fontWeight: FontWeight.w600,
//               fontSize: 16,
//             ),
//           ),
//           const Spacer(),
//           Icon(
//             Icons.info_outline_rounded,
//             color: const Color(0xFF9C27B0).withOpacity(0.7),
//             size: 20,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPaymentSection(BuildContext context) {
//     return BlocBuilder<PaymentBloc, PaymentState>(
//       builder: (context, state) {
//         final selectedPayment =
//             state is PaymentSelected ? state.paymentMethod : null;
//         return Container(
//           margin: const EdgeInsets.symmetric(horizontal: 20),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.08),
//                 blurRadius: 20,
//                 offset: const Offset(0, 8),
//               ),
//             ],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
//                         ),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: const Icon(
//                         Icons.payment_rounded,
//                         color: Colors.white,
//                         size: 20,
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     const Text(
//                       'Payment Method',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 18,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 _buildPaymentOption(
//                     context,
//                     'Pay Online',
//                     Icons.credit_card_rounded,
//                     Colors.blue,
//                     'Secure & Quick',
//                     selectedPayment),
//                 const SizedBox(height: 12),
//                 _buildPaymentOption(
//                     context,
//                     'Pay At Clinic',
//                     Icons.store_rounded,
//                     Colors.orange,
//                     'Pay when you visit',
//                     selectedPayment),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildPaymentOption(BuildContext context, String title, IconData icon,
//       Color color, String subtitle, String? selectedPayment) {
//     final isSelected = selectedPayment == title;
//     return GestureDetector(
//       onTap: () {
//         print('Payment option selected: $title');
//         context.read<PaymentBloc>().add(SelectPayment(title));
//       },
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: isSelected ? color.withOpacity(0.1) : Colors.grey.shade50,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(
//             color: isSelected ? color : Colors.grey.shade300,
//             width: isSelected ? 2 : 1,
//           ),
//         ),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: color.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Icon(
//                 icon,
//                 color: color,
//                 size: 20,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 16,
//                       color: isSelected ? color : Colors.black87,
//                     ),
//                   ),
//                   Text(
//                     subtitle,
//                     style: TextStyle(
//                       color: Colors.grey.shade600,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Flexible(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     '₹${doctor.availability['fees']}',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w700,
//                       fontSize: 16,
//                       color: isSelected ? color : Colors.black87,
//                     ),
//                   ),
//                   Container(
//                     width: 20,
//                     height: 20,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: isSelected ? color : Colors.grey.shade400,
//                         width: 2,
//                       ),
//                     ),
//                     child: isSelected
//                         ? Container(
//                             margin: const EdgeInsets.all(2),
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: color,
//                             ),
//                           )
//                         : null,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBillDetails(BuildContext context) {
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
//                       colors: [Color(0xFFFF9800), Color(0xFFFFB74D)],
//                     ),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: const Icon(
//                     Icons.receipt_long_rounded,
//                     color: Colors.white,
//                     size: 20,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 const Text(
//                   'Bill Details',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 18,
//                     color: Colors.black87,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             _buildBillRow(context, 'Consultation Fee',
//                 '₹${doctor.availability['fees']}', false),
//             _buildBillRow(context, 'Service Fee & Tax', 'FREE', false,
//                 color: Colors.green),
//             const SizedBox(height: 12),
//             Container(
//               height: 1,
//               color: Colors.grey.shade300,
//             ),
//             const SizedBox(height: 12),
//             _buildBillRow(context, 'Total Payable',
//                 '₹${doctor.availability['fees']}', true),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBillRow(
//       BuildContext context, String title, String amount, bool isTotal,
//       {Color? color}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: isTotal ? 16 : 15,
//               fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
//               color: isTotal ? Colors.black87 : Colors.grey.shade700,
//             ),
//           ),
//           Text(
//             amount,
//             style: TextStyle(
//               fontSize: isTotal ? 18 : 15,
//               fontWeight: isTotal ? FontWeight.w700 : FontWeight.w600,
//               color: color ?? (isTotal ? Colors.black87 : Colors.black54),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPatientInfo(BuildContext context, String? selectedPatientName) {
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
//                 gradient: LinearGradient(
//                   colors: [
//                     Colors.blue.shade100,
//                     Colors.blue.shade50,
//                   ],
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(
//                 Icons.person_rounded,
//                 color: Colors.blue.shade700,
//                 size: 24,
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'In-Clinic Appointment for',
//                     style: TextStyle(
//                       color: Colors.grey,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   BlocBuilder<PatientBloc, PatientState>(
//                     builder: (context, state) {
//                       if (state is PatientLoaded) {
//                         if (state.patients.isNotEmpty) {
//                           selectedPatientName =
//                               '${state.patients[0]['firstName']} ${state.patients[0]['lastName']}';
//                         }
//                       }
//                       return Text(
//                         selectedPatientName ?? 'Select Patient',
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 16,
//                           color: Colors.black87,
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             Builder(builder: (buttonContext) {
//               return TextButton(
//                 onPressed: () {
//                   showModalBottomSheet(
//                     context: buttonContext,
//                     isScrollControlled: true,
//                     shape: const RoundedRectangleBorder(
//                       borderRadius:
//                           BorderRadius.vertical(top: Radius.circular(20)),
//                     ),
//                     builder: (context) => BlocProvider.value(
//                       value: BlocProvider.of<PatientBloc>(buttonContext,
//                           listen: false),
//                       child: DraggableScrollableSheet(
//                         initialChildSize: 0.5,
//                         maxChildSize: 0.9,
//                         minChildSize: 0.3,
//                         expand: false,
//                         builder: (context, scrollController) => Container(
//                           padding: const EdgeInsets.all(16),
//                           decoration: const BoxDecoration(
//                             color: Colors.white,
//                             borderRadius:
//                                 BorderRadius.vertical(top: Radius.circular(20)),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 'Select Patient',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 16),
//                               // Wrap ListView in Expanded to give it proper constraints
//                               Expanded(
//                                 child: BlocBuilder<PatientBloc, PatientState>(
//                                   builder: (context, state) {
//                                     if (state is PatientLoading) {
//                                       return const Center(
//                                         child: CircularProgressIndicator(),
//                                       );
//                                     }
//                                     if (state is PatientLoaded) {
//                                       if (state.patients.isEmpty) {
//                                         return const Center(
//                                           child: Text(
//                                             'No patients found. Please add a patient.',
//                                             textAlign: TextAlign.center,
//                                           ),
//                                         );
//                                       }
//                                       return ListView.builder(
//                                         controller: scrollController,
//                                         itemCount: state.patients.length,
//                                         itemBuilder: (context, index) {
//                                           final patient = state.patients[index];
//                                           return GestureDetector(
//                                             onTap: () {
//                                               final patientName =
//                                                   '${patient['firstName']} ${patient['lastName']}';
//                                               Navigator.pop(
//                                                   context, patientName);
//                                             },
//                                             child: Container(
//                                               padding: const EdgeInsets.all(12),
//                                               margin: const EdgeInsets.only(
//                                                   bottom: 8),
//                                               decoration: BoxDecoration(
//                                                 color: Colors.grey.shade100,
//                                                 borderRadius:
//                                                     BorderRadius.circular(12),
//                                               ),
//                                               child: Row(
//                                                 children: [
//                                                   CircleAvatar(
//                                                     radius: 20,
//                                                     backgroundColor:
//                                                         Colors.blue,
//                                                     child: Text(
//                                                       patient['firstName']!
//                                                           .substring(0, 1)
//                                                           .toUpperCase(),
//                                                       style: const TextStyle(
//                                                         color: Colors.white,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   const SizedBox(width: 12),
//                                                   Expanded(
//                                                     child: Column(
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         Text(
//                                                           '${patient['firstName']} ${patient['lastName']}',
//                                                           style:
//                                                               const TextStyle(
//                                                             fontSize: 16,
//                                                             fontWeight:
//                                                                 FontWeight.w600,
//                                                           ),
//                                                         ),
//                                                         Text(
//                                                           '${patient['gender']}, ${patient['age']}',
//                                                           style:
//                                                               const TextStyle(
//                                                             fontSize: 12,
//                                                             color: Colors.grey,
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   const Icon(
//                                                     Icons.arrow_forward_ios,
//                                                     color: Colors.grey,
//                                                     size: 16,
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       );
//                                     }
//                                     return const Center(
//                                       child: Text('Error loading patients'),
//                                     );
//                                   },
//                                 ),
//                               ),
//                               const SizedBox(height: 16),
//                               SizedBox(
//                                 width: double.infinity,
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) =>
//                                             BlocProvider.value(
//                                           value: BlocProvider.of<PatientBloc>(
//                                               buttonContext,
//                                               listen: false),
//                                           child: const AddPatientPage(),
//                                         ),
//                                       ),
//                                     ).then((addedPatientName) {
//                                       context
//                                           .read<PatientBloc>()
//                                           .add(LoadPatients());
//                                       if (addedPatientName != null) {
//                                         Navigator.pop(
//                                             context, addedPatientName);
//                                       }
//                                     });
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.teal,
//                                     foregroundColor: Colors.white,
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 16),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                   ),
//                                   child: const Text(
//                                     'Add New Patient',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ).then((selectedName) {
//                     if (selectedName != null && selectedName is String) {
//                       // Update the UI with the selected patient
//                       context.read<PatientBloc>().add(LoadPatients());
//                     }
//                   });
//                 },
//                 style: TextButton.styleFrom(
//                   backgroundColor: Colors.blue.shade50,
//                   foregroundColor: Colors.blue.shade700,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 ),
//                 child: const Text(
//                   'Select',
//                   style: TextStyle(fontWeight: FontWeight.w600),
//                 ),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildConfirmButton(
//       BuildContext context, String? selectedPatientName) {
//     return BlocBuilder<PaymentBloc, PaymentState>(
//       builder: (context, state) {
//         print('Building confirm button, state: $state');
//         return Container(
//           margin: const EdgeInsets.symmetric(horizontal: 20),
//           width: double.infinity,
//           height: 60,
//           decoration: BoxDecoration(
//             gradient: const LinearGradient(
//               colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: const Color(0xFF2196F3).withOpacity(0.4),
//                 blurRadius: 20,
//                 offset: const Offset(0, 10),
//               ),
//             ],
//           ),
//           child: ElevatedButton(
//             onPressed: state is PaymentLoading
//                 ? null
//                 : () {
//                     print('Confirm button pressed');
//                     if (selectedDate == null || selectedSlot == null) {
//                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                           content: Text('Invalid date or slot')));
//                       return;
//                     }
//                     context.read<PaymentBloc>().add(
//                           ConfirmBooking(
//                             doctor: doctor,
//                             selectedDate: selectedDate!,
//                             selectedSlot: selectedSlot!,
//                             paymentMethod: state is PaymentSelected
//                                 ? state.paymentMethod
//                                 : 'Pay At Clinic',
//                             userName: selectedPatientName, // Pass the name
//                           ),
//                         );
//                   },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.transparent,
//               shadowColor: Colors.transparent,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//             ),
//             child: state is PaymentLoading
//                 ? const CircularProgressIndicator(color: Colors.white)
//                 : Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             '₹${doctor.availability['fees']}',
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 14,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                           const Text(
//                             'View Bill',
//                             style: TextStyle(
//                               color: Colors.white70,
//                               fontSize: 10,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(width: 20),
//                       Container(
//                         width: 1,
//                         height: 40,
//                         color: Colors.white30,
//                       ),
//                       const SizedBox(width: 20),
//                       const Flexible(
//                         flex: 2,
//                         child: Text(
//                           'confirm clinic visit',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 17,
//                             fontWeight: FontWeight.w600,
//                             letterSpacing: 0.3,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 4),
//                       const Icon(
//                         Icons.arrow_forward_rounded,
//                         color: Colors.white,
//                         size: 18,
//                       ),
//                     ],
//                   ),
//           ),
//         );
//       },
//     );
//   }

//   String _getWeekdayAbbreviation(int weekday) {
//     const abbreviations = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//     return abbreviations[weekday - 1];
//   }

//   String _getMonthAbbreviation(int month) {
//     const abbreviations = [
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
//     return abbreviations[month - 1];
//   }

//   bool _isPM(String time) {
//     final hour = int.parse(time.split(':')[0]);
//     return hour >= 12;
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vistacall/bloc/add_patient/patient_bloc.dart';
// import 'package:vistacall/bloc/payment/payment_bloc.dart';
// import 'package:vistacall/bloc/payment/payment_event.dart';
// import 'package:vistacall/data/models/doctor.dart';
// import 'package:vistacall/presentation/views/booking_successpage.dart';
// import 'package:vistacall/presentation/widgets/bookappointments/add_patient.dart';

// class BookingConformation extends StatelessWidget {
//   final DoctorModel doctor;
//   final DateTime? selectedDate;
//   final String? selectedSlot;

//   const BookingConformation({
//     super.key,
//     required this.doctor,
//     this.selectedDate,
//     this.selectedSlot,
//   });

//   String getTimeDifference() {
//     if (selectedDate == null || selectedSlot == null) return 'N/A';
//     final now = DateTime.now();
//     final slotParts = selectedSlot!.split('-');
//     if (slotParts.length != 2) return 'N/A';
//     final startTime = slotParts[0].split(':');
//     if (startTime.length != 2) return 'N/A';
//     final appointmentTime = DateTime(
//       selectedDate!.year,
//       selectedDate!.month,
//       selectedDate!.day,
//       int.parse(startTime[0]),
//       int.parse(startTime[1]),
//     );
//     final difference = appointmentTime.difference(now);
//     if (difference.isNegative) return 'Past due';
//     final hours = difference.inHours;
//     final minutes = difference.inMinutes.remainder(60);
//     return 'in $hours hours and $minutes min';
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;
//     String? selectedPatientName;

//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (context) => PaymentBloc()),
//         BlocProvider(create: (context) => PatientBloc()..add(LoadPatients())),
//       ],
//       child: Builder(builder: (context) {
//         return BlocListener<PaymentBloc, PaymentState>(
//           listener: (context, state) {
//             if (state is PaymentSuccess) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(
//                     'Booking confirmed!',
//                     style: TextStyle(color: colorScheme.onInverseSurface),
//                   ),
//                   backgroundColor: colorScheme.inverseSurface,
//                 ),
//               );
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => BookingSuccessPage(
//                     doctor: state.doctor!,
//                     selectedDate: state.selectedDate!,
//                     selectedSlot: state.selectedSlot!,
//                     paymentMethod: state.paymentMethod!,
//                   ),
//                 ),
//               );
//             } else if (state is PaymentError) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(
//                     state.error,
//                     style: TextStyle(color: colorScheme.onErrorContainer),
//                   ),
//                   backgroundColor: colorScheme.errorContainer,
//                 ),
//               );
//             }
//           },
//           child: Scaffold(
//             backgroundColor: colorScheme.background, // Dynamic background
//             appBar: _buildModernAppBar(context, theme, colorScheme),
//             body: SafeArea(
//               child: SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 20),
//                     _buildDoctorCard(context, theme, colorScheme),
//                     const SizedBox(height: 20),
//                     _buildAppointmentCard(context, theme, colorScheme),
//                     const SizedBox(height: 20),
//                     _buildVistaCallPromise(context, theme, colorScheme),
//                     const SizedBox(height: 30),
//                     _buildPaymentSection(context, theme, colorScheme),
//                     const SizedBox(height: 30),
//                     _buildBillDetails(context, theme, colorScheme),
//                     const SizedBox(height: 30),
//                     _buildPatientInfo(
//                         context, theme, colorScheme, selectedPatientName),
//                     const SizedBox(height: 30),
//                     _buildConfirmButton(
//                         context, theme, colorScheme, selectedPatientName),
//                     const SizedBox(height: 30),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       }),
//     );
//   }

//   PreferredSizeWidget _buildModernAppBar(
//       BuildContext context, ThemeData theme, ColorScheme colorScheme) {
//     return AppBar(
//       backgroundColor: colorScheme.surface, // Dynamic white
//       elevation: 0,
//       leading: IconButton(
//         onPressed: () => Navigator.of(context).pop(),
//         icon: Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: colorScheme.surfaceVariant.withValues(alpha: .1),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Icon(
//             Icons.arrow_back_ios_new,
//             size: 18,
//             color: colorScheme.onSurface,
//           ),
//         ),
//       ),
//       title: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [colorScheme.primary, colorScheme.primaryContainer],
//               ),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Icon(
//               Icons.local_hospital_rounded,
//               color: colorScheme.onPrimary,
//               size: 20,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Text(
//               'Booking Confirmation',
//               style: theme.textTheme.headlineSmall?.copyWith(
//                 fontWeight: FontWeight.w600,
//                 color: colorScheme.onSurface,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDoctorCard(
//       BuildContext context, ThemeData theme, ColorScheme colorScheme) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       decoration: BoxDecoration(
//         color: colorScheme.surface,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: colorScheme.primary.withValues(alpha: .1),
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
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   BoxShadow(
//                     color: colorScheme.primary.withValues(alpha: .3),
//                     blurRadius: 15,
//                     offset: const Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: CircleAvatar(
//                 radius: 35,
//                 backgroundColor: colorScheme.surfaceVariant,
//                 backgroundImage:
//                     const AssetImage('assets/images/generalphysician.png'),
//                 child: const Icon(
//                   Icons.person,
//                   color: Colors.white,
//                   size: 30,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Dr. ${doctor.personal['fullName'] as String}',
//                     style: theme.textTheme.titleLarge?.copyWith(
//                       fontWeight: FontWeight.w700,
//                       color: colorScheme.onSurface,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: colorScheme.tertiaryContainer,
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(color: colorScheme.outlineVariant),
//                     ),
//                     child: Text(
//                       doctor.personal['department'],
//                       style: theme.textTheme.labelSmall?.copyWith(
//                         color: colorScheme.onTertiaryContainer,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.location_on_rounded,
//                         size: 16,
//                         color: colorScheme.onSurfaceVariant,
//                       ),
//                       const SizedBox(width: 4),
//                       Expanded(
//                         child: Text(
//                           doctor.personal['hospitalName'],
//                           style: theme.textTheme.bodyMedium?.copyWith(
//                             color: colorScheme.onSurfaceVariant,
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAppointmentCard(
//       BuildContext context, ThemeData theme, ColorScheme colorScheme) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       decoration: BoxDecoration(
//         color: colorScheme.surface,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: colorScheme.primary.withValues(alpha: .1),
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
//                     gradient: LinearGradient(
//                       colors: [
//                         colorScheme.secondary,
//                         colorScheme.secondaryContainer
//                       ],
//                     ),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Icon(
//                     Icons.access_time_rounded,
//                     color: colorScheme.onSecondary,
//                     size: 20,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Text(
//                   'Appointment Time',
//                   style: theme.textTheme.titleLarge?.copyWith(
//                     fontWeight: FontWeight.w600,
//                     color: colorScheme.onSurface,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     colorScheme.tertiaryContainer,
//                     colorScheme.tertiaryContainer.withValues(alpha: 0.3),
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: colorScheme.outlineVariant),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.calendar_today_rounded,
//                         size: 18,
//                         color: colorScheme.onTertiaryContainer,
//                       ),
//                       const SizedBox(width: 8),
//                       Text(
//                         selectedDate != null && selectedSlot != null
//                             ? '${_getWeekdayAbbreviation(selectedDate!.weekday)}, ${selectedDate!.day} ${_getMonthAbbreviation(selectedDate!.month)} ${selectedSlot!.split('-')[0]} ${_isPM(selectedSlot!.split('-')[0]) ? 'PM' : 'AM'}'
//                             : 'Mon, 18 Aug 12:30 PM',
//                         style: theme.textTheme.titleMedium?.copyWith(
//                           color: colorScheme.onTertiaryContainer,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.timer_outlined,
//                         size: 18,
//                         color: colorScheme.onSurfaceVariant,
//                       ),
//                       const SizedBox(width: 8),
//                       Text(
//                         selectedDate != null && selectedSlot != null
//                             ? getTimeDifference()
//                             : 'in 21 hours and 13 min',
//                         style: theme.textTheme.bodyMedium?.copyWith(
//                           color: colorScheme.onSurfaceVariant,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildVistaCallPromise(
//       BuildContext context, ThemeData theme, ColorScheme colorScheme) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             colorScheme.secondary.withValues(alpha: .1),
//             colorScheme.secondaryContainer.withValues(alpha: 0.05),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: colorScheme.secondary.withValues(alpha: 0.3)),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [colorScheme.secondary, colorScheme.secondaryContainer],
//               ),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Icon(
//               Icons.verified_rounded,
//               color: colorScheme.onSecondary,
//               size: 20,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Text(
//             'VistaCall Promise',
//             style: theme.textTheme.titleMedium?.copyWith(
//               color: colorScheme.secondary,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const Spacer(),
//           Icon(
//             Icons.info_outline_rounded,
//             color: colorScheme.secondary.withValues(alpha: 0.7),
//             size: 20,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPaymentSection(
//       BuildContext context, ThemeData theme, ColorScheme colorScheme) {
//     return BlocBuilder<PaymentBloc, PaymentState>(
//       builder: (context, state) {
//         final selectedPayment =
//             state is PaymentSelected ? state.paymentMethod : null;
//         return Container(
//           margin: const EdgeInsets.symmetric(horizontal: 20),
//           decoration: BoxDecoration(
//             color: colorScheme.surface,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: colorScheme.primary.withValues(alpha: 0.1),
//                 blurRadius: 20,
//                 offset: const Offset(0, 8),
//               ),
//             ],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [
//                             colorScheme.tertiary,
//                             colorScheme.tertiaryContainer
//                           ],
//                         ),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Icon(
//                         Icons.payment_rounded,
//                         color: colorScheme.onTertiary,
//                         size: 20,
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Text(
//                       'Payment Method',
//                       style: theme.textTheme.titleLarge?.copyWith(
//                         fontWeight: FontWeight.w600,
//                         color: colorScheme.onSurface,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 _buildPaymentOption(
//                     context,
//                     theme,
//                     colorScheme,
//                     'Pay Online',
//                     Icons.credit_card_rounded,
//                     colorScheme.primary,
//                     'Secure & Quick',
//                     selectedPayment),
//                 const SizedBox(height: 12),
//                 _buildPaymentOption(
//                     context,
//                     theme,
//                     colorScheme,
//                     'Pay At Clinic',
//                     Icons.store_rounded,
//                     colorScheme.secondary,
//                     'Pay when you visit',
//                     selectedPayment),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildPaymentOption(
//       BuildContext context,
//       ThemeData theme,
//       ColorScheme colorScheme,
//       String title,
//       IconData icon,
//       Color color,
//       String subtitle,
//       String? selectedPayment) {
//     final isSelected = selectedPayment == title;
//     return GestureDetector(
//       onTap: () {
//         print('Payment option selected: $title');
//         context.read<PaymentBloc>().add(SelectPayment(title));
//       },
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: isSelected
//               ? color.withValues(alpha: .1)
//               : colorScheme.surfaceVariant.withValues(alpha: .1),
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(
//             color:
//                 isSelected ? color : colorScheme.outline.withValues(alpha: .3),
//             width: isSelected ? 2 : 1,
//           ),
//         ),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: color.withValues(alpha: 0.2),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Icon(icon, color: color, size: 20),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: theme.textTheme.titleMedium?.copyWith(
//                       fontWeight: FontWeight.w600,
//                       color: isSelected ? color : colorScheme.onSurface,
//                     ),
//                   ),
//                   Text(
//                     subtitle,
//                     style: theme.textTheme.bodySmall?.copyWith(
//                       color: colorScheme.onSurfaceVariant,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Flexible(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     '₹${doctor.availability['fees']}',
//                     style: theme.textTheme.titleMedium?.copyWith(
//                       fontWeight: FontWeight.w700,
//                       color: isSelected ? color : colorScheme.onSurface,
//                     ),
//                   ),
//                   Container(
//                     width: 20,
//                     height: 20,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: isSelected ? color : colorScheme.outlineVariant,
//                         width: 2,
//                       ),
//                     ),
//                     child: isSelected
//                         ? Container(
//                             margin: const EdgeInsets.all(2),
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: color,
//                             ),
//                           )
//                         : null,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBillDetails(
//       BuildContext context, ThemeData theme, ColorScheme colorScheme) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       decoration: BoxDecoration(
//         color: colorScheme.surface,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: colorScheme.primary.withValues(alpha: .1),
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
//                     gradient: LinearGradient(
//                       colors: [
//                         colorScheme.secondaryContainer,
//                         colorScheme.secondary
//                       ],
//                     ),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Icon(
//                     Icons.receipt_long_rounded,
//                     color: colorScheme.onSecondaryContainer,
//                     size: 20,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Text(
//                   'Bill Details',
//                   style: theme.textTheme.titleLarge?.copyWith(
//                     fontWeight: FontWeight.w600,
//                     color: colorScheme.onSurface,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             _buildBillRow(context, theme, colorScheme, 'Consultation Fee',
//                 '₹${doctor.availability['fees']}', false),
//             _buildBillRow(
//                 context, theme, colorScheme, 'Service Fee & Tax', 'FREE', false,
//                 color: colorScheme.tertiary),
//             const SizedBox(height: 12),
//             Container(height: 1, color: colorScheme.outline),
//             const SizedBox(height: 12),
//             _buildBillRow(context, theme, colorScheme, 'Total Payable',
//                 '₹${doctor.availability['fees']}', true),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBillRow(BuildContext context, ThemeData theme,
//       ColorScheme colorScheme, String title, String amount, bool isTotal,
//       {Color? color}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: theme.textTheme.bodyLarge?.copyWith(
//               fontSize: isTotal ? 16 : 15,
//               fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
//               color: isTotal
//                   ? colorScheme.onSurface
//                   : colorScheme.onSurfaceVariant,
//             ),
//           ),
//           Text(
//             amount,
//             style: theme.textTheme.bodyLarge?.copyWith(
//               fontSize: isTotal ? 18 : 15,
//               fontWeight: isTotal ? FontWeight.w700 : FontWeight.w600,
//               color: color ??
//                   (isTotal
//                       ? colorScheme.onSurface
//                       : colorScheme.onSurfaceVariant),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPatientInfo(BuildContext context, ThemeData theme,
//       ColorScheme colorScheme, String? selectedPatientName) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       decoration: BoxDecoration(
//         color: colorScheme.surface,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: colorScheme.primary.withValues(alpha: 0.1),
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
//                 gradient: LinearGradient(
//                   colors: [
//                     colorScheme.primaryContainer.withValues(alpha: 0.3),
//                     colorScheme.primaryContainer.withValues(alpha: 0.1),
//                   ],
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(
//                 Icons.person_rounded,
//                 color: colorScheme.primary,
//                 size: 24,
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'In-Clinic Appointment for',
//                     style: theme.textTheme.bodySmall?.copyWith(
//                       color: colorScheme.onSurfaceVariant,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   BlocBuilder<PatientBloc, PatientState>(
//                     builder: (context, state) {
//                       if (state is PatientLoaded) {
//                         if (state.patients.isNotEmpty) {
//                           selectedPatientName =
//                               '${state.patients[0]['firstName']} ${state.patients[0]['lastName']}';
//                         }
//                       }
//                       return Text(
//                         selectedPatientName ?? 'Select Patient',
//                         style: theme.textTheme.titleMedium?.copyWith(
//                           fontWeight: FontWeight.w600,
//                           color: colorScheme.onSurface,
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             Builder(builder: (buttonContext) {
//               return TextButton(
//                 onPressed: () {
//                   showModalBottomSheet(
//                     context: buttonContext,
//                     isScrollControlled: true,
//                     shape: const RoundedRectangleBorder(
//                       borderRadius:
//                           BorderRadius.vertical(top: Radius.circular(20)),
//                     ),
//                     builder: (context) => BlocProvider.value(
//                       value: BlocProvider.of<PatientBloc>(buttonContext,
//                           listen: false),
//                       child: DraggableScrollableSheet(
//                         initialChildSize: 0.5,
//                         maxChildSize: 0.9,
//                         minChildSize: 0.3,
//                         expand: false,
//                         builder: (context, scrollController) => Container(
//                           padding: const EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: colorScheme.surface,
//                             borderRadius: const BorderRadius.vertical(
//                                 top: Radius.circular(20)),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Select Patient',
//                                 style: theme.textTheme.titleLarge?.copyWith(
//                                   fontWeight: FontWeight.bold,
//                                   color: colorScheme.onSurface,
//                                 ),
//                               ),
//                               const SizedBox(height: 16),
//                               Expanded(
//                                 child: BlocBuilder<PatientBloc, PatientState>(
//                                   builder: (context, state) {
//                                     if (state is PatientLoading) {
//                                       return Center(
//                                           child: CircularProgressIndicator(
//                                               color: colorScheme.primary));
//                                     }
//                                     if (state is PatientLoaded) {
//                                       if (state.patients.isEmpty) {
//                                         return Center(
//                                           child: Text(
//                                             'No patients found. Please add a patient.',
//                                             textAlign: TextAlign.center,
//                                             style: theme.textTheme.bodyMedium
//                                                 ?.copyWith(
//                                               color:
//                                                   colorScheme.onSurfaceVariant,
//                                             ),
//                                           ),
//                                         );
//                                       }
//                                       return ListView.builder(
//                                         controller: scrollController,
//                                         itemCount: state.patients.length,
//                                         itemBuilder: (context, index) {
//                                           final patient = state.patients[index];
//                                           return GestureDetector(
//                                             onTap: () {
//                                               final patientName =
//                                                   '${patient['firstName']} ${patient['lastName']}';
//                                               Navigator.pop(
//                                                   context, patientName);
//                                             },
//                                             child: Container(
//                                               padding: const EdgeInsets.all(12),
//                                               margin: const EdgeInsets.only(
//                                                   bottom: 8),
//                                               decoration: BoxDecoration(
//                                                 color: colorScheme
//                                                     .surfaceVariant
//                                                     .withValues(alpha: 0.1),
//                                                 borderRadius:
//                                                     BorderRadius.circular(12),
//                                               ),
//                                               child: Row(
//                                                 children: [
//                                                   CircleAvatar(
//                                                     radius: 20,
//                                                     backgroundColor:
//                                                         colorScheme.primary,
//                                                     child: Text(
//                                                       patient['firstName']!
//                                                           .substring(0, 1)
//                                                           .toUpperCase(),
//                                                       style: TextStyle(
//                                                         color: colorScheme
//                                                             .onPrimary,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   const SizedBox(width: 12),
//                                                   Expanded(
//                                                     child: Column(
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         Text(
//                                                           '${patient['firstName']} ${patient['lastName']}',
//                                                           style: theme.textTheme
//                                                               .titleMedium
//                                                               ?.copyWith(
//                                                             fontWeight:
//                                                                 FontWeight.w600,
//                                                             color: colorScheme
//                                                                 .onSurface,
//                                                           ),
//                                                         ),
//                                                         Text(
//                                                           '${patient['gender']}, ${patient['age']}',
//                                                           style: theme.textTheme
//                                                               .bodySmall
//                                                               ?.copyWith(
//                                                             color: colorScheme
//                                                                 .onSurfaceVariant,
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Icon(
//                                                     Icons.arrow_forward_ios,
//                                                     color: colorScheme
//                                                         .onSurfaceVariant,
//                                                     size: 16,
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       );
//                                     }
//                                     return Center(
//                                       child: Text(
//                                         'Error loading patients',
//                                         style: theme.textTheme.bodyMedium
//                                             ?.copyWith(
//                                           color: colorScheme.onSurfaceVariant,
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                               const SizedBox(height: 16),
//                               SizedBox(
//                                 width: double.infinity,
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) =>
//                                             BlocProvider.value(
//                                           value: BlocProvider.of<PatientBloc>(
//                                               buttonContext,
//                                               listen: false),
//                                           child: const AddPatientPage(),
//                                         ),
//                                       ),
//                                     ).then((addedPatientName) {
//                                       context
//                                           .read<PatientBloc>()
//                                           .add(LoadPatients());
//                                       if (addedPatientName != null) {
//                                         Navigator.pop(
//                                             context, addedPatientName);
//                                       }
//                                     });
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: colorScheme.primary,
//                                     foregroundColor: colorScheme.onPrimary,
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 16),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                   ),
//                                   child: Text(
//                                     'Add New Patient',
//                                     style:
//                                         theme.textTheme.titleMedium?.copyWith(
//                                       fontWeight: FontWeight.w600,
//                                       color: colorScheme.onPrimary,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ).then((selectedName) {
//                     if (selectedName != null && selectedName is String) {
//                       context.read<PatientBloc>().add(LoadPatients());
//                     }
//                   });
//                 },
//                 style: TextButton.styleFrom(
//                   backgroundColor:
//                       colorScheme.primaryContainer.withValues(alpha: 0.1),
//                   foregroundColor: colorScheme.primary,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 ),
//                 child: Text(
//                   'Select',
//                   style: theme.textTheme.labelLarge?.copyWith(
//                     fontWeight: FontWeight.w600,
//                     color: colorScheme.primary,
//                   ),
//                 ),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildConfirmButton(BuildContext context, ThemeData theme,
//       ColorScheme colorScheme, String? selectedPatientName) {
//     return BlocBuilder<PaymentBloc, PaymentState>(
//       builder: (context, state) {
//         print('Building confirm button, state: $state');
//         return Container(
//           margin: const EdgeInsets.symmetric(horizontal: 20),
//           width: double.infinity,
//           height: 60,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [colorScheme.primary, colorScheme.primaryContainer],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: colorScheme.primary.withOpacity(0.4),
//                 blurRadius: 20,
//                 offset: const Offset(0, 10),
//               ),
//             ],
//           ),
//           child: ElevatedButton(
//             onPressed: state is PaymentLoading
//                 ? null
//                 : () {
//                     print('Confirm button pressed');
//                     if (selectedDate == null || selectedSlot == null) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text(
//                             'Invalid date or slot',
//                             style:
//                                 TextStyle(color: colorScheme.onErrorContainer),
//                           ),
//                           backgroundColor: colorScheme.errorContainer,
//                         ),
//                       );
//                       return;
//                     }
//                     context.read<PaymentBloc>().add(
//                           ConfirmBooking(
//                             doctor: doctor,
//                             selectedDate: selectedDate!,
//                             selectedSlot: selectedSlot!,
//                             paymentMethod: state is PaymentSelected
//                                 ? state.paymentMethod
//                                 : 'Pay At Clinic',
//                             userName: selectedPatientName,
//                           ),
//                         );
//                   },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.transparent,
//               shadowColor: Colors.transparent,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//             ),
//             child: state is PaymentLoading
//                 ? CircularProgressIndicator(color: colorScheme.onPrimary)
//                 : Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             '₹${doctor.availability['fees']}',
//                             style: theme.textTheme.bodyMedium?.copyWith(
//                               color: colorScheme.onPrimary,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                           Text(
//                             'View Bill',
//                             style: theme.textTheme.labelSmall?.copyWith(
//                               color:
//                                   colorScheme.onPrimary.withValues(alpha: 0.7),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(width: 20),
//                       Container(
//                         width: 1,
//                         height: 40,
//                         color: colorScheme.onPrimary.withValues(alpha: 0.3),
//                       ),
//                       const SizedBox(width: 20),
//                       Flexible(
//                         flex: 2,
//                         child: Text(
//                           'confirm clinic visit',
//                           style: theme.textTheme.titleMedium?.copyWith(
//                             color: colorScheme.onPrimary,
//                             fontWeight: FontWeight.w600,
//                             letterSpacing: 0.3,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 4),
//                       Icon(
//                         Icons.arrow_forward_rounded,
//                         color: colorScheme.onPrimary,
//                         size: 18,
//                       ),
//                     ],
//                   ),
//           ),
//         );
//       },
//     );
//   }

//   String _getWeekdayAbbreviation(int weekday) {
//     const abbreviations = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//     return abbreviations[weekday - 1];
//   }

//   String _getMonthAbbreviation(int month) {
//     const abbreviations = [
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
//     return abbreviations[month - 1];
//   }

//   bool _isPM(String time) {
//     final hour = int.parse(time.split(':')[0]);
//     return hour >= 12;
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:vistacall/presentation/widgets/booking_confirmation/bill_details.dart';
import 'package:vistacall/presentation/widgets/booking_confirmation/confirm_button.dart';
import 'package:vistacall/presentation/widgets/booking_confirmation/patient_section.dart';
import 'package:vistacall/presentation/widgets/booking_confirmation/vista_promise.dart';
import '../../bloc/add_patient/patient_bloc.dart';
import '../../bloc/payment/payment_bloc.dart';
import '../../viewmodels/booking_confirmation_viewmodel.dart';
import '../widgets/booking_confirmation/doctor_card.dart';
import '../widgets/booking_confirmation/appointment_card.dart';
import '../widgets/booking_confirmation/payment_section.dart';

import '../../data/models/doctor.dart';
import '../../presentation/views/booking_successpage.dart';

class BookingConformation extends StatefulWidget {
  final DoctorModel doctor;
  final DateTime? selectedDate;
  final String? selectedSlot;

  const BookingConformation({
    super.key,
    required this.doctor,
    this.selectedDate,
    this.selectedSlot,
  });

  @override
  State<BookingConformation> createState() => _BookingConfirmationPageState();
}

class _BookingConfirmationPageState extends State<BookingConformation> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookingConfirmationViewModel(
        doctor: widget.doctor,
        selectedDate: widget.selectedDate,
        selectedSlot: widget.selectedSlot,
      ),
      child: Consumer<BookingConfirmationViewModel>(
        builder: (context, viewModel, child) {
          final theme = Theme.of(context);
          final colorScheme = theme.colorScheme;

          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => PaymentBloc()),
              BlocProvider(
                  create: (context) => PatientBloc()..add(LoadPatients())),
            ],
            child: BlocListener<PaymentBloc, PaymentState>(
              listener: (context, state) =>
                  _handlePaymentState(context, state, colorScheme),
              child: Scaffold(
                backgroundColor: colorScheme.background,
                appBar: _buildAppBar(context, colorScheme),
                body: SafeArea(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        DoctorCard(
                            viewModel: viewModel,
                            theme: theme,
                            colorScheme: colorScheme),
                        const SizedBox(height: 20),
                        AppointmentCard(
                            viewModel: viewModel,
                            theme: theme,
                            colorScheme: colorScheme),
                        const SizedBox(height: 20),
                        VistaPromise(theme: theme, colorScheme: colorScheme),
                        const SizedBox(height: 30),
                        PaymentSection(
                            viewModel: viewModel,
                            theme: theme,
                            colorScheme: colorScheme),
                        const SizedBox(height: 30),
                        BillDetails(
                            viewModel: viewModel,
                            theme: theme,
                            colorScheme: colorScheme),
                        const SizedBox(height: 30),
                        PatientSection(
                            viewModel: viewModel,
                            theme: theme,
                            colorScheme: colorScheme),
                        const SizedBox(height: 30),
                        ConfirmButton(
                            viewModel: viewModel,
                            theme: theme,
                            colorScheme: colorScheme),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
      BuildContext context, ColorScheme colorScheme) {
    return AppBar(
      backgroundColor: colorScheme.surface,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: colorScheme.surfaceVariant.withValues(alpha: .1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.arrow_back_ios_new,
              size: 18, color: colorScheme.onSurface),
        ),
      ),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [colorScheme.primary, colorScheme.primaryContainer]),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.local_hospital_rounded,
                color: colorScheme.onPrimary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Booking Confirmation',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  void _handlePaymentState(
      BuildContext context, PaymentState state, ColorScheme colorScheme) {
    if (state is PaymentSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Booking confirmed!',
                style: TextStyle(color: colorScheme.onInverseSurface)),
            backgroundColor: colorScheme.inverseSurface),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BookingSuccessPage(
            doctor: state.doctor!,
            selectedDate: state.selectedDate!,
            selectedSlot: state.selectedSlot!,
            paymentMethod: state.paymentMethod!,
          ),
        ),
      );
    } else if (state is PaymentError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(state.error,
                style: TextStyle(color: colorScheme.onErrorContainer)),
            backgroundColor: colorScheme.errorContainer),
      );
    }
  }
}

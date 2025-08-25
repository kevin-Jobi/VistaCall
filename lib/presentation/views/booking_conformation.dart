// import 'package:flutter/material.dart';
// import 'package:vistacall/data/models/doctor.dart';

// class BookingConformation extends StatelessWidget {
//   final DoctorModel doctor;
//   final DateTime? selectedDate;
//   final String? selectedSlot;
//   const BookingConformation(
//       {super.key, required this.doctor, this.selectedDate, this.selectedSlot});

//   @override
//   Widget build(BuildContext context) {
//     String selectedPayment = 'Credit Card';
//     String getTimeDifference() {
//       if (selectedDate == null || selectedSlot == null) return 'N/A';
//       final now = DateTime.now();
//       final slotParts = selectedSlot!.split('-');
//       if (slotParts.length != 2) return 'N/A';
//       final startTime = slotParts[0].split(':');
//       if (startTime.length != 2) return 'N/A';
//       final appointmentTime = DateTime(
//         selectedDate!.year,
//         selectedDate!.month,
//         selectedDate!.day,
//         int.parse(startTime[0]),
//         int.parse(startTime[1]),
//       );
//       final difference = appointmentTime.difference(now);
//       if (difference.isNegative) return 'Past due';
//       final hours = difference.inHours;
//       final minutes = difference.inMinutes.remainder(60);
//       return 'in $hours hours and $minutes min';
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Row(
//           children: [
//             Icon(Icons.local_hospital_rounded, color: Colors.blueAccent),
//             Text(
//               'Book In-Clinic Appintment',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                   color: Colors.blue[50],
//                   borderRadius: BorderRadius.circular(20)),
//               width: 330,
//               child: ListTile(
//                 // tileColor: Colors.blue[50],
//                 leading: const CircleAvatar(
//                     backgroundColor: Colors.grey,
//                     backgroundImage:
//                         AssetImage('assets/images/generalphysician.png'),
//                     // imageUrl != null ? NetworkImage(imageUrl) : null,

//                     child:
//                         // imageUrl == null?
//                         Icon(
//                       Icons.person,
//                       color: Colors.white,
//                     )
//                     // : null
//                     ),
//                 title: Text(
//                   'Dr.${doctor.personal['fullName'] as String}',
//                   // 'Dr. Ajil',
//                   style: const TextStyle(
//                       fontWeight: FontWeight.bold, fontSize: 18),
//                 ),
//                 subtitle: RichText(
//                     text: TextSpan(
//                         style:
//                             const TextStyle(color: Colors.black, fontSize: 16),
//                         children: [
//                       TextSpan(
//                           text: '${doctor.personal['department']} \n',
//                           // 'Aurvedic \n',
//                           style: const TextStyle(color: Colors.green)),
//                       TextSpan(
//                           text: '${doctor.personal['hospitalName']}',
//                           // 'Highly Recommended for Doctor Friendliness',
//                           style: const TextStyle(
//                               color: Color.fromARGB(255, 95, 94, 94))),
//                     ])),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Container(
//               decoration: BoxDecoration(
//                   color: Colors.blue[50],
//                   borderRadius: BorderRadius.circular(10)),
//               width: 330,
//               child: ListTile(
//                 // tileColor: Colors.blue[50],

//                 title: const Row(
//                   children: [
//                     Icon(Icons.lock_clock),
//                     Text(
//                       // 'Dr.${doctor.personal['fullName'] as String}',
//                       'Appointment time',
//                       style:
//                           TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
//                     ),
//                   ],
//                 ),
//                 subtitle: RichText(
//                     text: TextSpan(
//                         style:
//                             const TextStyle(color: Colors.black, fontSize: 16),
//                         children: [
//                       TextSpan(
//                           text: selectedDate != null && selectedSlot != null
//                               ? '${_getWeekdayAbbreviation(selectedDate!.weekday)}, ${selectedDate!.day} ${_getMonthAbbreviation(selectedDate!.month)} ${selectedSlot!.split('-')[0]} ${_isPM(selectedSlot!.split('-')[0]) ? 'PM' : 'AM'} \n'
//                               : 'Mon, 18 Aug 12:30 PM \n',
//                           // '${doctor.personal['department']} \n',
//                           // 'Mon, 18 Aug 12:30 PM \n',
//                           style: const TextStyle(color: Colors.green)),
//                       TextSpan(
//                           text:
//                               // '${doctor.personal['hospitalName']}',
//                               selectedDate != null && selectedSlot != null
//                                   ? getTimeDifference()
//                                   : 'in 21 hours and 13 min',
//                           style: const TextStyle(
//                               color: Color.fromARGB(255, 95, 94, 94))),
//                     ])),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const Row(
//               children: [
//                 SizedBox(
//                   width: 15,
//                 ),
//                 Icon(
//                   Icons.verified,
//                   color: Color.fromARGB(255, 139, 76, 210),
//                 ),
//                 Text(
//                   'VistaCall Promise',
//                   style: TextStyle(color: Color.fromARGB(255, 139, 76, 210)),
//                 ),
//               ],
//             ),
//             const Text('Choose a mode of payment',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(
//               height: 15,
//             ),
//             Column(
//               children: [
//                 RadioListTile<String>(
//                   title: const Text('Pay Online'),
//                   value: 'Pay Online',
//                   groupValue: selectedPayment,
//                   onChanged: (value) {
//                     selectedPayment = value!;
//                   },
//                   activeColor: Colors.blue,
//                   secondary:
//                       // const Text('₹800'),
//                       Text('₹${doctor.availability['fees']}'),
//                 ),
//                 RadioListTile(
//                     title: const Text('Pay At Clinic'),
//                     value: 'Pay At Clinic',
//                     groupValue: selectedPayment,
//                     onChanged: (value) {
//                       selectedPayment = value!;
//                     },
//                     activeColor: Colors.blue,
//                     secondary:
//                         // const Text('₹800'),
//                         Text('₹${doctor.availability['fees']}')),
//               ],
//             ),
//             const Text('Bill Details',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             Row(
//               children: [
//                 const SizedBox(width: 20),
//                 const Text('Consultation Fee'),
//                 const SizedBox(width: 190),
//                 // Text('₹800')
//                 Text('₹${doctor.availability['fees']}')
//               ],
//             ),
//             const Row(
//               children: [
//                 SizedBox(
//                   width: 20,
//                 ),
//                 Text('Service Fee & Tax'),
//                 SizedBox(
//                   width: 180,
//                 ),
//                 Text('FREE')
//               ],
//             ),
//             const Divider(
//               indent: 30,
//               endIndent: 30,
//             ),
//             const Row(
//               children: [
//                 SizedBox(
//                   width: 20,
//                 ),
//                 Text('Total Payable'),
//                 SizedBox(
//                   width: 180,
//                 ),
//                 Text('₹800')
//               ],
//             ),
//             ListTile(
//               leading: const Icon(Icons.person),
//               title: const Text('In-Clinic Appointment for'),
//               subtitle: Text('Kevin Jobi'),
//               trailing: TextButton(onPressed: () {}, child: Text('Change')),
//             ),
//             ListTile(
//               leading: const Column(
//                 children: [Text('800'), Text('View Bill')],
//               ),
//               trailing: TextButton(
//                 onPressed: () {},
//                 child: const Text('Confirm Clinic Visit'),
//               ),
//             )
//           ],
//         ),
//       ),
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
import 'package:vistacall/bloc/payment/payment_bloc.dart';
import 'package:vistacall/bloc/payment/payment_event.dart';
import 'package:vistacall/data/models/doctor.dart';

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
  State<BookingConformation> createState() => _BookingConformationState();
}

class _BookingConformationState extends State<BookingConformation> {
  // String selectedPayment = 'Pay Online';

  String getTimeDifference() {
    if (widget.selectedDate == null || widget.selectedSlot == null)
      return 'N/A';
    final now = DateTime.now();
    final slotParts = widget.selectedSlot!.split('-');
    if (slotParts.length != 2) return 'N/A';
    final startTime = slotParts[0].split(':');
    if (startTime.length != 2) return 'N/A';
    final appointmentTime = DateTime(
      widget.selectedDate!.year,
      widget.selectedDate!.month,
      widget.selectedDate!.day,
      int.parse(startTime[0]),
      int.parse(startTime[1]),
    );
    final difference = appointmentTime.difference(now);
    if (difference.isNegative) return 'Past due';
    final hours = difference.inHours;
    final minutes = difference.inMinutes.remainder(60);
    return 'in $hours hours and $minutes min';
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => PaymentBloc())],
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: _buildModernAppBar(),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildDoctorCard(),
                const SizedBox(height: 20),
                _buildAppointmentCard(),
                const SizedBox(height: 20),
                _buildVistaCallPromise(),
                const SizedBox(height: 30),
                _buildPaymentSection(),
                const SizedBox(height: 30),
                _buildBillDetails(),
                const SizedBox(height: 30),
                _buildPatientInfo(),
                const SizedBox(height: 30),
                _buildConfirmButton(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      }),
    );
  }

  PreferredSizeWidget _buildModernAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: Colors.black87,
          ),
        ),
      ),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.local_hospital_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Booking Confirmation',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard() {
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
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 35,
                backgroundColor: Colors.grey.shade300,
                backgroundImage:
                    const AssetImage('assets/images/generalphysician.png'),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dr. ${widget.doctor.personal['fullName'] as String}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Text(
                      widget.doctor.personal['department'],
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          widget.doctor.personal['hospitalName'],
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentCard() {
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
                    Icons.access_time_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Appointment Time',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green.shade50,
                    Colors.green.shade100.withOpacity(0.3),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        size: 18,
                        color: Colors.green.shade700,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.selectedDate != null &&
                                widget.selectedSlot != null
                            ? '${_getWeekdayAbbreviation(widget.selectedDate!.weekday)}, ${widget.selectedDate!.day} ${_getMonthAbbreviation(widget.selectedDate!.month)} ${widget.selectedSlot!.split('-')[0]} ${_isPM(widget.selectedSlot!.split('-')[0]) ? 'PM' : 'AM'}'
                            : 'Mon, 18 Aug 12:30 PM',
                        style: TextStyle(
                          color: Colors.green.shade800,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        size: 18,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.selectedDate != null &&
                                widget.selectedSlot != null
                            ? getTimeDifference()
                            : 'in 21 hours and 13 min',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVistaCallPromise() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF9C27B0).withOpacity(0.1),
            const Color(0xFFBA68C8).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF9C27B0).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF9C27B0), Color(0xFFBA68C8)],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.verified_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'VistaCall Promise',
            style: TextStyle(
              color: Color(0xFF9C27B0),
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.info_outline_rounded,
            color: const Color(0xFF9C27B0).withOpacity(0.7),
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSection() {
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
                    Icons.payment_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Payment Method',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            BlocBuilder<PaymentBloc, PaymentState>(
              builder: (context, state) {
                return Column(
                  children: [
                    _buildPaymentOption(
                        context,
                        'Pay Online',
                        Icons.credit_card_rounded,
                        Colors.blue,
                        'Secure & Quick',
                        state.paymentMethod),
                    const SizedBox(height: 12),
                    _buildPaymentOption(
                        context,
                        'Pay At Clinic',
                        Icons.store_rounded,
                        Colors.orange,
                        'Pay when you visit',
                        state.paymentMethod),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(BuildContext context, String title, IconData icon,
      Color color, String subtitle, String? selectedPayment) {
    final isSelected = selectedPayment == title;
    return GestureDetector(
      onTap: () {
        context.read<PaymentBloc>().add(SelectPayment(title));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: color,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: isSelected ? color : Colors.black87,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  '₹${widget.doctor.availability['fees']}',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: isSelected ? color : Colors.black87,
                  ),
                ),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? color : Colors.grey.shade400,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? Container(
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: color,
                          ),
                        )
                      : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBillDetails() {
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
                    Icons.receipt_long_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Bill Details',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildBillRow('Consultation Fee',
                '₹${widget.doctor.availability['fees']}', false),
            _buildBillRow('Service Fee & Tax', 'FREE', false,
                color: Colors.green),
            const SizedBox(height: 12),
            Container(
              height: 1,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 12),
            _buildBillRow('Total Payable',
                '₹${widget.doctor.availability['fees']}', true),
          ],
        ),
      ),
    );
  }

  Widget _buildBillRow(String title, String amount, bool isTotal,
      {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isTotal ? 16 : 15,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
              color: isTotal ? Colors.black87 : Colors.grey.shade700,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: isTotal ? 18 : 15,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w600,
              color: color ?? (isTotal ? Colors.black87 : Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientInfo() {
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
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade100,
                    Colors.blue.shade50,
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.person_rounded,
                color: Colors.blue.shade700,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'In-Clinic Appointment for',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Kevin Jobi',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue.shade50,
                foregroundColor: Colors.blue.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: const Text(
                'Change',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2196F3).withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: state.isLoading
                ? null
                : () {
                    if (widget.selectedDate == null ||
                        widget.selectedDate == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Invalid date or slot')));
                      return;
                    }
                    context.read<PaymentBloc>().add(
                          ConfirmBooking(
                            doctor: widget.doctor,
                            selectedDate: widget.selectedDate!,
                            selectedSlot: widget.selectedSlot!,
                            paymentMethod:
                                state.paymentMethod ?? 'Pay At Clinic',
                          ),
                        );
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: state.isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '₹${widget.doctor.availability['fees']}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Text(
                            'View Bill',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.white30,
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        'Confirm Clinic Visit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  String _getWeekdayAbbreviation(int weekday) {
    const abbreviations = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return abbreviations[weekday - 1];
  }

  String _getMonthAbbreviation(int month) {
    const abbreviations = [
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
    return abbreviations[month - 1];
  }

  bool _isPM(String time) {
    final hour = int.parse(time.split(':')[0]);
    return hour >= 12;
  }
}

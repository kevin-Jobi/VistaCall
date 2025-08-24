import 'package:flutter/material.dart';
import 'package:vistacall/data/models/doctor.dart';

class BookingConformation extends StatelessWidget {
  final DoctorModel doctor;
  final DateTime? selectedDate;
  final String? selectedSlot;
  const BookingConformation(
      {super.key, required this.doctor, this.selectedDate, this.selectedSlot});

  @override
  Widget build(BuildContext context) {
    String selectedPayment = 'Credit Card';
    String getTimeDifference() {
      if (selectedDate == null || selectedSlot == null) return 'N/A';
      final now = DateTime.now();
      final slotParts = selectedSlot!.split('-');
      if (slotParts.length != 2) return 'N/A';
      final startTime = slotParts[0].split(':');
      if (startTime.length != 2) return 'N/A';
      final appointmentTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        int.parse(startTime[0]),
        int.parse(startTime[1]),
      );
      final difference = appointmentTime.difference(now);
      if (difference.isNegative) return 'Past due';
      final hours = difference.inHours;
      final minutes = difference.inMinutes.remainder(60);
      return 'in $hours hours and $minutes min';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.local_hospital_rounded, color: Colors.blueAccent),
            Text(
              'Book In-Clinic Appintment',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(20)),
              width: 330,
              child: ListTile(
                // tileColor: Colors.blue[50],
                leading: const CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage:
                        AssetImage('assets/images/generalphysician.png'),
                    // imageUrl != null ? NetworkImage(imageUrl) : null,

                    child:
                        // imageUrl == null?
                        Icon(
                      Icons.person,
                      color: Colors.white,
                    )
                    // : null
                    ),
                title: Text(
                  'Dr.${doctor.personal['fullName'] as String}',
                  // 'Dr. Ajil',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: RichText(
                    text: TextSpan(
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                        children: [
                      TextSpan(
                          text: '${doctor.personal['department']} \n',
                          // 'Aurvedic \n',
                          style: const TextStyle(color: Colors.green)),
                      TextSpan(
                          text: '${doctor.personal['hospitalName']}',
                          // 'Highly Recommended for Doctor Friendliness',
                          style: const TextStyle(
                              color: Color.fromARGB(255, 95, 94, 94))),
                    ])),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(10)),
              width: 330,
              child: ListTile(
                // tileColor: Colors.blue[50],

                title: const Row(
                  children: [
                    Icon(Icons.lock_clock),
                    Text(
                      // 'Dr.${doctor.personal['fullName'] as String}',
                      'Appointment time',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                  ],
                ),
                subtitle: RichText(
                    text: TextSpan(
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                        children: [
                      TextSpan(
                          text: selectedDate != null && selectedSlot != null
                              ? '${_getWeekdayAbbreviation(selectedDate!.weekday)}, ${selectedDate!.day} ${_getMonthAbbreviation(selectedDate!.month)} ${selectedSlot!.split('-')[0]} ${_isPM(selectedSlot!.split('-')[0]) ? 'PM' : 'AM'} \n'
                              : 'Mon, 18 Aug 12:30 PM \n',
                          // '${doctor.personal['department']} \n',
                          // 'Mon, 18 Aug 12:30 PM \n',
                          style: const TextStyle(color: Colors.green)),
                      TextSpan(
                          text:
                              // '${doctor.personal['hospitalName']}',
                              selectedDate != null && selectedSlot != null
                                  ? getTimeDifference()
                                  : 'in 21 hours and 13 min',
                          style: const TextStyle(
                              color: Color.fromARGB(255, 95, 94, 94))),
                    ])),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.verified,
                  color: Color.fromARGB(255, 139, 76, 210),
                ),
                Text(
                  'VistaCall Promise',
                  style: TextStyle(color: Color.fromARGB(255, 139, 76, 210)),
                ),
              ],
            ),
            const Text('Choose a mode of payment',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 15,
            ),
            Column(
              children: [
                RadioListTile<String>(
                  title: const Text('Pay Online'),
                  value: 'Pay Online',
                  groupValue: selectedPayment,
                  onChanged: (value) {
                    selectedPayment = value!;
                  },
                  activeColor: Colors.blue,
                  secondary:
                      // const Text('₹800'),
                      Text('₹${doctor.availability['fees']}'),
                ),
                RadioListTile(
                    title: const Text('Pay At Clinic'),
                    value: 'Pay At Clinic',
                    groupValue: selectedPayment,
                    onChanged: (value) {
                      selectedPayment = value!;
                    },
                    activeColor: Colors.blue,
                    secondary:
                        // const Text('₹800'),
                        Text('₹${doctor.availability['fees']}')),
              ],
            ),
            const Text('Bill Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              children: [
                const SizedBox(width: 20),
                const Text('Consultation Fee'),
                const SizedBox(width: 190),
                // Text('₹800')
                Text('₹${doctor.availability['fees']}')
              ],
            ),
            const Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text('Service Fee & Tax'),
                SizedBox(
                  width: 180,
                ),
                Text('FREE')
              ],
            ),
            const Divider(
              indent: 30,
              endIndent: 30,
            ),
            const Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text('Total Payable'),
                SizedBox(
                  width: 180,
                ),
                Text('₹800')
              ],
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('In-Clinic Appointment for'),
              subtitle: Text('Kevin Jobi'),
              trailing: TextButton(onPressed: () {}, child: Text('Change')),
            ),
            ListTile(
              leading: const Column(
                children: [Text('800'), Text('View Bill')],
              ),
              trailing: TextButton(
                onPressed: () {},
                child: const Text('Confirm Clinic Visit'),
              ),
            )
          ],
        ),
      ),
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

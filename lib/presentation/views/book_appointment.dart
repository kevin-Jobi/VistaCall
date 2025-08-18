import 'package:flutter/material.dart';
import 'package:vistacall/data/models/doctor.dart';
import 'package:vistacall/presentation/views/booking_conformation.dart';
import 'package:vistacall/presentation/widgets/bookappointments/date_widget.dart';
import 'package:vistacall/presentation/widgets/custom_textfield.dart';
import 'package:moon_icons/moon_icons.dart';

class BookAppointment extends StatelessWidget {
  final DoctorModel doctor;
  BookAppointment({super.key,required this.doctor});

  List<DateTime> dates = generateDates();
  final List<int> availableSlots = [4, 8, 20, 10, 15, 5, 12];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dr.${doctor.personal['fullName']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.local_hospital_rounded, color: Colors.blueAccent),
                SizedBox(width: 8), // Add spacing between icon and text
                Text(
                  'Clinic Visit Slots',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
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
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dates.length,
                itemBuilder: (context, index) {
                  return DateWidget(
                    date: dates[index],
                    availableSlots: availableSlots[index],
                    // isSelected: selectedIndex == index,
                  );
                },
              ),
            ),
            const Center(
              child: Text(
                'Today,14 Aug',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(
              color: Color.fromARGB(255, 105, 102, 102),
              thickness: 1,
              height: 30,
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Icon(MoonIcons.other_moon_32_light),
                ),
                Text('Eventing 1 slot')
              ],
            ),
            Container(
              width: 75,
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.transparent, width: 2)),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    // _getDayDescription(date),
                    '07:45',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'PM',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Icon(MoonIcons.generic_star_32_regular),
                ),
                Text('Night 3 slot')
              ],
            ),
            Row(
              children: [
                Container(
                  width: 75,
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.transparent, width: 2)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        // _getDayDescription(date),
                        '08:15',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'PM',
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 75,
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.transparent, width: 2)),
                  child: GestureDetector(
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          // _getDayDescription(date),
                          '09:00',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'PM',
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookingConformation()));
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

List<DateTime> generateDates() {
  final now = DateTime.now();
  return List.generate(7, (index) => now.add(Duration(days: index)));
}

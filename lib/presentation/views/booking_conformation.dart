import 'package:flutter/material.dart';

class BookingConformation extends StatelessWidget {
  const BookingConformation({super.key});

  @override
  Widget build(BuildContext context) {
    String selectedPayment = 'Credit Card';
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
      body: Column(
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
              title: const Text(
                // 'Dr.${doctor.personal['fullName'] as String}',
                'Dr. Ajil',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: RichText(
                  text: const TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      children: [
                    TextSpan(
                        text:
                            // '${doctor.personal['department']} \n',
                            'Aurvedic \n',
                        style: TextStyle(color: Colors.green)),
                    TextSpan(
                        text:
                            // '${doctor.personal['hospitalName']}',
                            'Highly Recommended for Doctor Friendliness',
                        style:
                            TextStyle(color: Color.fromARGB(255, 95, 94, 94))),
                  ])),
            ),
          ),
          // const Divider(
          //   color: Color.fromARGB(255, 82, 79, 79),
          //   endIndent: 30,
          //   indent: 30,
          // )
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
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                ],
              ),
              subtitle: RichText(
                  text: const TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      children: [
                    TextSpan(
                        text:
                            // '${doctor.personal['department']} \n',
                            'Mon, 18 Aug 12:30 PM \n',
                        style: TextStyle(color: Colors.green)),
                    TextSpan(
                        text:
                            // '${doctor.personal['hospitalName']}',
                            'in 21 hours and 13 min',
                        style:
                            TextStyle(color: Color.fromARGB(255, 95, 94, 94))),
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
                secondary: const Text('₹800'),
              ),
              RadioListTile(
                title: const Text('Pay At Clinic'),
                value: 'Pay At Clinic',
                groupValue: selectedPayment,
                onChanged: (value) {
                  selectedPayment = value!;
                },
                activeColor: Colors.blue,
                secondary: const Text('₹800'),
              ),
            ],
          ),
          const Text('Bill Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Text('Consultation Fee'),
              SizedBox(
                width: 190,
              ),
              Text('₹800')
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
            // title: const Text('In-Clinic Appointment for'),
            // subtitle: Text('Kevin Jobi'),
            trailing: TextButton(
                onPressed: () {}, child: const Text('Confirm Clinic Visit')),
          )
        ],
      ),
    );
  }
}

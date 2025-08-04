import 'package:flutter/material.dart';

class Drdetails extends StatelessWidget {
  final dynamic doctor;
  const Drdetails({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const GridItem(
              title: 'Hospital',
              icon: Icon(Icons.local_hospital),
              subtitle: 'Work',
            ),
            GridItem(
              title: '${doctor.availability['yearsOfExperience']} Years',
              icon: const Icon(Icons.medical_information),
              subtitle: 'Experience',
            ),
            const GridItem(
              title: 'Verified',
              icon: Icon(Icons.verified),
              subtitle: 'Profile',
            ),
          ],
        )
      ],
    );
  }
}

class GridItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Icon icon;
  const GridItem({super.key, required this.title, required this.icon,required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: const Color.fromARGB(255, 111, 190, 243),
          radius: 30,
          child: icon
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 17,fontWeight:FontWeight.bold),
        ),
        Text(subtitle)
      ],
    );
  }
}

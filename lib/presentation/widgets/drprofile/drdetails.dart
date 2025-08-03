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
              title: 'Hospital Work',
              icon: Icon(Icons.local_hospital),
            ),
            GridItem(
              title: '${doctor.availability['yearsOfExperience']} Years',
              icon: const Icon(Icons.medical_information),
            ),
            const GridItem(
              title: 'Verified',
              icon: Icon(Icons.verified),
            ),
          ],
        )
      ],
    );
  }
}

class GridItem extends StatelessWidget {
  final String title;
  final Icon icon;
  const GridItem({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.orange[100],
          radius: 30,
          child: icon
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12),
        )
      ],
    );
  }
}

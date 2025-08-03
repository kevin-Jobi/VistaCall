import 'package:flutter/material.dart';
import 'package:vistacall/presentation/widgets/drprofile/dr_card.dart';
import 'package:vistacall/presentation/widgets/drprofile/drdetails.dart';
import 'package:vistacall/utils/constants.dart';

class Drprofile extends StatelessWidget {
  final dynamic doctor;
  const Drprofile({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 199, 228, 240),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DrCard(
                doctor: doctor,
              ),
              Drdetails(
                doctor: doctor,
              ),
              const Text('Working Days'),
              Text('${doctor.availability['availableDays']}'),
              const Text('Consultation Fee'),
              Text('${doctor.availability['fees']}'),
            ],
          ),
        ));
  }
}

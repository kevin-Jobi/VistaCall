import 'package:flutter/material.dart';
import 'package:vistacall/presentation/widgets/drprofile/dr_card.dart';
import 'package:vistacall/presentation/widgets/drprofile/drdetails.dart';

class Drprofile extends StatelessWidget {
  final dynamic doctor;
  const Drprofile({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final isFavourite = true;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 215, 240, 250),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 215, 240, 250),
          title: Row(
            children: [
              Text(
                'Dr.${doctor.personal['fullName'] as String}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 140,),
              IconButton(onPressed: (){}, icon:Icon( isFavourite? Icons.favorite : Icons.favorite_border))
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Align(alignment: Alignment.center,),
              DrCard(
                doctor: doctor,
              ),
              const SizedBox(height: 25,),
              Drdetails(
                doctor: doctor,
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 19),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Working Days',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('${doctor.availability['availableDays']}'),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Consultation Fee',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                    Text('Rs:${doctor.availability['fees']}'),
                  ],
                ),
              ),
              const SizedBox(
                height: 170,
              ),
              Padding(
                padding: const EdgeInsetsGeometry.all(3),
                child: SizedBox(
                  height: 50,
                  width: 500,
                  child: ElevatedButton(
                    onPressed: () {
                      // Your button action here
                      print('Button Pressed!');
                    },
                    child: const Text('Book Appointment'),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

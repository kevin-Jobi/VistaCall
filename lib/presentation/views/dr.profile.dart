import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vistacall/data/models/doctor.dart';
import 'package:vistacall/presentation/widgets/drprofile/dr_card.dart';
import 'package:vistacall/presentation/widgets/drprofile/drdetails.dart';
import 'package:vistacall/viewmodels/favorite_viewmodel.dart';

class Drprofile extends StatelessWidget {
  final DoctorModel doctor;
  const Drprofile({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteViewModel>(
      builder: (context, favoriteViewModel, child) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 215, 240, 250),
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 215, 240, 250),
            title: Row(
              children: [
                Text(
                  'Dr.${doctor.personal['fullName'] as String? ?? 'Unknown'}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 140),
                IconButton(
                  onPressed: favoriteViewModel.error == null
                      ? () => favoriteViewModel.toggleFavorite(doctor,
                          doctorId: doctor.id)
                      : null,
                  icon: Icon(favoriteViewModel.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (favoriteViewModel.error != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      favoriteViewModel.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                DrCard(doctor: doctor),
                const SizedBox(height: 25),
                Drdetails(doctor: doctor),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 19),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Working Days',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                          '${doctor.availability['availableDays'] ?? 'Not available'}'),
                      const SizedBox(height: 20),
                      const Text(
                        'Consultation Fee',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                      Text('Rs:${doctor.availability['fees'] ?? 'N/A'}'),
                    ],
                  ),
                ),
                const SizedBox(height: 170),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        print('Button Pressed!');
                      },
                      child: const Text('Book Appointment'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart'; 

class Drdetails extends StatelessWidget {
  final dynamic doctor; // DoctorModel
  const Drdetails({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    // Safely access averageRating and numRatings
    final double averageRating = doctor.averageRating?.toDouble() ?? 0.0;
    final int numRatings = doctor.numRatings ?? 0;

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
              title: '${doctor.availability['yearsOfExperience'] ?? 0} Years',
              icon: const Icon(Icons.medical_information),
              subtitle: 'Experience',
            ),
            GridItem(
              title: averageRating == 0.0
                  ? 'No Ratings'
                  : '${averageRating.toStringAsFixed(1)} ($numRatings)',
              icon: RatingBarIndicator(
                rating: averageRating,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 20.0,
                direction: Axis.horizontal,
              ),
              subtitle: 'Rating',
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
  final Widget icon; 
  const GridItem({
    super.key,
    required this.title,
    required this.icon,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: const Color.fromARGB(255, 111, 190, 243),
          radius: 30,
          child: icon,
        ),
        const SizedBox(height: 5),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        Text(subtitle),
      ],
    );
  }
}

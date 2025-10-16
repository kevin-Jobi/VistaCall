// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:vistacall/data/models/doctor.dart';
// import 'package:vistacall/presentation/views/book_appointment.dart';
// import 'package:vistacall/presentation/widgets/drprofile/dr_card.dart';
// import 'package:vistacall/presentation/widgets/drprofile/drdetails.dart';
// import 'package:vistacall/viewmodels/favorite_viewmodel.dart';

// class Drprofile extends StatelessWidget {
//   final DoctorModel doctor;
//   const Drprofile({super.key, required this.doctor});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<FavoriteViewModel>(
//       builder: (context, favoriteViewModel, child) {
//         return Scaffold(
//           backgroundColor: const Color.fromARGB(255, 215, 240, 250),
//           appBar: AppBar(
//             backgroundColor: const Color.fromARGB(255, 215, 240, 250),
//             title: Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Dr.${doctor.personal['fullName'] as String? ?? 'Unknown'}',
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 const SizedBox(width: 130),
//                 IconButton(
//                   onPressed: favoriteViewModel.error == null
//                       ? () => favoriteViewModel.toggleFavorite(doctor,
//                           doctorId: doctor.id)
//                       : null,
//                   icon: Icon(favoriteViewModel.isFavorite
//                       ? Icons.favorite
//                       : Icons.favorite_border),
//                 ),
//               ],
//             ),
//           ),
//           body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 if (favoriteViewModel.error != null)
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 16.0),
//                     child: Text(
//                       favoriteViewModel.error!,
//                       style: const TextStyle(color: Colors.red),
//                     ),
//                   ),
//                 DrCard(doctor: doctor),
//                 const SizedBox(height: 25),
//                 Drdetails(doctor: doctor),
//                 const SizedBox(height: 40),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 19),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'Working Days',
//                         style: TextStyle(
//                             fontSize: 19, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 10),
//                       // Text(
//                       //     '${doctor.availability['availableDays'] ?? 'Not available'}'),
//                       Text(_safeCastToStringList(
//                                   doctor.availability['availableDays'])
//                               .join(', ') ??
//                           'Not available'),
//                       const SizedBox(height: 20),
//                       const Text(
//                         'Consultation Fee',
//                         style: TextStyle(
//                             fontSize: 19, fontWeight: FontWeight.bold),
//                       ),
//                       Text('Rs:${doctor.availability['fees'] ?? 'N/A'}'),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 170),
//                 Padding(
//                   padding: const EdgeInsets.all(3),
//                   child: SizedBox(
//                     height: 50,
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => BookAppointment(
//                                       doctor: doctor,
//                                     )));
//                         print('Button Pressed!');
//                       },
//                       child: const Text('Book Appointment'),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   List<String> _safeCastToStringList(dynamic value) {
//     if (value is List) {
//       return value.map((e) => e.toString()).toList();
//     }
//     return [];
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vistacall/data/models/doctor.dart';
import 'package:vistacall/presentation/views/book_appointment.dart';
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
                Expanded(
                  child: Text(
                    'Dr.${doctor.personal['fullName'] as String? ?? 'Unknown'}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 130),
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
            child: SingleChildScrollView(
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
                        // Text(
                        //     '${doctor.availability['availableDays'] ?? 'Not available'}'),
                        Text(_safeCastToStringList(
                                    doctor.availability['availableDays'])
                                .join(', ') ??
                            'Not available'),
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
                  const SizedBox(height: 25),
                  _buildReviewsSection(context),
                  // const SizedBox(height: 170),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(3),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookAppointment(
                                        doctor: doctor,
                                      )));
                          print('Button Pressed!');
                        },
                        child: const Text('Book Appointment'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildReviewsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Patient Reviews',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
              ),
            ),
            Text(
              '${doctor.numRatings} reviews',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  RatingBarIndicator(
                    rating: doctor.averageRating,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '${doctor.averageRating.toStringAsFixed(1)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('doctors')
                      .doc(doctor.id)
                      .collection('reviews')
                      .orderBy('timestamp', descending: true)
                      .limit(5)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            'No reviews yet',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      );
                    }

                    final reviews = snapshot.data!.docs;
                    return Column(
                      children: reviews.map((doc) {
                        final data = doc.data() as Map<String, dynamic>;
                        final rating = (data['rating'] as num?)?.toDouble() ?? 0.0;
                        final reviewText = data['review'] ?? '';
                        final timestamp =
                            (data['timestamp'] as Timestamp?)?.toDate();
                        final formattedDate = timestamp != null
                            ? DateFormat('MMM dd, yyyy').format(timestamp)
                            : 'Unknown date';

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: ReviewCard(
                            rating: rating,
                            reviewText: reviewText,
                            date: formattedDate,
                          ),
                        );
                      }).toList(),
                    );
                  })
            ],
          ),
        )
      ],
    );
  }

  List<String> _safeCastToStringList(dynamic value) {
    if (value is List) {
      return value.map((e) => e.toString()).toList();
    }
    return [];
  }
}

// Custom Review Card Widget
class ReviewCard extends StatelessWidget {
  final double rating;
  final String reviewText;
  final String date;

  const ReviewCard({
    super.key,
    required this.rating,
    required this.reviewText,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rating and Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RatingBarIndicator(
                rating: rating,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 16.0,
                direction: Axis.horizontal,
              ),
              Text(
                date,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Review Text
          Text(
            reviewText,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF1A1A1A),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

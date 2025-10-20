import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:vistacall/data/models/doctor.dart';
import 'package:vistacall/presentation/widgets/drprofile/review_card.dart';
import 'package:vistacall/theme/app_theme.dart';

class DrProfileReviewsSection extends StatelessWidget {
  final DoctorModel doctor;

  const DrProfileReviewsSection({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Patient Reviews',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            Text(
              '${doctor.numRatings} reviews',
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: colorScheme.onSurface.withValues(alpha: 0.06),
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
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: AppTheme.accentColorLight.withValues(alpha: .9),
                    ),
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    doctor.averageRating.toStringAsFixed(1),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
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
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: CircularProgressIndicator(
                          color: colorScheme.primary,
                        ),
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'No reviews yet',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
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
                      final timestamp = (data['timestamp'] as Timestamp?)?.toDate();
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
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
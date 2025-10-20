


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vistacall/data/models/doctor.dart';
import 'package:vistacall/presentation/views/book_appointment.dart';
import 'package:vistacall/presentation/widgets/drprofile/dr_card.dart';
import 'package:vistacall/presentation/widgets/drprofile/drdetails.dart';
import 'package:vistacall/presentation/widgets/drprofile/dr_profile_app_bar.dart';
import 'package:vistacall/presentation/widgets/drprofile/dr_profile_reviews_section.dart';
import 'package:vistacall/viewmodels/favorite_viewmodel.dart';

class Drprofile extends StatelessWidget {
  final DoctorModel doctor;
  const Drprofile({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Consumer<FavoriteViewModel>(
      builder: (context, favoriteViewModel, child) {
        return Scaffold(
          backgroundColor: colorScheme.background,
          appBar: DrProfileAppBar(
            doctor: doctor,
            favoriteViewModel: favoriteViewModel,
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
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.error,
                        ),
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
                        Text(
                          'Working Days',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _safeCastToStringList(doctor.availability['availableDays']).join(', ') ??
                              'Not available',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Consultation Fee',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          'Rs:${doctor.availability['fees'] ?? 'N/A'}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  DrProfileReviewsSection(doctor: doctor),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(3),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookAppointment(doctor: doctor),
                            ),
                          );
                          print('Button Pressed!');
                        },
                        child: Text(
                          'Book Appointment',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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

  List<String> _safeCastToStringList(dynamic value) {
    if (value is List) {
      return value.map((e) => e.toString()).toList();
    }
    return [];
  }
}



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/favorite/favorite_bloc.dart';
import 'package:vistacall/bloc/favorite/favorite_event.dart';
import 'package:vistacall/bloc/favorite/favorite_state.dart';

class FavoriteDoctors extends StatelessWidget {
  const FavoriteDoctors({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocProvider(
      create: (_) => FavoriteDoctorsBloc()..add(LoadFavoriteDoctors()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          title: Text(
            'Favorite Doctors',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onPrimary,
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
        body: BlocBuilder<FavoriteDoctorsBloc, FavoriteDoctorsState>(
          builder: (context, state) {
            if (state is FavoriteDoctorsLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: colorScheme.primary,
                ),
              );
            } else if (state is FavoriteDoctorsLoaded) {
              if (state.doctors.isEmpty) {
                return Center(
                  child: Text(
                    "No favorite doctors found.",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: state.doctors.length,
                itemBuilder: (context, index) {
                  final doctor = state.doctors[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: colorScheme.surface,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: colorScheme.surfaceVariant,
                        backgroundImage: doctor.personal['profileImageUrl'] != null
                            ? NetworkImage(doctor.personal['profileImageUrl'])
                            : const AssetImage('assets/images/dentist.png') as ImageProvider,
                        radius: 24,
                      ),
                      title: Text(
                        doctor.personal['fullName'] ?? 'Unknown Name',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      subtitle: Text(
                        'Experience: ${doctor.availability['yearsOfExperience'] ?? 'N/A'} years | Fees: ${doctor.availability['fees'] ?? 'N/A'}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/drprofile',
                            arguments: {
                              'doctor': doctor,
                              'doctorId': doctor.id,
                            },
                          );
                        },
                        child: Text(
                          'Book',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is FavoriteDoctorsError) {
              return Center(
                child: Text(
                  state.message,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colorScheme.error,
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
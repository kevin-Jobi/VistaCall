import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/favorite/favorite_bloc.dart';
import 'package:vistacall/bloc/favorite/favorite_event.dart';
import 'package:vistacall/bloc/favorite/favorite_state.dart';
import 'package:vistacall/utils/constants.dart';

class FavoriteDoctors extends StatelessWidget {
  const FavoriteDoctors({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoriteDoctorsBloc()..add(LoadFavoriteDoctors()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstants.primaryColor,
          title: const Text('Favorite Doctors'),
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
              return const Center(child: CircularProgressIndicator());
            } else if (state is FavoriteDoctorsLoaded) {
              if (state.doctors.isEmpty) {
                return const Center(child: Text("No favorite doctors found."));
              }
              return ListView.builder(
                itemCount: state.doctors.length,
                itemBuilder: (context, index) {
                  final doctor = state.doctors[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 16, right: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: doctor.personal['imageUrl'] != null
                            ? NetworkImage(doctor.personal['imageUrl'])
                            : const AssetImage('assets/images/dentist.png')
                                as ImageProvider,
                      ),
                      title: Text(
                        doctor.personal['fullName'] ?? 'Unknown Name',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Experience: ${doctor.availability['yearsOfExperience']} years | Fees: ${doctor.availability['fees'] ?? 'N/A'}',
                      ),
                      trailing: ElevatedButton(
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
                        child: const Text('Book'),
                      ),
                    ),
                  );
                },
              );
            } else if (state is FavoriteDoctorsError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_bloc.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_event.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_state.dart';
import 'package:vistacall/utils/constants.dart';

class DoctorListScreen extends StatelessWidget {
  final String department;

  const DoctorListScreen({super.key, required this.department});

  @override
  Widget build(BuildContext context) {
    final doctorListBloc = BlocProvider.of<DoctorListBloc>(context);
    doctorListBloc.add(LoadDoctorsEvent(department));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        title: Text('$department Doctors'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: BlocBuilder<DoctorListBloc, DoctorListState>(
        builder: (context, state) {
          if (state is DoctorListLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DoctorListErrorState) {
            return Center(child: Text(state.error));
          } else if (state is DoctorListLoadedState) {
            final doctors = state.doctors;
            return doctors.isEmpty
                ? const Center(child: Text('No doctors found for this department'))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: doctors.length,
                    itemBuilder: (context, index) {
                      final doctor = doctors[index];
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.only(bottom: 16),
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                          title: Text(
                            doctor.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(doctor.specialty),
                          trailing: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Booking appointment with ${doctor.name}...')),
                              );
                            },
                            child: const Text('Book'),
                          ),
                        ),
                      );
                    },
                  );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
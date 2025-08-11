import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_bloc.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_event.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_state.dart';
import 'package:vistacall/utils/constants.dart';

class DoctorListScreen extends StatefulWidget {
  final String department;

  const DoctorListScreen({super.key, required this.department});

  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  @override
  void initState() {
    super.initState();
    final doctorListBloc = BlocProvider.of<DoctorListBloc>(context);
    doctorListBloc.add(FetchDoctorsByDepartment(widget.department));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        title: Text('${widget.department} Doctor'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: BlocBuilder<DoctorListBloc, DoctorListState>(
        builder: (context, state) {
          if (state is DoctorListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DoctorListErrorState) {
            return Center(child: Text(state.error));
          } else if (state is DoctorListLoaded) {
            final doctors = state.doctors;
            print('Rendering ${doctors.length} doctors'); // Debug log
            if (doctors.isEmpty) {
              return const Center(
                  child: Text('No doctors found for this department'));
            }
            // return doctors.isEmpty
            //     ? const Center(child: Text('No doctors found for this department')):
            return Stack(children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    final doctor = doctors[index];
                    final fullName = doctor.personal?['fullName']?.toString() ??
                        'Unknown'; //
                    final experience = //
                        doctor.availability?['yearsOfExperience']
                                ?.toString() ?? //
                            'N/A'; //
                    final fees =
                        doctor.availability?['fees']?.toString() ?? 'N/A'; //
                    final imageUrl =
                        doctor.personal?['profileImageUrl']?.toString(); //

                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                          backgroundImage:
                              imageUrl != null ? NetworkImage(imageUrl) : null,
                          child: imageUrl == null
                              ? const Icon(Icons.person, color: Colors.white)
                              : null,
                        ),
                        title: Text(
                          doctor.personal['fullName'] as String,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                            'Experience: ${doctor.availability['yearsOfExperience']} years | Fees: ${doctor.availability['fees'] ?? 'N/A'}'),
                        trailing: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/drprofile',
                                arguments: {
                                  'doctor': doctor,
                                  'doctorId': doctor.id,
                                });
                          },
                          child: const Text('Book'),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                  top: 1,
                  right: 10,
                  child: PopupMenuButton(
                      icon: const Icon(Icons.sort),
                      itemBuilder: (BuildContext context) {
                        return [
                          const PopupMenuItem(
                              value: 'experience: Low to High',
                              child: Text('experience: Low to High')),
                          const PopupMenuItem(
                              value: 'experience: High to Low',
                              child: Text('experience: High to Low')),
                          const PopupMenuItem(
                              value: 'Price: Low to High',
                              child: Text('Price: Low to High')),
                          const PopupMenuItem(
                              value: 'Price: High to Low',
                              child: Text('Price: High to Low')),
                        ];
                      }))
            ]);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

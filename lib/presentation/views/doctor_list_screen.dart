
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_bloc.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_event.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_state.dart' as state;
import 'package:vistacall/presentation/views/home/doctor_card.dart';
import 'package:vistacall/presentation/widgets/doctor_list/doctor_list_app_bar.dart';
import 'package:vistacall/presentation/widgets/doctor_list/doctor_list_empty_state.dart';
import 'package:vistacall/presentation/widgets/doctor_list/doctor_list_error_state.dart';
import 'package:vistacall/presentation/widgets/doctor_list/doctor_list_header.dart';

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: DoctorListAppBar(department: widget.department),
      body: BlocBuilder<DoctorListBloc, state.DoctorListState>(
        builder: (context, doctorListState) {
          if (doctorListState is state.DoctorListLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: colorScheme.primary,
                    strokeWidth: 3,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Loading doctors...',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          } else if (doctorListState is state.DoctorListErrorState) {
            return DoctorListErrorState(doctorListState.error);
          } else if (doctorListState is state.DoctorListLoaded) {
            final doctors = doctorListState.doctors;
            if (doctors.isEmpty) {
              return const DoctorListEmptyState();
            }
            return Column(
              children: [
                DoctorListHeader(count: doctors.length),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    itemCount: doctors.length,
                    itemBuilder: (context, index) {
                      final doctor = doctors[index];
                      return DoctorCard(
                        doctor: doctor,
                        onTap: () {
                          Navigator.pushNamed(context, '/drprofile',
                              arguments: {
                                'doctor': doctor,
                                'doctorId': doctor.id,
                              });
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

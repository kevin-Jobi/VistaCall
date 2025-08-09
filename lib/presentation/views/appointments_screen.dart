import 'package:flutter/material.dart' hide ToggleButtons;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/appointments/appointments_bloc.dart';
import 'package:vistacall/bloc/appointments/appointments_state.dart';
import 'package:vistacall/presentation/widgets/appointments/appointments_app_bar.dart';
import 'package:vistacall/presentation/widgets/appointments/appointments_list.dart';
import 'package:vistacall/presentation/widgets/appointments/toggle_buttons.dart';
import 'package:vistacall/presentation/widgets/custom_bottom_navbar.dart';
import 'package:vistacall/utils/constants.dart';

import 'package:vistacall/viewmodels/appointments_viewmodel.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = AppointmentsViewModel(
      BlocProvider.of<AppointmentsBloc>(context),
    )..loadAppointments();

    return Scaffold(
      appBar: const AppointmentsAppBar(),
      body: StreamBuilder<AppointmentsState>(
        stream: viewModel.appointmentsState,
        builder: (context, snapshot) {
          final state = snapshot.data;
          if (state == null || state is AppointmentsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AppointmentsErrorState) {
            return Center(child: Text(state.error));
          }
          if (state is AppointmentsLoadedState) {
            return Column(
              children: [
                ToggleButtons(viewModel: viewModel, state: state),
                AppointmentsList(viewModel: viewModel, state: state),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
        onTap: (index) => _handleNavigation(index, context),
      ),
    );
  }

  void _handleNavigation(int index, BuildContext context) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, AppConstants.homeRoute);
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, AppConstants.messagesRoute);
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, AppConstants.profileRoute);
    }
    // index 1 is current screen (appointments), so no navigation needed
  }
}

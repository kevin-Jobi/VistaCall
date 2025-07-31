
import 'package:flutter/material.dart';
import 'package:vistacall/bloc/appointments/appointments_state.dart';
import 'package:vistacall/utils/constants.dart';
import 'package:vistacall/viewmodels/appointments_viewmodel.dart';

class ToggleButtons extends StatelessWidget {
  final AppointmentsViewModel viewModel;
  final AppointmentsLoadedState state;

  const ToggleButtons({
    super.key,
    required this.viewModel,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildToggleButton(
            text: 'Upcoming',
            isSelected: state.showUpcoming,
            onTap: () => viewModel.toggleAppointmentsView(true),
          ),
          _buildToggleButton(
            text: 'Past',
            isSelected: !state.showUpcoming,
            onTap: () => viewModel.toggleAppointmentsView(false),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppConstants.primaryColor : Colors.grey.shade200,
          borderRadius: BorderRadius.horizontal(
            left: text == 'Upcoming' ? const Radius.circular(20) : Radius.zero,
            right: text == 'Past' ? const Radius.circular(20) : Radius.zero,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
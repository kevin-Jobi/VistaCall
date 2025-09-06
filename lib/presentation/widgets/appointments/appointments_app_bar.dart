
import 'package:flutter/material.dart';
import 'package:vistacall/utils/constants.dart';

class AppointmentsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppointmentsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppConstants.primaryColor,
      title: const Text('Appointment'),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
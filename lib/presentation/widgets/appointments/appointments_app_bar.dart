// import 'package:flutter/material.dart';
// import 'package:vistacall/utils/constants.dart';

// class AppointmentsAppBar extends StatelessWidget
//     implements PreferredSizeWidget {
//   const AppointmentsAppBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: AppConstants.primaryColor,
//       title: const Text(
//         'Appointments',
//         style: TextStyle(
//           fontWeight: FontWeight.w800,
//           fontSize: 22,
//           color: Colors.white,
//           letterSpacing: 0.5,
//           height: 1.2,
//         ),
//       ),
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(20),
//           bottomRight: Radius.circular(20),
//         ),
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }


import 'package:flutter/material.dart';

class AppointmentsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppointmentsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final onPrimary = colorScheme.onPrimary; // White text on primary background

    return AppBar(
      backgroundColor: colorScheme.primary, // Dynamic primary color
      foregroundColor: onPrimary, // Dynamic text/icon color (white)
      title: Text(
        'Appointments',
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w800,
          fontSize: 22,
          color: onPrimary, // Dynamic white text
          letterSpacing: 0.5,
          height: 1.2,
        ) ?? const TextStyle(
          // Fallback if theme text is null
          fontWeight: FontWeight.w800,
          fontSize: 22,
          color: Colors.white,
          letterSpacing: 0.5,
          height: 1.2,
        ),
      ),
      elevation: 0, // Remove default shadow to match custom shape
      shadowColor: theme.shadowColor, // Dynamic shadow color
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      // Ensure theme consistency
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
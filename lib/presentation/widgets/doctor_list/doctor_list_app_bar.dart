// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class DoctorListAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String department;

//   const DoctorListAppBar({super.key, required this.department});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;

//     return PreferredSize(
//       preferredSize: const Size.fromHeight(70),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [colorScheme.primary, colorScheme.primary],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: const BorderRadius.only(
//             bottomLeft: Radius.circular(28),
//             bottomRight: Radius.circular(28),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: colorScheme.primary.withValues(alpha: 0.3),
//               blurRadius: 20,
//               offset: const Offset(0, 8),
//             ),
//           ],
//         ),
//         child: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           toolbarHeight: 70,
//           systemOverlayStyle: SystemUiOverlayStyle(
//             statusBarBrightness:
//                 theme.brightness == Brightness.dark ? Brightness.dark : Brightness.light,
//             statusBarColor: colorScheme.primary,
//           ),
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back_ios_rounded, color: colorScheme.onPrimary),
//             onPressed: () => Navigator.pop(context),
//           ),
//           title: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 '$department Doctors',
//                 style: theme.textTheme.titleLarge?.copyWith(
//                   fontWeight: FontWeight.w700,
//                   color: colorScheme.onPrimary,
//                   letterSpacing: 0.3,
//                 ),
//               ),
//               Text(
//                 'Find your specialist',
//                 style: theme.textTheme.bodySmall?.copyWith(
//                   fontWeight: FontWeight.w400,
//                   color: colorScheme.onPrimary.withValues(alpha: 0.85),
//                   letterSpacing: 0.2,
//                 ),
//               ),
//             ],
//           ),
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(28),
//               bottomRight: Radius.circular(28),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(70);
// }



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vistacall/utils/premium_theme.dart';

class DoctorListAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String department;

  const DoctorListAppBar({super.key, required this.department});

  static const double _toolbarHeight = 76;
  static const BorderRadius _radius = BorderRadius.only(
    bottomLeft: Radius.circular(30),
    bottomRight: Radius.circular(30),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: _radius,
        boxShadow: [
          BoxShadow(
            color: PremiumColors.navy900.withValues(alpha: 0.30),
            blurRadius: 24,
            offset: const Offset(0, 10),
            spreadRadius: -6,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: _radius,
        child: Stack(
          children: [
            const Positioned.fill(
              child: DecoratedBox(
                decoration:
                    BoxDecoration(gradient: PremiumColors.headerGradient),
              ),
            ),
            Positioned(
              top: -40,
              right: -24,
              child: _circle(140, Colors.white.withValues(alpha: 0.05)),
            ),
            Positioned(
              bottom: -52,
              left: -20,
              child: _circle(110, PremiumColors.accent.withValues(alpha: 0.08)),
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              elevation: 0,
              scrolledUnderElevation: 0,
              surfaceTintColor: Colors.transparent,
              toolbarHeight: _toolbarHeight,
              systemOverlayStyle: SystemUiOverlayStyle.light,
              automaticallyImplyLeading: false,
              leadingWidth: 68,
              titleSpacing: 6,
              leading: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Center(
                  child: Semantics(
                    button: true,
                    label: 'Back',
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.09),
                          borderRadius: BorderRadius.circular(13),
                          border: Border.all(
                              color: Colors.white.withValues(alpha: 0.14)),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$department Doctors',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.2,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'FIND YOUR SPECIALIST',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(_toolbarHeight);
}
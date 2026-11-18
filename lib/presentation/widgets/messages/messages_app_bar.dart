// import 'package:flutter/material.dart';
// import 'package:vistacall/utils/constants.dart';

// class MessagesAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const MessagesAppBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: AppConstants.primaryColor,
//       title: const Text(
//         'Messages',
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
import 'package:flutter/services.dart';
import 'package:vistacall/utils/premium_theme.dart';

class MessagesAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MessagesAppBar({super.key});

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
              toolbarHeight: _toolbarHeight,
              centerTitle: false,
              titleSpacing: 20,
              surfaceTintColor: Colors.transparent,
              systemOverlayStyle: SystemUiOverlayStyle.light,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Messages',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'CHAT WITH YOUR DOCTORS',
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
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vistacall/utils/premium_theme.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String doctorName;
  final VoidCallback onBackPressed;

  const ChatAppBar({
    super.key,
    required this.doctorName,
    required this.onBackPressed,
  });

  static const double _toolbarHeight = 76;
  static const BorderRadius _radius = BorderRadius.only(
    bottomLeft: Radius.circular(30),
    bottomRight: Radius.circular(30),
  );
  static const Color _online = Color(0xFF34C38F);

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
                child: Center(child: _buildBackButton()),
              ),
              title: Row(
                children: [
                  Hero(
                    tag: 'avatar_$doctorName',
                    child: _buildDoctorAvatar(),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          doctorName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.5,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.2,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            Container(
                              width: 7,
                              height: 7,
                              decoration: const BoxDecoration(
                                color: _online,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Online',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.65),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: const [],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Semantics(
      button: true,
      label: 'Back',
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onBackPressed,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.09),
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 17,
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorAvatar() {
    return Stack(
      children: [
        Container(
          width: 46,
          height: 46,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [PremiumColors.navy600, PremiumColors.navy800],
            ),
            border: Border.all(color: PremiumColors.accent, width: 1.5),
          ),
          child: Text(
            premiumInitials(doctorName),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: 13,
            height: 13,
            decoration: BoxDecoration(
              color: _online,
              shape: BoxShape.circle,
              border: Border.all(color: PremiumColors.navy800, width: 2),
            ),
          ),
        ),
      ],
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
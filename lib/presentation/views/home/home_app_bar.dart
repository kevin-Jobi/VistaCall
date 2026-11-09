import 'package:flutter/material.dart';
import 'package:vistacall/utils/constants.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  static const double _toolbarHeight = 76;
  static const BorderRadius _radius = BorderRadius.only(
    bottomLeft: Radius.circular(32),
    bottomRight: Radius.circular(32),
  );

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final primary = colorScheme.primary;
    final onPrimary = colorScheme.onPrimary;
    final deepPrimary =
        Color.alphaBlend(Colors.black.withValues(alpha: 0.22), primary);

    return Container(
      decoration: BoxDecoration(
        borderRadius: _radius,
        boxShadow: [
          BoxShadow(
            color: primary.withValues(alpha: 0.28),
            blurRadius: 24,
            offset: const Offset(0, 10),
            spreadRadius: -4,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: _radius,
        child: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primary, deepPrimary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            Positioned(
              top: -44,
              right: -28,
              child: _circle(150, onPrimary.withValues(alpha: 0.08)),
            ),
            Positioned(
              bottom: -56,
              left: -24,
              child: _circle(120, onPrimary.withValues(alpha: 0.06)),
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              scrolledUnderElevation: 0,
              toolbarHeight: _toolbarHeight,
              automaticallyImplyLeading: false,
              centerTitle: false,
              titleSpacing: 20,
              title: _buildBrand(onPrimary),
              actions: [
                _buildProfileButton(context, onPrimary),
                const SizedBox(width: 20),
              ],
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

  Widget _buildBrand(Color onPrimary) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: onPrimary.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: onPrimary.withValues(alpha: 0.28),
              width: 1.2,
            ),
          ),
          child: Icon(
            Icons.local_hospital_rounded,
            color: onPrimary,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'VistaCall',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 22,
                color: onPrimary,
                letterSpacing: 0.2,
                height: 1.15,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Healthcare Platform',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 11.5,
                color: onPrimary.withValues(alpha: 0.8),
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileButton(BuildContext context, Color onPrimary) {
    return Tooltip(
      message: 'Profile',
      child: Material(
        color: onPrimary.withValues(alpha: 0.18),
        shape: CircleBorder(
          side: BorderSide(
            color: onPrimary.withValues(alpha: 0.35),
            width: 1.5,
          ),
        ),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () {
            Navigator.pushNamed(context, AppConstants.profileRoute);
          },
          child: SizedBox(
            width: 46,
            height: 46,
            child: Icon(Icons.person_rounded, color: onPrimary, size: 24),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(_toolbarHeight);
}
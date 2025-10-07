import 'package:flutter/material.dart';
import 'package:vistacall/utils/constants.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF42A5F5),
            Color(0xFF1E88E5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: AppConstants.primaryColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
        ],
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLogo(),
              _buildProfileButton(context),
            ],
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(28),
            bottomRight: Radius.circular(28),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      children: [
        // Container(
        //   padding: const EdgeInsets.all(10),
        //   decoration: BoxDecoration(
        //     color: Colors.white.withOpacity(0.2),
        //     borderRadius: BorderRadius.circular(14),
        //     border: Border.all(
        //       color: Colors.white.withOpacity(0.3),
        //       width: 1.5,
        //     ),
        //   ),
        //   child: const Icon(
        //     Icons.local_hospital_rounded,
        //     color: Colors.white,
        //     size: 24,
        //   ),
        // ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'VistaCall',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 22,
                color: Colors.white,
                letterSpacing: 0.5,
                height: 1.2,
              ),
            ),
            Text(
              'Healthcare Platform',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 11,
                color: Colors.white.withOpacity(0.85),
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 22,
        backgroundColor: Colors.white.withOpacity(0.25),
        child: IconButton(
          icon: const Icon(Icons.person_rounded),
          color: Colors.white,
          iconSize: 24,
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.pushNamed(context, AppConstants.profileRoute);
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

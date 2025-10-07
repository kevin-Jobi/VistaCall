import 'package:flutter/material.dart';
import 'package:vistacall/utils/constants.dart';

class MessagesAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MessagesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppConstants.primaryColor,
      title: const Text(
        'Messages',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 22,
          color: Colors.white,
          letterSpacing: 0.5,
          height: 1.2,
        ),
      ),
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

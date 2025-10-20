import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DoctorListAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String department;

  const DoctorListAppBar({super.key, required this.department});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorScheme.primary, colorScheme.primary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(28),
            bottomRight: Radius.circular(28),
          ),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 70,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness:
                theme.brightness == Brightness.dark ? Brightness.dark : Brightness.light,
            statusBarColor: colorScheme.primary,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded, color: colorScheme.onPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$department Doctors',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onPrimary,
                  letterSpacing: 0.3,
                ),
              ),
              Text(
                'Find your specialist',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: colorScheme.onPrimary.withValues(alpha: 0.85),
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(28),
              bottomRight: Radius.circular(28),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
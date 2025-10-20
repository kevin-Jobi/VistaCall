import 'package:flutter/material.dart';
import 'package:vistacall/data/models/doctor.dart';
import 'package:vistacall/viewmodels/favorite_viewmodel.dart';

class DrProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final DoctorModel doctor;
  final FavoriteViewModel favoriteViewModel;

  const DrProfileAppBar({
    super.key,
    required this.doctor,
    required this.favoriteViewModel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppBar(
      backgroundColor: colorScheme.background,
      elevation: 0,
      title: Row(
        children: [
          Expanded(
            child: Text(
              'Dr.${doctor.personal['fullName'] as String? ?? 'Unknown'}',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onBackground,
              ),
            ),
          ),
          const SizedBox(width: 130),
          IconButton(
            onPressed: favoriteViewModel.error == null
                ? () => favoriteViewModel.toggleFavorite(doctor, doctorId: doctor.id)
                : null,
            icon: Icon(
              favoriteViewModel.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: favoriteViewModel.isFavorite
                  ? colorScheme.error
                  : colorScheme.onBackground,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
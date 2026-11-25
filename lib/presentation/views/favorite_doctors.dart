// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vistacall/bloc/favorite/favorite_bloc.dart';
// import 'package:vistacall/bloc/favorite/favorite_event.dart';
// import 'package:vistacall/bloc/favorite/favorite_state.dart';

// class FavoriteDoctors extends StatelessWidget {
//   const FavoriteDoctors({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;

//     return BlocProvider(
//       create: (_) => FavoriteDoctorsBloc()..add(LoadFavoriteDoctors()),
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: colorScheme.primary,
//           foregroundColor: colorScheme.onPrimary,
//           title: Text(
//             'Favorite Doctors',
//             style: theme.textTheme.titleLarge?.copyWith(
//               fontWeight: FontWeight.bold,
//               color: colorScheme.onPrimary,
//             ),
//           ),
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(20),
//               bottomRight: Radius.circular(20),
//             ),
//           ),
//         ),
//         body: BlocBuilder<FavoriteDoctorsBloc, FavoriteDoctorsState>(
//           builder: (context, state) {
//             if (state is FavoriteDoctorsLoading) {
//               return Center(
//                 child: CircularProgressIndicator(
//                   color: colorScheme.primary,
//                 ),
//               );
//             } else if (state is FavoriteDoctorsLoaded) {
//               if (state.doctors.isEmpty) {
//                 return Center(
//                   child: Text(
//                     "No favorite doctors found.",
//                     style: theme.textTheme.bodyLarge?.copyWith(
//                       color: colorScheme.onSurfaceVariant,
//                     ),
//                   ),
//                 );
//               }
//               return ListView.builder(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 itemCount: state.doctors.length,
//                 itemBuilder: (context, index) {
//                   final doctor = state.doctors[index];
//                   return Card(
//                     elevation: 2,
//                     margin: const EdgeInsets.only(bottom: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     color: colorScheme.surface,
//                     child: ListTile(
//                       leading: CircleAvatar(
//                         backgroundColor: colorScheme.surfaceVariant,
//                         backgroundImage: doctor.personal['profileImageUrl'] !=
//                                 null
//                             ? NetworkImage(doctor.personal['profileImageUrl'])
//                             : const AssetImage('assets/images/dentist.png')
//                                 as ImageProvider,
//                         radius: 24,
//                       ),
//                       title: Text(
//                         doctor.personal['fullName'] ?? 'Unknown Name',
//                         style: theme.textTheme.titleMedium?.copyWith(
//                           fontWeight: FontWeight.bold,
//                           color: colorScheme.onSurface,
//                         ),
//                       ),
//                       subtitle: Text(
//                         'Experience: ${doctor.availability['yearsOfExperience'] ?? 'N/A'} years | Fees: ${doctor.availability['fees'] ?? 'N/A'}',
//                         style: theme.textTheme.bodyMedium?.copyWith(
//                           color: colorScheme.onSurfaceVariant,
//                         ),
//                       ),
//                       trailing: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: colorScheme.primary,
//                           foregroundColor: colorScheme.onPrimary,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         onPressed: () {
//                           Navigator.pushNamed(
//                             context,
//                             '/drprofile',
//                             arguments: {
//                               'doctor': doctor,
//                               'doctorId': doctor.id,
//                             },
//                           );
//                         },
//                         child: Text(
//                           'Book',
//                           style: theme.textTheme.labelMedium?.copyWith(
//                             color: colorScheme.onPrimary,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             } else if (state is FavoriteDoctorsError) {
//               return Center(
//                 child: Text(
//                   state.message,
//                   style: theme.textTheme.bodyLarge?.copyWith(
//                     color: colorScheme.error,
//                   ),
//                 ),
//               );
//             }
//             return const SizedBox.shrink();
//           },
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/favorite/favorite_bloc.dart';
import 'package:vistacall/bloc/favorite/favorite_event.dart';
import 'package:vistacall/bloc/favorite/favorite_state.dart';
import 'package:vistacall/utils/premium_theme.dart';

class FavoriteDoctors extends StatelessWidget {
  const FavoriteDoctors({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoriteDoctorsBloc()..add(LoadFavoriteDoctors()),
      child: Scaffold(
        backgroundColor: PremiumColors.surface,
        appBar: const _FavoritesAppBar(),
        body: BlocBuilder<FavoriteDoctorsBloc, FavoriteDoctorsState>(
          builder: (context, state) {
            if (state is FavoriteDoctorsLoading) {
              return Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: PremiumColors.line),
                    boxShadow: PremiumColors.softShadow(0.10),
                  ),
                  child: const CircularProgressIndicator(
                    color: PremiumColors.navy600,
                    strokeWidth: 3,
                  ),
                ),
              );
            } else if (state is FavoriteDoctorsLoaded) {
              if (state.doctors.isEmpty) {
                return const _EmptyState();
              }
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(
                  20,
                  22,
                  20,
                  MediaQuery.of(context).padding.bottom + 24,
                ),
                itemCount: state.doctors.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final doctor = state.doctors[index];
                  final name = (doctor.personal['fullName'] ?? 'Unknown Name')
                      .toString();
                  final imageUrl =
                      doctor.personal['profileImageUrl']?.toString();
                  final department =
                      doctor.personal['department']?.toString() ?? '';
                  final experience =
                      '${doctor.availability['yearsOfExperience'] ?? 'N/A'}';
                  final fees = '${doctor.availability['fees'] ?? 'N/A'}';

                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: PremiumColors.line),
                      boxShadow: PremiumColors.softShadow(),
                    ),
                    child: Row(
                      children: [
                        PremiumAvatar(
                          initials: premiumInitials(name),
                          size: 56,
                          imageUrl: imageUrl,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.1,
                                  color: PremiumColors.ink,
                                ),
                              ),
                              if (department.isNotEmpty) ...[
                                const SizedBox(height: 3),
                                Text(
                                  department,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12.5,
                                    color: PremiumColors.muted,
                                  ),
                                ),
                              ],
                              const SizedBox(height: 10),
                              Wrap(
                                spacing: 10,
                                runSpacing: 6,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: PremiumColors.accent
                                          .withValues(alpha: 0.14),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.workspace_premium_rounded,
                                          size: 14,
                                          color: PremiumColors.accent,
                                        ),
                                        const SizedBox(width: 3),
                                        Text(
                                          '$experience yrs',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: PremiumColors.ink,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '₹$fees',
                                          style: const TextStyle(
                                            fontSize: 14.5,
                                            fontWeight: FontWeight.w700,
                                            color: PremiumColors.navy800,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: ' /visit',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: PremiumColors.muted,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            gradient: PremiumColors.navyGradient,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: PremiumColors.navy800
                                    .withValues(alpha: 0.28),
                                blurRadius: 12,
                                offset: const Offset(0, 5),
                                spreadRadius: -2,
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(14),
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/drprofile',
                                  arguments: {
                                    'doctor': doctor,
                                    'doctorId': doctor.id,
                                  },
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 11),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Book',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(
                                      Icons.arrow_outward_rounded,
                                      size: 15,
                                      color: PremiumColors.accent,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (state is FavoriteDoctorsError) {
              return Center(
                child: Container(
                  margin: const EdgeInsets.all(24),
                  padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(26),
                    border: Border.all(
                        color: PremiumColors.danger.withValues(alpha: 0.25)),
                    boxShadow: PremiumColors.softShadow(0.07),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: PremiumColors.danger.withValues(alpha: 0.08),
                        ),
                        child: const Icon(
                          Icons.error_outline_rounded,
                          color: PremiumColors.danger,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14.5,
                          height: 1.45,
                          fontWeight: FontWeight.w500,
                          color: PremiumColors.ink,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 0, 32, 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 112,
              height: 112,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: PremiumColors.navy800.withValues(alpha: 0.06),
              ),
              child: Center(
                child: Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: PremiumColors.navyGradient,
                    border: Border.all(
                      color: PremiumColors.accent.withValues(alpha: 0.5),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: PremiumColors.navy800.withValues(alpha: 0.25),
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                        spreadRadius: -4,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.favorite_border_rounded,
                    size: 36,
                    color: PremiumColors.accent,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 26),
            const Text(
              'No favorite doctors found.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
                color: PremiumColors.ink,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Doctors you save will appear here',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.5,
                height: 1.45,
                color: PremiumColors.muted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoritesAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _FavoritesAppBar();

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
                      onTap: () => Navigator.maybePop(context),
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
                  const Text(
                    'Favorite Doctors',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.2,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'YOUR SAVED SPECIALISTS',
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



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';
// import 'package:vistacall/bloc/profile/profile_bloc.dart';
// import 'package:vistacall/bloc/profile/profile_state.dart';
// import 'package:vistacall/presentation/widgets/custom_widgets/custom_bottom_navbar.dart';
// import 'package:vistacall/presentation/widgets/profile/profile_header.dart';
// import 'package:vistacall/presentation/widgets/profile/profile_options_list.dart';
// import 'package:vistacall/utils/constants.dart';
// import 'package:vistacall/viewmodels/profile_viewmodel.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<ProfileViewModel>(
//       create: (context) => ProfileViewModel(
//         BlocProvider.of<ProfileBloc>(context),
//       ),
//       child: const _ProfileScreenContent(),
//     );
//   }
// }

// class _ProfileScreenContent extends StatelessWidget {
//   const _ProfileScreenContent();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8FAFC),
//       body: SafeArea(
//         child: MultiBlocListener(
//           listeners: [
//             BlocListener<ProfileBloc, ProfileState>(
//               listener: (context, state) {
//                 final viewModel = Provider.of<ProfileViewModel>(context, listen: false);
//                 _handleStateSideEffects(context, state, viewModel);
//               },
//             ),
//           ],
//           child: Consumer<ProfileViewModel>(
//             builder: (context, viewModel, child) {
//               return BlocBuilder<ProfileBloc, ProfileState>(
//                 builder: (context, state) {
//                   return _buildBody(context, viewModel, state);
//                 },
//               );
//             },
//           ),
//         ),
//       ),
//       bottomNavigationBar: Consumer<ProfileViewModel>(
//         builder: (context, viewModel, child) {
//           return CustomBottomNavBar(
//             currentIndex: 3,
//             onTap: (index) => viewModel.handleNavigation(index, context),
//           );
//         },
//       ),
//     );
//   }

//   void _handleStateSideEffects(
//     BuildContext context,
//     ProfileState state,
//     ProfileViewModel viewModel,
//   ) {
//     if (state is ProfileLoggedOutState) {
//       print('ProfileLoggedOutState emitted, navigating to AuthScreen...');
//       Navigator.pushNamedAndRemoveUntil(
//         context,
//         AppConstants.authRoute,
//         (route) => false,
//       );
//     } else if (state is ProfileErrorState) {
//       print('ProfileErrorState emitted: ${state.error}');
//       viewModel.showSnackBar(
//         context,
//         state.error,
//         icon: Icons.error_outline,
//         color: Colors.red,
//       );
//     }
//   }

//   Widget _buildBody(BuildContext context, ProfileViewModel viewModel, ProfileState state) {
//     // Loading state
//     if (viewModel.isLoadingState(state)) {
//       return _buildLoadingState();
//     }

//     // Error state
//     final error = viewModel.getErrorMessage(state);
//     if (error != null) {
//       return _buildErrorState(error, viewModel);
//     }

//     // Success state
//     return RefreshIndicator(
//       onRefresh: () async => viewModel.refreshProfile(),
//       child: CustomScrollView(
//         slivers: [
//           const SliverToBoxAdapter(child: _ModernHeader()),
//           SliverToBoxAdapter(
//             child: ProfileHeader(
//               name: viewModel.getName(state),
//               email: viewModel.getEmail(state),
//               photoUrl: viewModel.getPhotoUrl(state),
//               onEdit: () => viewModel.editProfile(context),
//             ),
//           ),
//           SliverFillRemaining(
//             hasScrollBody: false,
//             child: _buildProfileOptions(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProfileOptions() {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(32),
//           topRight: Radius.circular(32),
//         ),
//       ),
//       child: const ClipRRect(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(32),
//           topRight: Radius.circular(32),
//         ),
//         child: ProfileOptionsList(),
//       ),
//     );
//   }

//   Widget _buildLoadingState() {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Color(0xFFF8FAFC), Color(0xFFE2E8F0)],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         ),
//       ),
//       child: const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2196F3)),
//               strokeWidth: 3,
//             ),
//             SizedBox(height: 24),
//             Text(
//               'Loading your profile...',
//               style: TextStyle(
//                 color: Colors.grey,
//                 fontSize: 16,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildErrorState(String error, ProfileViewModel viewModel) {
//     return RefreshIndicator(
//       onRefresh: () async => viewModel.refreshProfile(),
//       child: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Colors.red.shade50,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Icons.error_outline_rounded,
//                   size: 48,
//                   color: Colors.red.shade600,
//                 ),
//               ),
//               const SizedBox(height: 24),
//               Text(
//                 'Something went wrong',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.grey.shade800,
//                 ),
//               ),
//               const SizedBox(height: 12),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 40),
//                 child: Text(
//                   error,
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey.shade600,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               const SizedBox(height: 24),
//               ElevatedButton.icon(
//                 onPressed: viewModel.refreshProfile,
//                 icon: const Icon(Icons.refresh),
//                 label: const Text('Retry'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppConstants.primaryColor,
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 24,
//                     vertical: 12,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _ModernHeader extends StatelessWidget {
//   const _ModernHeader();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               gradient: const LinearGradient(
//                 colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
//               ),
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: const Icon(
//               Icons.person_rounded,
//               color: Colors.white,
//               size: 24,
//             ),
//           ),
//           const SizedBox(width: 16),
//           const Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'My Profile',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 Text(
//                   'Manage your account settings',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:vistacall/bloc/profile/profile_bloc.dart';
import 'package:vistacall/bloc/profile/profile_state.dart';
import 'package:vistacall/presentation/widgets/custom_widgets/custom_bottom_navbar.dart';
import 'package:vistacall/presentation/widgets/profile/profile_header.dart';
import 'package:vistacall/presentation/widgets/profile/profile_options_list.dart';
import 'package:vistacall/utils/constants.dart';
import 'package:vistacall/utils/premium_theme.dart';
import 'package:vistacall/viewmodels/profile_viewmodel.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileViewModel>(
      create: (context) => ProfileViewModel(
        BlocProvider.of<ProfileBloc>(context),
      ),
      child: const _ProfileScreenContent(),
    );
  }
}

class _ProfileScreenContent extends StatelessWidget {
  const _ProfileScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PremiumColors.surface,
      extendBody: true, // content scrolls behind the floating nav bar
      // No SafeArea here: the navy header draws behind the status bar itself.
      body: MultiBlocListener(
        listeners: [
          BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              final viewModel =
                  Provider.of<ProfileViewModel>(context, listen: false);
              _handleStateSideEffects(context, state, viewModel);
            },
          ),
        ],
        child: Consumer<ProfileViewModel>(
          builder: (context, viewModel, child) {
            return BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                return _buildBody(context, viewModel, state);
              },
            );
          },
        ),
      ),
      bottomNavigationBar: Consumer<ProfileViewModel>(
        builder: (context, viewModel, child) {
          return CustomBottomNavBar(
            currentIndex: 3,
            onTap: (index) => viewModel.handleNavigation(index, context),
          );
        },
      ),
    );
  }

  void _handleStateSideEffects(
    BuildContext context,
    ProfileState state,
    ProfileViewModel viewModel,
  ) {
    if (state is ProfileLoggedOutState) {
      print('ProfileLoggedOutState emitted, navigating to AuthScreen...');
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppConstants.authRoute,
        (route) => false,
      );
    } else if (state is ProfileErrorState) {
      print('ProfileErrorState emitted: ${state.error}');
      viewModel.showSnackBar(
        context,
        state.error,
        icon: Icons.error_outline,
        color: PremiumColors.danger,
      );
    }
  }

  Widget _buildBody(
      BuildContext context, ProfileViewModel viewModel, ProfileState state) {
    // Loading state
    if (viewModel.isLoadingState(state)) {
      return SafeArea(child: _buildLoadingState());
    }

    // Error state
    final error = viewModel.getErrorMessage(state);
    if (error != null) {
      return SafeArea(child: _buildErrorState(error, viewModel));
    }

    // Success state
    return RefreshIndicator(
      color: PremiumColors.accent,
      backgroundColor: PremiumColors.navy800,
      edgeOffset: MediaQuery.of(context).padding.top + 60,
      onRefresh: () async => viewModel.refreshProfile(),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        slivers: [
          const SliverToBoxAdapter(child: _ModernHeader()),
          SliverToBoxAdapter(
            child: ProfileHeader(
              name: viewModel.getName(state),
              email: viewModel.getEmail(state),
              photoUrl: viewModel.getPhotoUrl(state),
              onEdit: () => viewModel.editProfile(context),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: _buildProfileOptions(),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOptions() {
    return const ProfileOptionsList();
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: PremiumColors.line),
              boxShadow: PremiumColors.softShadow(0.10),
            ),
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(PremiumColors.navy600),
              strokeWidth: 3,
            ),
          ),
          const SizedBox(height: 22),
          const Text(
            'Loading your profile...',
            style: TextStyle(
              color: PremiumColors.muted,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error, ProfileViewModel viewModel) {
    return RefreshIndicator(
      color: PremiumColors.accent,
      backgroundColor: PremiumColors.navy800,
      onRefresh: () async => viewModel.refreshProfile(),
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(24),
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 26),
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
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: PremiumColors.danger.withValues(alpha: 0.08),
                      ),
                      child: const Icon(
                        Icons.error_outline_rounded,
                        size: 36,
                        color: PremiumColors.danger,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Something went wrong',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: PremiumColors.ink,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      error,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.45,
                        color: PremiumColors.muted,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _RetryButton(onPressed: viewModel.refreshProfile),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RetryButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _RetryButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: PremiumColors.navyGradient,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: PremiumColors.navy800.withValues(alpha: 0.28),
            blurRadius: 14,
            offset: const Offset(0, 6),
            spreadRadius: -2,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onPressed,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.refresh_rounded,
                    size: 18, color: PremiumColors.accent),
                SizedBox(width: 8),
                Text(
                  'Retry',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ModernHeader extends StatelessWidget {
  const _ModernHeader();

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          gradient: PremiumColors.headerGradient,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(36)),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -50,
              right: -30,
              child: _circle(160, Colors.white.withValues(alpha: 0.05)),
            ),
            Positioned(
              bottom: -60,
              left: -24,
              child: _circle(130, PremiumColors.accent.withValues(alpha: 0.08)),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, top + 22, 20, 36),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: PremiumColors.accent.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(17),
                      border: Border.all(
                        color: PremiumColors.accent.withValues(alpha: 0.55),
                        width: 1.2,
                      ),
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      color: PremiumColors.accent,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Profile',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.3,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Manage your account settings',
                          style: TextStyle(
                            fontSize: 13.5,
                            color: Color(0xA6FFFFFF),
                          ),
                        ),
                      ],
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
}



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:vistacall/bloc/profile/profile_bloc.dart';
import 'package:vistacall/bloc/profile/profile_state.dart';
import 'package:vistacall/presentation/widgets/custom_widgets/custom_bottom_navbar.dart';
import 'package:vistacall/presentation/widgets/profile/profile_header.dart';
import 'package:vistacall/presentation/widgets/profile/profile_options_list.dart';
import 'package:vistacall/utils/constants.dart';
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
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: MultiBlocListener(
          listeners: [
            BlocListener<ProfileBloc, ProfileState>(
              listener: (context, state) {
                final viewModel = Provider.of<ProfileViewModel>(context, listen: false);
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
        color: Colors.red,
      );
    }
  }

  Widget _buildBody(BuildContext context, ProfileViewModel viewModel, ProfileState state) {
    // Loading state
    if (viewModel.isLoadingState(state)) {
      return _buildLoadingState();
    }

    // Error state
    final error = viewModel.getErrorMessage(state);
    if (error != null) {
      return _buildErrorState(error, viewModel);
    }

    // Success state
    return RefreshIndicator(
      onRefresh: () async => viewModel.refreshProfile(),
      child: CustomScrollView(
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
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: const ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        child: ProfileOptionsList(),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF8FAFC), Color(0xFFE2E8F0)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2196F3)),
              strokeWidth: 3,
            ),
            SizedBox(height: 24),
            Text(
              'Loading your profile...',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String error, ProfileViewModel viewModel) {
    return RefreshIndicator(
      onRefresh: () async => viewModel.refreshProfile(),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.error_outline_rounded,
                  size: 48,
                  color: Colors.red.shade600,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Something went wrong',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  error,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: viewModel.refreshProfile,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.person_rounded,
              color: Colors.white,
              size: 24,
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
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'Manage your account settings',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
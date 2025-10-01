
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/profile/profile_state.dart';
import 'package:vistacall/presentation/widgets/custom_bottom_navbar.dart';
import 'package:vistacall/presentation/widgets/profile/profile_header.dart';
import 'package:vistacall/presentation/widgets/profile/profile_options_list.dart';
import 'package:vistacall/utils/constants.dart';
import 'package:vistacall/bloc/profile/profile_bloc.dart';
import 'package:vistacall/viewmodels/profile_viewmodel.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ProfileViewModel(context.read<ProfileBloc>());
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileLoggedOutState) {
              print('ProfileLoggedOutState emitted, navigating to AuthScreen...');
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppConstants.authRoute,
                (route) => false,
              );
            } else if (state is ProfileErrorState) {
              print('ProfileErrorState emitted: ${state.error}');
              _showModernSnackBar(context, state.error, Icons.error_outline, Colors.red);
            }
          },
          builder: (context, state) {
            if (viewModel.isLoading(state)) {
              return _buildLoadingState();
            } else if (viewModel.getErrorMessage(state) != null) {
              return _buildErrorState(viewModel.getErrorMessage(state)!);
            } else {
              return Column(
                children: [
                  _buildModernHeader(),
                  const SizedBox(height: 20),
                  ProfileHeader(
                    name: viewModel.getName(state),
                    email: viewModel.getEmail(state),
                    photoUrl: viewModel.getPhotoUrl(state),
                    onEdit: () => viewModel.editProfile(context),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        ),
                        child: ProfileOptionsList(
                          onLogout: () async {
                            final confirm = await viewModel.confirmLogout(context);
                            if (confirm) {
                              viewModel.logout();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 3,
        onTap: (index) => viewModel.handleNavigation(index, context),
      ),
    );
  }

  Widget _buildModernHeader() {
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

  Widget _buildErrorState(String error) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Center(
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
            const SizedBox(height: 8),
            Text(
              error,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showModernSnackBar(BuildContext context, String message, IconData icon, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
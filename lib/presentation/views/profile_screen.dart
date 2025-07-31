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
      body: SafeArea(
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileLoggedOutState) {
              print(
                'ProfileLoggedOutState emitted, navigating to AuthScreen...',
              );
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppConstants.authRoute,
                (route) => false,
              );
            } else if (state is ProfileErrorState) {
              print('ProfileErrorState emitted: ${state.error}');
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            if (viewModel.isLoading(state)) {
              return const Center(child: CircularProgressIndicator());
            } else if (viewModel.getErrorMessage(state) != null) {
              return Center(child: Text(viewModel.getErrorMessage(state)!));
            } else {
              return Column(
                children: [
                  ProfileHeader(
                    name: viewModel.getName(state),
                    email: viewModel.getEmail(state),
                    photoUrl: viewModel.getPhotoUrl(state),
                  ),
                  const Divider(),
                  Expanded(
                    child: ProfileOptionsList(
                      onLogout: () async {
                        final confirm = await viewModel.confirmLogout(context);
                        if (confirm) {
                          viewModel.logout();
                        }
                      },
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

  void _handleLogout(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppConstants.authRoute,
      (route) => false,
    );
  }

  Future<void> _handleLogoutConfirmation(
    BuildContext context,
    ProfileViewModel viewModel,
  ) async {
    final confirm = await viewModel.confirmLogout(context);
    if (confirm) {
      viewModel.logout();
    }
  }

  void _showErrorSnackbar(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
  }
}

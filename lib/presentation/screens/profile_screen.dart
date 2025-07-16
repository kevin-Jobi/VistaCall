import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/profile/profile_state.dart';
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
              print('ProfileLoggedOutState emitted, navigating to AuthScreen...');
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppConstants.authRoute,
                (route) => false,
              );
            } else if (state is ProfileErrorState) {
              print('ProfileErrorState emitted: ${state.error}');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
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
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 3,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, AppConstants.homeRoute);
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, AppConstants.appointmentsRoute);
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, AppConstants.messagesRoute);
          }
        },
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String? photoUrl;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey.shade200,
            foregroundColor: Colors.transparent,
            child: ClipOval(
              child: photoUrl != null
                  ? Image.network(
                      photoUrl!,
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                      errorBuilder: (context, error, stackTrace) {
                        return const Text(
                          'Profile Image\n(assets/images/profile_image.png)',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        );
                      },
                    )
                  : Image.asset(
                      'assets/images/profile_image.png',
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                      errorBuilder: (context, error, stackTrace) {
                        return const Text(
                          'Profile Image\n(assets/images/profile_image.png)',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        );
                      },
                    ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A3C34),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    Icons.email,
                    color: Colors.grey,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    email,
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileOptionsList extends StatelessWidget {
  final VoidCallback onLogout;

  const ProfileOptionsList({
    super.key,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProfileOptionItem(
          icon: Icons.group,
          title: 'Invite Friends',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invite Friends feature coming soon!')),
            );
          },
        ),
        ProfileOptionItem(
          icon: Icons.feedback,
          title: 'Feed Back',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Feedback feature coming soon!')),
            );
          },
        ),
        ProfileOptionItem(
          icon: Icons.lock,
          title: 'Privacy And Policy',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Privacy And Policy page coming soon!')),
            );
          },
        ),
        ProfileOptionItem(
          icon: Icons.description,
          title: 'Terms And Conditions',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Terms And Conditions page coming soon!')),
            );
          },
        ),
        ProfileOptionItem(
          icon: Icons.logout,
          title: 'LogOut',
          textColor: Colors.red,
          onTap: onLogout,
        ),
      ],
    );
  }
}

class ProfileOptionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color? textColor;
  final VoidCallback onTap;

  const ProfileOptionItem({
    super.key,
    required this.icon,
    required this.title,
    this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? Colors.grey),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? Colors.black,
          fontWeight: title == 'LogOut' ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppConstants.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: AppConstants.primaryColor,
        unselectedItemColor: Colors.grey.shade500,
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            activeIcon: Icon(Icons.home, size: 28),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            activeIcon: Icon(Icons.calendar_today, size: 28),
            label: 'Appointment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            activeIcon: Icon(Icons.chat, size: 28),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            activeIcon: Icon(Icons.person, size: 28),
            label: 'Profile',
          ),
        ],
        onTap: onTap,
      ),
    );
  }
}
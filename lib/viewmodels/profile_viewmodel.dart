import 'package:flutter/material.dart';
import 'package:vistacall/bloc/profile/profile_bloc.dart';
import 'package:vistacall/bloc/profile/profile_event.dart';
import 'package:vistacall/bloc/profile/profile_state.dart';
import 'package:vistacall/utils/constants.dart';

class ProfileViewModel {
  final ProfileBloc profileBloc;

  ProfileViewModel(this.profileBloc) {
    loadProfile();
  }

  void loadProfile() {
    profileBloc.add(LoadProfileEvent());
  }

  bool isLoading(ProfileState state) {
    return state is ProfileLoadingState;
  }

  String? getErrorMessage(ProfileState state) {
    if (state is ProfileErrorState) {
      return state.error;
    }
    return null;
  }

  String getName(ProfileState state) {
    if (state is ProfileLoadedState) {
      return state.name;
    }
    return '';
  }

  String getEmail(ProfileState state) {
    if (state is ProfileLoadedState) {
      return state.email;
    }
    return '';
  }

  String? getPhotoUrl(ProfileState state) {
    if (state is ProfileLoadedState) {
      return state.photoUrl;
    }
    return null;
  }

  Future<bool> confirmLogout(BuildContext context) async {
    final confirmLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
    return confirmLogout ?? false;
  }

  void logout() {
    profileBloc.add(LogoutEvent());
  }

    void handleNavigation(int index, BuildContext context) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, AppConstants.homeRoute);
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, AppConstants.appointmentsRoute);
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, AppConstants.messagesRoute);
    }
  }
}
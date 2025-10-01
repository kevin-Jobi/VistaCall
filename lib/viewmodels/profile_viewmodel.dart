


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
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

  Future<void> editProfile(BuildContext context) async {
    final state = profileBloc.state;
    final currentName = getName(state);
    final nameController = TextEditingController(text: currentName);
    String? selectedImagePath;

    await showDialog<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Edit Profile'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          final picker = ImagePicker();
                          final image = await picker.pickImage(
                            source: ImageSource.gallery,
                            maxWidth: 1024,
                            imageQuality: 85,
                          );
                          if (image != null) {
                            setState(() {
                              selectedImagePath = image.path;
                            });
                          }
                        },
                        icon: const Icon(Icons.photo_library),
                        label: const Text('Change photo'),
                      ),
                      const SizedBox(width: 8),
                      if (selectedImagePath != null)
                        const Icon(Icons.check_circle, color: Colors.green),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    profileBloc.add(UpdateProfileEvent(
                      name: nameController.text.trim(),
                      imagePath: selectedImagePath,
                    ));
                    Navigator.pop(context);
                    final newState = profileBloc.state;
                    if (newState is ProfileLoadedState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Profile updated successfully!')),
                      );
                    } else if (newState is ProfileErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to update profile: ${newState.error}')),
                      );
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
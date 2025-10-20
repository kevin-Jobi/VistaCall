
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vistacall/bloc/profile/profile_bloc.dart';
import 'package:vistacall/bloc/profile/profile_event.dart';
import 'package:vistacall/bloc/profile/profile_state.dart';
import 'package:vistacall/utils/constants.dart';

class ProfileViewModel extends ChangeNotifier {
  final ProfileBloc _profileBloc;
  final ImagePicker _imagePicker = ImagePicker();

  bool _isLoading = false;
  String? _error;

  // Public getters
  bool get isLoading => _isLoading;
  String? get error => _error;
  ProfileBloc get profileBloc => _profileBloc;

  ProfileViewModel(this._profileBloc) {
    _setupStreamListeners();
    _loadProfileData();
  }

  /// Set up listeners for ProfileBloc
  void _setupStreamListeners() {
    _profileBloc.stream.listen((state) {
      _handleStateChange(state);
    });
  }

  /// Handle state changes from BLoC
  void _handleStateChange(ProfileState state) {
    _isLoading = state is ProfileLoadingState;
    _error = state is ProfileErrorState ? state.error : null;

    if (state is ProfileLoadedState) {
      _error = null;
    }

    notifyListeners();
  }

  /// Load profile data
  void _loadProfileData() {
    _profileBloc.add(LoadProfileEvent());
  }

  /// Refresh profile data
  void refreshProfile() {
    _loadProfileData();
    notifyListeners();
  }

  /// Check if state represents loading
  bool isLoadingState(ProfileState state) =>
      state is ProfileLoadingState || _isLoading;

  /// Get error message from state
  String? getErrorMessage(ProfileState state) {
    if (state is ProfileErrorState) return state.error;
    return _error;
  }

  /// Extract profile information from state
  String getName(ProfileState state) {
    if (state is ProfileLoadedState) {
      return state.name ?? 'User Name';
    }
    return 'User Name';
  }

  String getEmail(ProfileState state) {
    if (state is ProfileLoadedState) {
      return state.email ?? 'user@example.com';
    }
    return 'user@example.com';
  }

  String? getPhotoUrl(ProfileState state) {
    if (state is ProfileLoadedState) {
      return state.photoUrl;
    }
    return null;
  }

  /// Confirm logout dialog
  Future<bool> confirmLogout(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Row(
              children: [
                Icon(Icons.logout, color: Colors.red),
                SizedBox(width: 12),
                Text('Confirm Logout'),
              ],
            ),
            content: const Text(
              'Are you sure you want to logout? You will need to sign in again.',
              style: TextStyle(fontSize: 16),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Logout'),
              ),
            ],
          ),
        ) ??
        false;
  }

  /// Logout action
  void logout() {
    _profileBloc.add(LogoutEvent());
  }

  /// Handle bottom navigation
  void handleNavigation(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, AppConstants.homeRoute);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, AppConstants.appointmentsRoute);
        break;
      case 2:
        Navigator.pushReplacementNamed(context, AppConstants.messagesRoute);
        break;
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
                        const SnackBar(
                            content: Text('Profile updated successfully!')),
                      );
                    } else if (newState is ProfileErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Failed to update profile: ${newState.error}')),
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

  /// Save profile updates
  void _saveProfile(BuildContext context, String name, String? imagePath) {
    _profileBloc.add(UpdateProfileEvent(
      name: name.isEmpty ? getName(_profileBloc.state) : name,
      imagePath: imagePath,
    ));

    Navigator.pop(context); // Close dialog

    // Show success/error feedback
    Future.delayed(const Duration(milliseconds: 500), () {
      final newState = _profileBloc.state;
      if (newState is ProfileLoadedState) {
        showSnackBar(context, 'Profile updated successfully!',
            icon: Icons.check_circle, color: Colors.green);
      } else if (newState is ProfileErrorState) {
        showSnackBar(context, 'Failed to update: ${newState.error}',
            icon: Icons.error, color: Colors.red);
      }
    });
  }

  /// Show snackbar helper
  void showSnackBar(BuildContext context, String message,
      {IconData icon = Icons.info, Color color = Colors.blue}) {
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

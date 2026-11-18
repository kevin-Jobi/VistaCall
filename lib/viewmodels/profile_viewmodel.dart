
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vistacall/bloc/profile/profile_bloc.dart';
import 'package:vistacall/bloc/profile/profile_event.dart';
import 'package:vistacall/bloc/profile/profile_state.dart';
import 'package:vistacall/utils/constants.dart';
import 'package:vistacall/utils/premium_theme.dart';

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


  // Future<void> editProfile(BuildContext context) async {
  //   final state = profileBloc.state;
  //   final currentName = getName(state);
  //   final nameController = TextEditingController(text: currentName);
  //   String? selectedImagePath;

  //   await showDialog<void>(
  //     context: context,
  //     builder: (context) {
  //       return StatefulBuilder(
  //         builder: (context, setState) {
  //           return AlertDialog(
  //             title: const Text('Edit Profile'),
  //             content: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 TextField(
  //                   controller: nameController,
  //                   decoration: const InputDecoration(labelText: 'Name'),
  //                 ),
  //                 const SizedBox(height: 12),
  //                 Row(
  //                   children: [
  //                     ElevatedButton.icon(
  //                       onPressed: () async {
  //                         final picker = ImagePicker();
  //                         final image = await picker.pickImage(
  //                           source: ImageSource.gallery,
  //                           maxWidth: 1024,
  //                           imageQuality: 85,
  //                         );
  //                         if (image != null) {
  //                           setState(() {
  //                             selectedImagePath = image.path;
  //                           });
  //                         }
  //                       },
  //                       icon: const Icon(Icons.photo_library),
  //                       label: const Text('Change photo'),
  //                     ),
  //                     const SizedBox(width: 8),
  //                     if (selectedImagePath != null)
  //                       const Icon(Icons.check_circle, color: Colors.green),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //             actions: [
  //               TextButton(
  //                 onPressed: () => Navigator.pop(context),
  //                 child: const Text('Cancel'),
  //               ),
  //               ElevatedButton(
  //                 onPressed: () async {
  //                   profileBloc.add(UpdateProfileEvent(
  //                     name: nameController.text.trim(),
  //                     imagePath: selectedImagePath,
  //                   ));
  //                   Navigator.pop(context);
  //                   final newState = profileBloc.state;
  //                   if (newState is ProfileLoadedState) {
  //                     ScaffoldMessenger.of(context).showSnackBar(
  //                       const SnackBar(
  //                           content: Text('Profile updated successfully!')),
  //                     );
  //                   } else if (newState is ProfileErrorState) {
  //                     ScaffoldMessenger.of(context).showSnackBar(
  //                       SnackBar(
  //                           content: Text(
  //                               'Failed to update profile: ${newState.error}')),
  //                     );
  //                   }
  //                 },
  //                 child: const Text('Save'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );
  // }




Future<void> editProfile(BuildContext context) async {
  final state = profileBloc.state;
  final currentName = getName(state);
  final nameController = TextEditingController(text: currentName);
  String? selectedImagePath;
 
  SnackBar premiumSnack(String text) => SnackBar(
        content: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14.5),
        ),
        backgroundColor: PremiumColors.navy800,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        margin: const EdgeInsets.all(16),
      );
 
  OutlineInputBorder fieldBorder(Color color, [double width = 1]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: color, width: width),
      );
 
  await showDialog<void>(
    context: context,
    barrierColor: PremiumColors.navy900.withValues(alpha: 0.55),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            insetPadding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: PremiumColors.navy900.withValues(alpha: 0.30),
                    blurRadius: 36,
                    offset: const Offset(0, 14),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ── Header ─────────────────────────────────────────────
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        gradient: PremiumColors.headerGradient,
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color:
                                  PremiumColors.accent.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(13),
                              border: Border.all(
                                color: PremiumColors.accent
                                    .withValues(alpha: 0.55),
                              ),
                            ),
                            child: const Icon(
                              Icons.edit_rounded,
                              color: PremiumColors.accent,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Update your name and photo',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white.withValues(alpha: 0.65),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
 
                    // ── Content ────────────────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 22, 20, 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: nameController,
                            cursorColor: PremiumColors.accent,
                            textCapitalization: TextCapitalization.words,
                            style: const TextStyle(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w500,
                              color: PremiumColors.ink,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Name',
                              labelStyle: const TextStyle(
                                color: PremiumColors.muted,
                                fontSize: 14.5,
                              ),
                              floatingLabelStyle: const TextStyle(
                                color: PremiumColors.navy700,
                                fontWeight: FontWeight.w600,
                              ),
                              prefixIcon: const Icon(
                                Icons.person_outline_rounded,
                                color: PremiumColors.navy600,
                                size: 20,
                              ),
                              filled: true,
                              fillColor: PremiumColors.surface,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              border: fieldBorder(PremiumColors.line),
                              enabledBorder: fieldBorder(PremiumColors.line),
                              focusedBorder: fieldBorder(
                                PremiumColors.accent.withValues(alpha: 0.9),
                                1.4,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
 
                          // Change photo (same picker logic as before)
                          Material(
                            color: PremiumColors.surface,
                            borderRadius: BorderRadius.circular(16),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () async {
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
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: selectedImagePath != null
                                        ? PremiumColors.accent
                                            .withValues(alpha: 0.7)
                                        : PremiumColors.line,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: PremiumColors.navy800
                                            .withValues(alpha: 0.07),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Icon(
                                        Icons.photo_library_outlined,
                                        color: PremiumColors.navy700,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Change photo',
                                            style: TextStyle(
                                              fontSize: 14.5,
                                              fontWeight: FontWeight.w700,
                                              color: PremiumColors.ink,
                                            ),
                                          ),
                                          if (selectedImagePath != null) ...[
                                            const SizedBox(height: 2),
                                            const Text(
                                              'Photo selected',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: PremiumColors.muted,
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                    if (selectedImagePath != null)
                                      const Icon(
                                        Icons.check_circle_rounded,
                                        color: PremiumColors.accent,
                                        size: 22,
                                      )
                                    else
                                      const Icon(
                                        Icons.arrow_outward_rounded,
                                        color: PremiumColors.muted,
                                        size: 18,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
 
                    // ── Actions ────────────────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Material(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border:
                                        Border.all(color: PremiumColors.line),
                                  ),
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: PremiumColors.muted,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: PremiumColors.navyGradient,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: PremiumColors.navy800
                                        .withValues(alpha: 0.28),
                                    blurRadius: 14,
                                    offset: const Offset(0, 6),
                                    spreadRadius: -2,
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: () async {
                                    profileBloc.add(UpdateProfileEvent(
                                      name: nameController.text.trim(),
                                      imagePath: selectedImagePath,
                                    ));
                                    Navigator.pop(context);
                                    final newState = profileBloc.state;
                                    if (newState is ProfileLoadedState) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        premiumSnack(
                                            'Profile updated successfully!'),
                                      );
                                    } else if (newState is ProfileErrorState) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        premiumSnack(
                                            'Failed to update profile: ${newState.error}'),
                                      );
                                    }
                                  },
                                  child: const SizedBox(
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.check_rounded,
                                            size: 18,
                                            color: PremiumColors.accent),
                                        SizedBox(width: 8),
                                        Text(
                                          'Save',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                            letterSpacing: 0.2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
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

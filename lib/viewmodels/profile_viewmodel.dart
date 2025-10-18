// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:vistacall/bloc/profile/profile_bloc.dart';
// import 'package:vistacall/bloc/profile/profile_event.dart';
// import 'package:vistacall/bloc/profile/profile_state.dart';
// import 'package:vistacall/utils/constants.dart';

// class ProfileViewModel {
//   final ProfileBloc profileBloc;

//   ProfileViewModel(this.profileBloc) {
//     loadProfile();
//   }

//   void loadProfile() {
//     profileBloc.add(LoadProfileEvent());
//   }

//   bool isLoading(ProfileState state) {
//     return state is ProfileLoadingState;
//   }

//   String? getErrorMessage(ProfileState state) {
//     if (state is ProfileErrorState) {
//       return state.error;
//     }
//     return null;
//   }

//   String getName(ProfileState state) {
//     if (state is ProfileLoadedState) {
//       return state.name;
//     }
//     return '';
//   }

//   String getEmail(ProfileState state) {
//     if (state is ProfileLoadedState) {
//       return state.email;
//     }
//     return '';
//   }

//   String? getPhotoUrl(ProfileState state) {
//     if (state is ProfileLoadedState) {
//       return state.photoUrl;
//     }
//     return null;
//   }

//   Future<bool> confirmLogout(BuildContext context) async {
//     final confirmLogout = await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Confirm Logout'),
//         content: const Text('Are you sure you want to logout?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, false),
//             child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(context, true),
//             child: const Text('Logout', style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       ),
//     );
//     return confirmLogout ?? false;
//   }

//   void logout() {
//     profileBloc.add(LogoutEvent());
//   }

//   void handleNavigation(int index, BuildContext context) {
//     if (index == 0) {
//       Navigator.pushReplacementNamed(context, AppConstants.homeRoute);
//     } else if (index == 1) {
//       Navigator.pushReplacementNamed(context, AppConstants.appointmentsRoute);
//     } else if (index == 2) {
//       Navigator.pushReplacementNamed(context, AppConstants.messagesRoute);
//     }
//   }

//   Future<void> editProfile(BuildContext context) async {
//     final state = profileBloc.state;
//     final currentName = getName(state);
//     final nameController = TextEditingController(text: currentName);
//     String? selectedImagePath;

//     await showDialog<void>(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return AlertDialog(
//               title: const Text('Edit Profile'),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TextField(
//                     controller: nameController,
//                     decoration: const InputDecoration(labelText: 'Name'),
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     children: [
//                       ElevatedButton.icon(
//                         onPressed: () async {
//                           final picker = ImagePicker();
//                           final image = await picker.pickImage(
//                             source: ImageSource.gallery,
//                             maxWidth: 1024,
//                             imageQuality: 85,
//                           );
//                           if (image != null) {
//                             setState(() {
//                               selectedImagePath = image.path;
//                             });
//                           }
//                         },
//                         icon: const Icon(Icons.photo_library),
//                         label: const Text('Change photo'),
//                       ),
//                       const SizedBox(width: 8),
//                       if (selectedImagePath != null)
//                         const Icon(Icons.check_circle, color: Colors.green),
//                     ],
//                   ),
//                 ],
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text('Cancel'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () async {
//                     profileBloc.add(UpdateProfileEvent(
//                       name: nameController.text.trim(),
//                       imagePath: selectedImagePath,
//                     ));
//                     Navigator.pop(context);
//                     final newState = profileBloc.state;
//                     if (newState is ProfileLoadedState) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                             content: Text('Profile updated successfully!')),
//                       );
//                     } else if (newState is ProfileErrorState) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                             content: Text(
//                                 'Failed to update profile: ${newState.error}')),
//                       );
//                     }
//                   },
//                   child: const Text('Save'),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
// }

// lib/viewmodels/profile_viewmodel.dart
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

  // /// Enhanced edit profile with image picker
  // Future<void> editProfile(BuildContext context) async {
  //   final currentState = _profileBloc.state;
  //   final currentName = getName(currentState);
  //   final nameController = TextEditingController(text: currentName);
  //   String? selectedImagePath;

  //   await showDialog<void>(
  //     context: context,
  //     builder: (context) {
  //       return StatefulBuilder(
  //         builder: (context, setDialogState) {
  //           return AlertDialog(
  //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //             title: const Row(
  //               children: [
  //                 Icon(Icons.edit, color: Colors.blue),
  //                 SizedBox(width: 12),
  //                 Text('Edit Profile'),
  //               ],
  //             ),
  //             content: SingleChildScrollView(
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   // Name field
  //                   TextField(
  //                     controller: nameController,
  //                     decoration: InputDecoration(
  //                       labelText: 'Full Name',
  //                       border: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(12),
  //                       ),
  //                       prefixIcon: const Icon(Icons.person),
  //                     ),
  //                   ),
  //                   const SizedBox(height: 16),

  //                   // Image picker section
  //                   Container(
  //                     padding: const EdgeInsets.all(16),
  //                     decoration: BoxDecoration(
  //                       color: Colors.grey.shade50,
  //                       borderRadius: BorderRadius.circular(12),
  //                       border: Border.all(color: Colors.grey.shade200!),
  //                     ),
  //                     child: Column(
  //                       children: [
  //                         CircleAvatar(
  //                           radius: 40,
  //                           backgroundImage: selectedImagePath != null
  //                               ? FileImage(File(selectedImagePath!))
  //                               : null,
  //                           child: selectedImagePath == null
  //                               ? const Icon(Icons.person, size: 40)
  //                               : null,
  //                         ),
  //                         const SizedBox(height: 12),
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                           children: [
  //                             ElevatedButton.icon(
  //                               onPressed: () async {
  //                                 try {
  //                                   final image = await _imagePicker.pickImage(
  //                                     source: ImageSource.gallery,
  //                                     maxWidth: 1024,
  //                                     imageQuality: 85,
  //                                   );
  //                                   if (image != null) {
  //                                     setDialogState(() {
  //                                       selectedImagePath = image.path;
  //                                     });
  //                                   }
  //                                 } catch (e) {
  //                                   showSnackBar(context, 'Failed to pick image: $e');
  //                                 }
  //                               },
  //                               icon: const Icon(Icons.photo_library),
  //                               label: const Text('Gallery'),
  //                               style: ElevatedButton.styleFrom(
  //                                 backgroundColor: AppConstants.primaryColor,
  //                               ),
  //                             ),
  //                             ElevatedButton.icon(
  //                               onPressed: () async {
  //                                 try {
  //                                   final image = await _imagePicker.pickImage(
  //                                     source: ImageSource.camera,
  //                                     maxWidth: 1024,
  //                                     imageQuality: 85,
  //                                   );
  //                                   if (image != null) {
  //                                     setDialogState(() {
  //                                       selectedImagePath = image.path;
  //                                     });
  //                                   }
  //                                 } catch (e) {
  //                                   showSnackBar(context, 'Failed to capture image: $e');
  //                                 }
  //                               },
  //                               icon: const Icon(Icons.camera_alt),
  //                               label: const Text('Camera'),
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             actions: [
  //               TextButton(
  //                 onPressed: () => Navigator.pop(context),
  //                 child: const Text('Cancel'),
  //               ),
  //               ElevatedButton.icon(
  //                 onPressed: () => _saveProfile(context, nameController.text.trim(), selectedImagePath),
  //                 icon: const Icon(Icons.save),
  //                 label: const Text('Save Changes'),
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: AppConstants.primaryColor,
  //                 ),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );
  //   nameController.dispose();
  // }
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

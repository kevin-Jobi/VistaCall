// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:vistacall/auth_viewmodel.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   Future<void> _logout(BuildContext context) async {
//     // Show confirmation dialog
//     bool? confirmLogout = await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Confirm Logout'),
//         content: const Text('Are you sure you want to logout?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, false), // Cancel
//             child: const Text(
//               'Cancel',
//               style: TextStyle(color: Colors.grey),
//             ),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(context, true), // Confirm logout
//             child: const Text(
//               'Logout',
//               style: TextStyle(color: Colors.red),
//             ),
//           ),
//         ],
//       ),
//     );

//     // Proceed with logout if confirmed
//     if (confirmLogout == true) {
//       final authViewModel = AuthViewmodel();
//       bool success = await authViewModel.logout();
//       if (success) {
//         Navigator.pushNamedAndRemoveUntil(context, '/auth', (route) => false);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(authViewModel.errorMessage ?? 'Logout failed')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;
//     final name = user?.displayName ?? 'Melbin'; // Fallback to UI name
//     final email = user?.email ?? 'melbin@gmail.com'; // Fallback to UI email

//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Profile Header
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 40,
//                     backgroundColor: Colors.grey.shade200,
//                     foregroundColor: Colors.transparent,
//                     child: ClipOval(
//                       child: user?.photoURL != null
//                           ? Image.network(
//                               user!.photoURL!,
//                               fit: BoxFit.cover,
//                               width: 80,
//                               height: 80,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return const Text(
//                                   'Profile Image\n(assets/images/profile_image.png)',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(color: Colors.grey),
//                                 );
//                               },
//                             )
//                           : Image.asset(
//                               'assets/images/profile_image.png',
//                               fit: BoxFit.cover,
//                               width: 80,
//                               height: 80,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return const Text(
//                                   'Profile Image\n(assets/images/profile_image.png)',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(color: Colors.grey),
//                                 );
//                               },
//                             ),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         name,
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF1A3C34), // Dark teal
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Row(
//                         children: [
//                           const Icon(Icons.email, color: Colors.grey, size: 16),
//                           const SizedBox(width: 4),
//                           Text(
//                             email,
//                             style: const TextStyle(color: Colors.black54),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const Divider(),
//             // Profile Options
//             Expanded(
//               child: ListView(
//                 children: [
//                   _buildProfileOption(
//                     context,
//                     icon: Icons.group,
//                     title: 'Invite Friends',
//                     onTap: () {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('Invite Friends feature coming soon!')),
//                       );
//                     },
//                   ),
//                   _buildProfileOption(
//                     context,
//                     icon: Icons.feedback,
//                     title: 'Feed Back',
//                     onTap: () {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('Feedback feature coming soon!')),
//                       );
//                     },
//                   ),
//                   _buildProfileOption(
//                     context,
//                     icon: Icons.lock,
//                     title: 'Privacy And Policy',
//                     onTap: () {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('Privacy And Policy page coming soon!')),
//                       );
//                     },
//                   ),
//                   _buildProfileOption(
//                     context,
//                     icon: Icons.description,
//                     title: 'Terms And Conditions',
//                     onTap: () {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('Terms And Conditions page coming soon!')),
//                       );
//                     },
//                   ),
//                   _buildProfileOption(
//                     context,
//                     icon: Icons.logout,
//                     title: 'LogOut',
//                     textColor: Colors.red,
//                     onTap: () => _logout(context),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: 3, // Profile tab selected
//         selectedItemColor: const Color(0xFF4A90E2), // Blue
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Appointment'),
//           BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//         ],
//         onTap: (index) {
//           if (index == 0) {
//             Navigator.pushReplacementNamed(context, '/home');
//           } else if (index == 1) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Appointment feature coming soon!')),
//             );
//           } else if (index == 2) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Messages feature coming soon!')),
//             );
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildProfileOption(
//     BuildContext context, {
//     required IconData icon,
//     required String title,
//     Color? textColor,
//     required VoidCallback onTap,
//   }) {
//     return ListTile(
//       leading: Icon(icon, color: textColor ?? Colors.grey),
//       title: Text(
//         title,
//         style: TextStyle(
//           color: textColor ?? Colors.black,
//           fontWeight: title == 'LogOut' ? FontWeight.bold : FontWeight.normal,
//         ),
//       ),
//       trailing: const Icon(Icons.chevron_right, color: Colors.grey),
//       onTap: onTap,
//     );
//   }
// }
//------------------------------------------------------------------

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:vistacall/utils/constants.dart';
// import 'package:vistacall/viewmodels/auth_event.dart' as auth;
// import 'package:vistacall/viewmodels/profile_bloc.dart';

// import '../../viewmodels/auth_bloc.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final profileBloc = BlocProvider.of<ProfileBloc>(context);
//     profileBloc.add(LoadProfileEvent());

//     return Scaffold(
//       body: SafeArea(
//         child: BlocConsumer<ProfileBloc, ProfileState>(
//           listener: (context, state) {
//             if (state is ProfileLoggedOutState) {
//               Navigator.pushNamedAndRemoveUntil(
//                 context,
//                 AppConstants.authRoute,
//                 (route) => false,
//               );
//             } else if (state is ProfileErrorState) {
//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(SnackBar(content: Text(state.error)));
//             }
//           },
//           builder: (context, state) {
//             if (state is ProfileLoadingState) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is ProfileErrorState) {
//               return Center(child: Text(state.error));
//             } else if (state is ProfileLoadedState) {
//               return Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Row(
//                       children: [
//                         CircleAvatar(
//                           radius: 40,
//                           backgroundColor: Colors.grey.shade200,
//                           foregroundColor: Colors.transparent,
//                           child: ClipOval(
//                             child:
//                                 state.photoUrl != null
//                                     ? Image.network(
//                                       state.photoUrl!,
//                                       fit: BoxFit.cover,
//                                       width: 80,
//                                       height: 80,
//                                       errorBuilder: (
//                                         context,
//                                         error,
//                                         stackTrace,
//                                       ) {
//                                         return const Text(
//                                           'Profile Image\n(assets/images/profile_image.png)',
//                                           textAlign: TextAlign.center,
//                                           style: TextStyle(color: Colors.grey),
//                                         );
//                                       },
//                                     )
//                                     : Image.asset(
//                                       'assets/images/profile_image.png',
//                                       fit: BoxFit.cover,
//                                       width: 80,
//                                       height: 80,
//                                       errorBuilder: (
//                                         context,
//                                         error,
//                                         stackTrace,
//                                       ) {
//                                         return const Text(
//                                           'Profile Image\n(assets/images/profile_image.png)',
//                                           textAlign: TextAlign.center,
//                                           style: TextStyle(color: Colors.grey),
//                                         );
//                                       },
//                                     ),
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               state.name,
//                               style: const TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xFF1A3C34),
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Row(
//                               children: [
//                                 const Icon(
//                                   Icons.email,
//                                   color: Colors.grey,
//                                   size: 16,
//                                 ),
//                                 const SizedBox(width: 4),
//                                 Text(
//                                   state.email,
//                                   style: const TextStyle(color: Colors.black54),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Divider(),
//                   Expanded(
//                     child: ListView(
//                       children: [
//                         _buildProfileOption(
//                           context,
//                           icon: Icons.group,
//                           title: 'Invite Friends',
//                           onTap: () {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text(
//                                   'Invite Friends feature coming soon!',
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                         _buildProfileOption(
//                           context,
//                           icon: Icons.feedback,
//                           title: 'Feed Back',
//                           onTap: () {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text('Feedback feature coming soon!'),
//                               ),
//                             );
//                           },
//                         ),
//                         _buildProfileOption(
//                           context,
//                           icon: Icons.lock,
//                           title: 'Privacy And Policy',
//                           onTap: () {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text(
//                                   'Privacy And Policy page coming soon!',
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                         _buildProfileOption(
//                           context,
//                           icon: Icons.description,
//                           title: 'Terms And Conditions',
//                           onTap: () {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text(
//                                   'Terms And Conditions page coming soon!',
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                         _buildProfileOption(
//                           context,
//                           icon: Icons.logout,
//                           title: 'LogOut',
//                           textColor: Colors.red,
//                           onTap: () async {
//                             print('logout');
//                             bool? confirmLogout = await showDialog<bool>(
//                               context: context,
//                               builder:
//                                   (context) => AlertDialog(
//                                     title: const Text('Confirm Logout'),
//                                     content: const Text(
//                                       'Are you sure you want to logout?',
//                                     ),
//                                     actions: [
//                                       TextButton(
//                                         onPressed:
//                                             () => Navigator.pop(context, false),
//                                         child: const Text(
//                                           'Cancel',
//                                           style: TextStyle(color: Colors.grey),
//                                         ),
//                                       ),
//                                       TextButton(
//                                         onPressed:
//                                             () => Navigator.pop(context, true),
//                                         child: const Text(
//                                           'Logout',
//                                           style: TextStyle(color: Colors.red),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                             );

//                             if (confirmLogout == true) {
//                               context.read<AuthBloc>().add(auth.LogoutEvent());

//                               // profileBloc.add(LogoutEvent());
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               );
//             }
//             return const SizedBox.shrink();
//           },
//         ),
//       ),
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: AppConstants.backgroundColor,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 10,
//               offset: const Offset(0, -2),
//             ),
//           ],
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: BottomNavigationBar(
//           currentIndex: 3,
//           selectedItemColor: AppConstants.primaryColor,
//           unselectedItemColor: Colors.grey.shade500,
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           type: BottomNavigationBarType.fixed,
//           selectedLabelStyle: const TextStyle(
//             fontWeight: FontWeight.w600,
//             fontSize: 12,
//           ),
//           unselectedLabelStyle: const TextStyle(
//             fontWeight: FontWeight.w400,
//             fontSize: 12,
//           ),
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               activeIcon: Icon(Icons.home, size: 28),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.calendar_today),
//               activeIcon: Icon(Icons.calendar_today, size: 28),
//               label: 'Appointment',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.chat),
//               activeIcon: Icon(Icons.chat, size: 28),
//               label: 'Messages',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person),
//               activeIcon: Icon(Icons.person, size: 28),
//               label: 'Profile',
//             ),
//           ],
//           onTap: (index) {
//             if (index == 0) {
//               Navigator.pushReplacementNamed(context, AppConstants.homeRoute);
//             } else if (index == 1) {
//               Navigator.pushReplacementNamed(
//                 context,
//                 AppConstants.appointmentsRoute,
//               );
//             } else if (index == 2) {
//               Navigator.pushReplacementNamed(
//                 context,
//                 AppConstants.messagesRoute,
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildProfileOption(
//     BuildContext context, {
//     required IconData icon,
//     required String title,
//     Color? textColor,
//     required VoidCallback onTap,
//   }) {
//     return ListTile(
//       leading: Icon(icon, color: textColor ?? Colors.grey),
//       title: Text(
//         title,
//         style: TextStyle(
//           color: textColor ?? Colors.black,
//           fontWeight: title == 'LogOut' ? FontWeight.bold : FontWeight.normal,
//         ),
//       ),
//       trailing: const Icon(Icons.chevron_right, color: Colors.grey),
//       onTap: onTap,
//     );
//   }
// }
//---------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vistacall/utils/constants.dart';
import 'package:vistacall/viewmodels/auth_event.dart' as auth;
import 'package:vistacall/viewmodels/auth_state.dart';
import 'package:vistacall/viewmodels/profile_bloc.dart';

import '../../viewmodels/auth_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.add(LoadProfileEvent());

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, authState) {
        if (authState is Unauthenticated) {
          // Handle auth state changes
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppConstants.authRoute,
            (route) => false,
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileLoggedOutState) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppConstants.authRoute,
                  (route) => false,
                );
              } else if (state is ProfileErrorState) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error)));
              }
            },
            builder: (context, state) {
              if (state is ProfileLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProfileErrorState) {
                return Center(child: Text(state.error));
              } else if (state is ProfileLoadedState) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.grey.shade200,
                            foregroundColor: Colors.transparent,
                            child: ClipOval(
                              child:
                                  state.photoUrl != null
                                      ? Image.network(
                                        state.photoUrl!,
                                        fit: BoxFit.cover,
                                        width: 80,
                                        height: 80,
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return const Text(
                                            'Profile Image\n(assets/images/profile_image.png)',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          );
                                        },
                                      )
                                      : Image.asset(
                                        'assets/images/profile_image.png',
                                        fit: BoxFit.cover,
                                        width: 80,
                                        height: 80,
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return const Text(
                                            'Profile Image\n(assets/images/profile_image.png)',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
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
                                state.name,
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
                                    state.email,
                                    style: const TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Expanded(
                      child: ListView(
                        children: [
                          _buildProfileOption(
                            context,
                            icon: Icons.group,
                            title: 'Invite Friends',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Invite Friends feature coming soon!',
                                  ),
                                ),
                              );
                            },
                          ),
                          _buildProfileOption(
                            context,
                            icon: Icons.feedback,
                            title: 'Feed Back',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Feedback feature coming soon!',
                                  ),
                                ),
                              );
                            },
                          ),
                          _buildProfileOption(
                            context,
                            icon: Icons.lock,
                            title: 'Privacy And Policy',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Privacy And Policy page coming soon!',
                                  ),
                                ),
                              );
                            },
                          ),
                          _buildProfileOption(
                            context,
                            icon: Icons.description,
                            title: 'Terms And Conditions',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Terms And Conditions page coming soon!',
                                  ),
                                ),
                              );
                            },
                          ),
                          _buildProfileOption(
                            context,
                            icon: Icons.logout,
                            title: 'LogOut',
                            textColor: Colors.red,
                            onTap: () async {
                              print('logout');
                              bool? confirmLogout = await showDialog<bool>(
                                context: context,
                                builder:
                                    (context) => AlertDialog(
                                      title: const Text('Confirm Logout'),
                                      content: const Text(
                                        'Are you sure you want to logout?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed:
                                              () =>
                                                  Navigator.pop(context, false),
                                          child: const Text(
                                            'Cancel',
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed:
                                              () =>
                                                  Navigator.pop(context, true),
                                          child: const Text(
                                            'Logout',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                              );

                              if (confirmLogout == true) {
                                await Future.delayed(
                                  const Duration(milliseconds: 100),
                                );
                                context.read<AuthBloc>().add(
                                  auth.LogoutEvent(),
                                );

                                // profileBloc.add(LogoutEvent());
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        bottomNavigationBar: Container(
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
            currentIndex: 3,
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
            onTap: (index) {
              if (index == 0) {
                Navigator.pushReplacementNamed(context, AppConstants.homeRoute);
              } else if (index == 1) {
                Navigator.pushReplacementNamed(
                  context,
                  AppConstants.appointmentsRoute,
                );
              } else if (index == 2) {
                Navigator.pushReplacementNamed(
                  context,
                  AppConstants.messagesRoute,
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    Color? textColor,
    required VoidCallback onTap,
  }) {
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

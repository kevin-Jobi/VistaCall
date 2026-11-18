
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:vistacall/presentation/views/favorite_doctors.dart';
// import 'package:vistacall/presentation/widgets/profile/privecy_and_policy.dart';
// import 'package:vistacall/viewmodels/profile_viewmodel.dart';
// import 'package:vistacall/utils/constants.dart';

// class ProfileOptionsList extends StatelessWidget {
//   const ProfileOptionsList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ProfileViewModel>(
//       builder: (context, viewModel, child) {
//         return SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//           child: Column(
//             children: [
//               // Main Options Group
//               _buildOptionsGroup(
//                 context, // Pass context
//                 title: "General",
//                 options: [
//                   _buildInviteFriendsOption(context), // Pass context
//                   _buildFavoriteOption(context), // Pass context
//                   _buildFeedbackOption(context), // Pass context
//                 ],
//               ),
//               const SizedBox(height: 24),
              
//               // Legal & Privacy Group
//               _buildOptionsGroup(
//                 context, // Pass context
//                 title: "Legal & Privacy",
//                 options: [
//                   _buildPrivacyPolicyOption(context), // Pass context
//                 ],
//               ),
//               const SizedBox(height: 24),
              
//               // Logout Section
//               _buildLogoutOption(context), // Pass context
//               const SizedBox(height: 32),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildOptionsGroup(
//     BuildContext context, // Accept context parameter
//     {
//     required String title,
//     required List<Widget> options,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 4, bottom: 12),
//           child: Text(
//             title,
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w600,
//               color: Colors.grey.shade700,
//               letterSpacing: 0.5,
//             ),
//           ),
//         ),
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.04),
//                 blurRadius: 10,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Column(
//             children: options,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildInviteFriendsOption(BuildContext context) {
//     return _buildOptionItem(
//       context: context, // Pass context explicitly
//       icon: Icons.group_outlined,
//       title: 'Invite Friends',
//       subtitle: 'Share with your network',
//       color: Colors.blue.shade600,
//       onTap: () async {
//         const String appLink = 'https://play.google.com/store/apps/details?id=com.yourcompany.vistacall';
//         const String message = 'Hey! 👋 Check out VistaCall — a smart way to connect with doctors online. Download it here:\n$appLink';
        
//         try {
//           await Share.share(message, subject: 'Try VistaCall App!');
//         } catch (e) {
//           if (context.mounted) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Failed to share app')),
//             );
//           }
//         }
//       },
//     );
//   }

//   Widget _buildFavoriteOption(BuildContext context) {
//     return _buildOptionItem(
//       context: context, // Pass context explicitly
//       icon: Icons.favorite_outline,
//       title: 'Favorite',
//       subtitle: 'Your saved doctors',
//       color: Colors.pink.shade500,
//       hasNavigation: true,
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const FavoriteDoctors()),
//         );
//       },
//     );
//   }

//   Widget _buildFeedbackOption(BuildContext context) {
//     return _buildOptionItem(
//       context: context, // Pass context explicitly
//       icon: Icons.feedback_outlined,
//       title: 'Feedback',
//       subtitle: 'Help us improve',
//       color: Colors.orange.shade600,
//       onTap: () async {
//         final Uri emailUri = Uri(
//           scheme: 'mailto',
//           path: 'kevinemmanu@gmail.com',
//           queryParameters: {'subject': 'Feedback for VistaCall App'},
//         );
        
//         try {
//           if (await canLaunchUrl(emailUri)) {
//             await launchUrl(emailUri);
//           } else {
//             _showComingSoon(context, 'Feedback feature');
//           }
//         } catch (e) {
//           _showComingSoon(context, 'Feedback feature');
//         }
//       },
//     );
//   }

//   Widget _buildPrivacyPolicyOption(BuildContext context) {
//     return _buildOptionItem(
//       context: context, // Pass context explicitly
//       icon: Icons.lock_outline,
//       title: 'Privacy Policy',
//       subtitle: 'How we protect your data',
//       color: Colors.green.shade600,
//       hasNavigation: true,
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const PrivacyPolicyPage()),
//         );
//       },
//     );
//   }

//   Widget _buildOptionItem({
//     required BuildContext context, // Keep this required
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required Color color,
//     required VoidCallback onTap,
//     bool hasNavigation = false,
//   }) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         borderRadius: BorderRadius.circular(16),
//         onTap: onTap,
//         child: Container(
//           padding: const EdgeInsets.all(20),
//           margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
//           decoration: BoxDecoration(
//             border: Border(
//               bottom: BorderSide(color: Colors.grey.shade100, width: 1),
//             ),
//           ),
//           child: Row(
//             children: [
//               Container(
//                 width: 48,
//                 height: 48,
//                 decoration: BoxDecoration(
//                   color: color.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: color.withOpacity(0.2), width: 1),
//                 ),
//                 child: Icon(icon, color: color, size: 24),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     const SizedBox(height: 2),
//                     Text(
//                       subtitle,
//                       style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
//                     ),
//                   ],
//                 ),
//               ),
//               if (hasNavigation)
//                 Container(
//                   padding: const EdgeInsets.all(4),
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade100,
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                   child: const Icon(
//                     Icons.arrow_forward_ios,
//                     color: Colors.grey,
//                     size: 12,
//                   ),
//                 )
//               else
//                 const Icon(Icons.chevron_right, color: Colors.grey),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLogoutOption(BuildContext context) {
//     return Consumer<ProfileViewModel>(
//       builder: (context, viewModel, child) {
//         return Material(
//           color: Colors.transparent,
//           child: InkWell(
//             borderRadius: BorderRadius.circular(16),
//             onTap: () async {
//               final confirm = await viewModel.confirmLogout(context);
//               if (confirm) {
//                 viewModel.logout();
//               }
//             },
//             child: Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [
//                     Colors.red.shade50,
//                     Colors.red.shade100.withOpacity(0.3),
//                   ],
//                 ),
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(color: Colors.red.shade200),
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 48,
//                     height: 48,
//                     decoration: BoxDecoration(
//                       color: Colors.red.shade100,
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: Colors.red.shade200, width: 1),
//                     ),
//                     child: Icon(Icons.logout, color: Colors.red.shade600, size: 24),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Log Out',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.red.shade700,
//                           ),
//                         ),
//                         const SizedBox(height: 2),
//                         Text(
//                           'Sign out of your account',
//                           style: TextStyle(fontSize: 13, color: Colors.red.shade600),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Icon(Icons.power_settings_new, color: Colors.red.shade500, size: 20),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _showComingSoon(BuildContext context, String feature) {
//     if (!context.mounted) return;
    
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(4),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(6),
//               ),
//               child: const Icon(Icons.info_outline, color: Colors.white, size: 16),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Text(
//                 '$feature coming soon!',
//                 style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
//               ),
//             ),
//           ],
//         ),
//         backgroundColor: Colors.blue.shade600,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         margin: const EdgeInsets.all(16),
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vistacall/presentation/views/favorite_doctors.dart';
import 'package:vistacall/presentation/widgets/profile/privecy_and_policy.dart';
import 'package:vistacall/utils/premium_theme.dart';
import 'package:vistacall/viewmodels/profile_viewmodel.dart';

class ProfileOptionsList extends StatelessWidget {
  const ProfileOptionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, viewModel, child) {
        return SingleChildScrollView(
          // Extra bottom space so the last item clears the floating nav bar.
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 130),
          child: Column(
            children: [
              // Main Options Group
              _buildOptionsGroup(
                context, // Pass context
                title: "General",
                options: [
                  _buildInviteFriendsOption(context), // Pass context
                  _buildFavoriteOption(context), // Pass context
                  _buildFeedbackOption(context), // Pass context
                ],
              ),
              const SizedBox(height: 24),

              // Legal & Privacy Group
              _buildOptionsGroup(
                context, // Pass context
                title: "Legal & Privacy",
                options: [
                  _buildPrivacyPolicyOption(context), // Pass context
                ],
              ),
              const SizedBox(height: 24),

              // Logout Section
              _buildLogoutOption(context), // Pass context
            ],
          ),
        );
      },
    );
  }

  Widget _buildOptionsGroup(
    BuildContext context, // Accept context parameter
    {
    required String title,
    required List<Widget> options,
  }) {
    final children = <Widget>[];
    for (int i = 0; i < options.length; i++) {
      children.add(options[i]);
      if (i < options.length - 1) {
        children.add(Container(
          height: 1,
          margin: const EdgeInsets.only(left: 76, right: 18),
          color: PremiumColors.line,
        ));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: PremiumColors.muted,
              letterSpacing: 1.4,
            ),
          ),
        ),
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: PremiumColors.line),
            boxShadow: PremiumColors.softShadow(0.06),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildInviteFriendsOption(BuildContext context) {
    return _buildOptionItem(
      context: context, // Pass context explicitly
      icon: Icons.group_outlined,
      title: 'Invite Friends',
      subtitle: 'Share with your network',
      onTap: () async {
        const String appLink =
            'https://play.google.com/store/apps/details?id=com.yourcompany.vistacall';
        const String message =
            'Hey! 👋 Check out VistaCall — a smart way to connect with doctors online. Download it here:\n$appLink';

        try {
          await Share.share(message, subject: 'Try VistaCall App!');
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to share app')),
            );
          }
        }
      },
    );
  }

  Widget _buildFavoriteOption(BuildContext context) {
    return _buildOptionItem(
      context: context, // Pass context explicitly
      icon: Icons.favorite_outline,
      title: 'Favorite',
      subtitle: 'Your saved doctors',
      hasNavigation: true,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FavoriteDoctors()),
        );
      },
    );
  }

  Widget _buildFeedbackOption(BuildContext context) {
    return _buildOptionItem(
      context: context, // Pass context explicitly
      icon: Icons.feedback_outlined,
      title: 'Feedback',
      subtitle: 'Help us improve',
      onTap: () async {
        final Uri emailUri = Uri(
          scheme: 'mailto',
          path: 'kevinemmanu@gmail.com',
          queryParameters: {'subject': 'Feedback for VistaCall App'},
        );

        try {
          if (await canLaunchUrl(emailUri)) {
            await launchUrl(emailUri);
          } else {
            _showComingSoon(context, 'Feedback feature');
          }
        } catch (e) {
          _showComingSoon(context, 'Feedback feature');
        }
      },
    );
  }

  Widget _buildPrivacyPolicyOption(BuildContext context) {
    return _buildOptionItem(
      context: context, // Pass context explicitly
      icon: Icons.lock_outline,
      title: 'Privacy Policy',
      subtitle: 'How we protect your data',
      hasNavigation: true,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PrivacyPolicyPage()),
        );
      },
    );
  }

  Widget _buildOptionItem({
    required BuildContext context, // Keep this required
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool hasNavigation = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Row(
            children: [
              // One consistent navy icon tile for every option.
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: PremiumColors.navy800.withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(icon, color: PremiumColors.navy700, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                        color: PremiumColors.ink,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: PremiumColors.muted,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Arrow = opens a screen in the app; outward arrow = leaves the app.
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: PremiumColors.navy800.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  hasNavigation
                      ? Icons.arrow_forward_ios_rounded
                      : Icons.arrow_outward_rounded,
                  color: PremiumColors.navy700,
                  size: hasNavigation ? 13 : 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutOption(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, viewModel, child) {
        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border:
                Border.all(color: PremiumColors.danger.withValues(alpha: 0.28)),
            boxShadow: PremiumColors.softShadow(0.05),
          ),
          child: Material(
            color: PremiumColors.danger.withValues(alpha: 0.04),
            child: InkWell(
              onTap: () async {
                final confirm = await viewModel.confirmLogout(context);
                if (confirm) {
                  viewModel.logout();
                }
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                child: Row(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: PremiumColors.danger.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(Icons.logout_rounded,
                          color: PremiumColors.danger, size: 22),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Log Out',
                            style: TextStyle(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w700,
                              color: PremiumColors.danger,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Sign out of your account',
                            style: TextStyle(
                              fontSize: 12.5,
                              color: PremiumColors.muted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.power_settings_new_rounded,
                        color: PremiumColors.danger, size: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.info_outline,
                  color: PremiumColors.accent, size: 16),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '$feature coming soon!',
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
            ),
          ],
        ),
        backgroundColor: PremiumColors.navy800,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
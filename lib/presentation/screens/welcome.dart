// import 'package:flutter/material.dart';

// class WelcomeScreen extends StatefulWidget {
//   const WelcomeScreen({super.key});

//   @override
//   State<WelcomeScreen> createState() => _WelcomeScreenState();
// }

// class _WelcomeScreenState extends State<WelcomeScreen> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   void _onPageChanged(int page) {
//     setState(() {
//       _currentPage = page;
//     });
//   }

//   void _skipOrGetStarted() {
//     // Navigate to home screen
//     Navigator.pushReplacementNamed(context, '/auth');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           PageView(
//             controller: _pageController,
//             onPageChanged: _onPageChanged,
//             children: [
//               // Screen 1
//               _buildWelcomePage(
//                 imagePath: 'assets/images/ws1.png',
//                 title: 'Welcome to Your\nHealth Companion',
//                 description:
//                     'Easily track symptoms, medications, and book appointments to guide expert doctors to your wellness journey.\nYour well-being, now just a few taps away!',
//                 showSkip: true,
//               ),
//               // Screen 2
//               _buildWelcomePage(
//                 imagePath: 'assets/images/ws2.png',
//                 title: 'Expert Care, Anytime,\nAnywhere',
//                 description:
//                     'Access a network of trusted doctors and health tools to manage your symptoms, medications, and appointments, ready to support your wellness journey when you need it.',
//                 showSkip: true,
//               ),
//               // Screen 3
//               _buildWelcomePage(
//                 imagePath: 'assets/images/ws3.png',
//                 title: 'Care with Confidence',
//                 description:
//                     'Seamlessly track symptoms and medications on your health journey—from booking doctors to reliable, secure, and easy.',
//                 showSkip: false,
//               ),
//             ],
//           ),
//           // Page Indicator Dots
//           Positioned(
//             bottom: 30,
//             left: 0,
//             right: 0,

//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(3, (index) {
//                 return AnimatedContainer(
//                   duration: const Duration(milliseconds: 300),
//                   margin: const EdgeInsets.symmetric(horizontal: 4),
//                   width: _currentPage == index ? 12 : 8,
//                   height: 8,
//                   decoration: BoxDecoration(
//                     color:
//                         _currentPage == index
//                             ? const Color(0xFF4A90E2) // Blue for active dot
//                             : Colors.grey.shade400,
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                 );
//               }),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildWelcomePage({
//     required String imagePath,
//     required String title,
//     required String description,
//     required bool showSkip,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // Image
//           Image.asset(
//             imagePath,
//             height: 200,
//             width: double.infinity,
//             fit: BoxFit.contain,
//             errorBuilder: (context, error, stackTrace) {
//               return Container(
//                 height: 200,
//                 width: double.infinity,
//                 color: Colors.grey.shade200,
//                 child: Center(
//                   child: Text(
//                     'Image Not Found\n($imagePath)',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.grey.shade600),
//                   ),
//                 ),
//               );
//             },
//           ),
//           const SizedBox(height: 40),
//           // Title
//           Text(
//             title,
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               fontSize: 26,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF4A90E2), // Dark teal for title
//             ),
//           ),
//           const SizedBox(height: 20),
//           // Description
//           Text(
//             description,
//             textAlign: TextAlign.center,
//             style: const TextStyle(fontSize: 20, color: Colors.blue),
//           ),
//           const Spacer(),

//           // Skip or Get Started Button
//           if (showSkip)
//             TextButton(
//               onPressed: _skipOrGetStarted,
//               child: const Text(
//                 'Skip',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Color.fromARGB(
//                     255,
//                     104,
//                     160,
//                     225,
//                   ), // Blue for Skip button
//                 ),
//               ),
//             )
//           else
//             ElevatedButton(
//               onPressed: _skipOrGetStarted,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF4A90E2), // Blue button
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 40,
//                   vertical: 16,
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//               ),
//               child: const Text('Get Started', style: TextStyle(fontSize: 16)),
//             ),
//           SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/presentation/widgets/custom_elevated_button.dart.dart';
import 'package:vistacall/viewmodels/welcome_bloc.dart';
import 'package:vistacall/utils/constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final welcomeBloc = BlocProvider.of<WelcomeBloc>(context);

    return Scaffold(
      body: BlocListener<WelcomeBloc, WelcomeState>(
        listener: (context, state) {
          if (state is WelcomeNavigateState) {
            Navigator.pushReplacementNamed(context, AppConstants.authRoute);
          }
        },
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 97, 163, 239),
                Color.fromARGB(255, 152, 208, 231),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome to Vistacall',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Your trusted healthcare companion. Book appointments, chat with doctors, and manage your health—all in one place.',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  CustomElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppConstants.authRoute);
                    },
                    text: 'Get Started',
                    backgroundColor: Colors.white,
                    foregroundColor: AppConstants.primaryColor,
                    borderRadius: 30,
                    fontSize: 18,
                    height: 56,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

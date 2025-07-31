// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vistacall/presentation/widgets/custom_textfield.dart';
// import 'package:vistacall/utils/constants.dart';
// import 'package:vistacall/bloc/auth/auth_bloc.dart';
// import 'package:vistacall/bloc/auth/auth_event.dart';
// import 'package:vistacall/bloc/auth/auth_state.dart';
// import 'package:vistacall/viewmodels/auth_viewmodel.dart';

// class AuthScreen extends StatelessWidget {
//   const AuthScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final _formKey = GlobalKey<FormState>();
//     final emailController = TextEditingController();
//     final passwordController = TextEditingController();

//     return BlocProvider(
//       create: (context) => AuthBloc(AuthViewmodel()),
//       child: Scaffold(
//         body: BlocListener<AuthBloc, AuthState>(
//           listener: (context, state) {
//             // Handle success navigation
//             if (state is Authenticated) {
//               Navigator.pushReplacementNamed(context, AppConstants.homeRoute);
//             }

//             // Handle error messages
//             if (state is AuthError) {
//               print('pooi');
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(
//                     '${state.errorMessage}' ?? 'An unknown error occurred',
//                   ),
//                 ),
//               );
//             }

//             // Handle password reset success
//             if (state.resetPasswordSuccess) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Password reset email sent')),
//               );
//             }
//           },
//           child: BlocBuilder<AuthBloc, AuthState>(
//             builder: (context, state) {
//               return Form(
//                 key: _formKey,
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 24,
//                       vertical: 60,
//                     ),
//                     child: Column(
//                       children: [
//                         // Image Placeholder
//                         Image.asset(
//                           state.isSignUpMode
//                               ? 'assets/images/signup_image.png'
//                               : 'assets/images/signin_image.png',
//                           height: 200,
//                           width: double.infinity,
//                           fit: BoxFit.contain,
//                           errorBuilder: (context, error, stackTrace) {
//                             return Container(
//                               height: 200,
//                               width: double.infinity,
//                               color: Colors.grey.shade200,
//                               child: Center(
//                                 child: Text(
//                                   'Image Not Found\n(${state.isSignUpMode ? 'signup_image.png' : 'signin_image.png'})',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(color: Colors.grey.shade600),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                         const SizedBox(height: 40),
//                         // Title
//                         Text(
//                           state.isSignUpMode
//                               ? 'Create New Account'
//                               : 'Welcome Back!',
//                           style: const TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF1A3C34),
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         // Email Field
//                         CustomTextField(
//                           controller: emailController,
//                           labelText: 'Enter Username',
//                           hintText: 'example@email.com',
//                           prefixIcon: Icons.email,
//                           keyboardType: TextInputType.emailAddress,
//                           isRequired: true,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Email is required';
//                             }
//                             if (!RegExp(
//                               r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
//                             ).hasMatch(value)) {
//                               return 'Enter a valid email address';
//                             }
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: 16),
//                         // Password Field
//                         CustomTextField(
//                           controller: passwordController,
//                           labelText: 'Enter Password',
//                           hintText: 'At least 6 characters',
//                           prefixIcon: Icons.lock,
//                           obscureText: !state.isPasswordVisible,
//                           showVisibilityToggle: true,
//                           isPasswordVisible: state.isPasswordVisible,
//                           isRequired: true,
//                           onVisibilityToggle: () {
//                             context.read<AuthBloc>().add(
//                               TogglePasswordVisibilityEvent(),
//                             );
//                           },
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Password is required';
//                             }
//                             if (value.length < 6) {
//                               return 'Password must be at least 6 characters';
//                             }
//                             if (state.isSignUpMode &&
//                                 !RegExp(
//                                   r'^(?=.*[A-Za-z])(?=.*\d)',
//                                 ).hasMatch(value)) {
//                               return 'Password should contain letters and numbers';
//                             }
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: 16),
//                         // Forgot Password (Sign-In only)
//                         if (!state.isSignUpMode)
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: TextButton(
//                               onPressed:
//                                   state.isLoading
//                                       ? null
//                                       : () {
//                                         context.read<AuthBloc>().add(
//                                           ResetPasswordEvent(
//                                             emailController.text.trim(),
//                                           ),
//                                         );
//                                       },
//                               child: const Text(
//                                 'Forgot Password?',
//                                 style: TextStyle(color: Color(0xFF4A90E2)),
//                               ),
//                             ),
//                           ),
//                         const SizedBox(height: 16),
//                         // Sign In/Sign Up Button
//                         SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButton(
//                             onPressed:
//                                 state.isLoading
//                                     ? null
//                                     : () {
//                                       if (_formKey.currentState!.validate()) {
//                                         final email =
//                                             emailController.text.trim();
//                                         final password =
//                                             passwordController.text.trim();
//                                         if (state.isSignUpMode) {
//                                           context.read<AuthBloc>().add(
//                                             SignUpEvent(email, password),
//                                           );
//                                         } else {
//                                           context.read<AuthBloc>().add(
//                                             SignInEvent(email, password),
//                                           );
//                                         }
//                                       }
//                                     },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: AppConstants.primaryColor,
//                               padding: const EdgeInsets.symmetric(vertical: 12),
//                             ),
//                             child:
//                                 state.isLoading
//                                     ? const CircularProgressIndicator(
//                                       color: Colors.white,
//                                     )
//                                     : Text(
//                                       state.isSignUpMode
//                                           ? 'Sign Up'
//                                           : 'Sign In',
//                                     ),
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         // Google Sign-In Button
//                         SizedBox(
//                           width: double.infinity,
//                           child: OutlinedButton.icon(
//                             onPressed:
//                                 state.isLoading
//                                     ? null
//                                     : () {
//                                       context.read<AuthBloc>().add(
//                                         SignInWithGoogleEvent(),
//                                       );
//                                       // Navigation handled by BlocListener
//                                     },
//                             icon: Image.asset(
//                               'assets/images/google_logo.png',
//                               height: 24,
//                               width: 24,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return const Icon(Icons.error);
//                               },
//                             ),
//                             label: Text(
//                               'Sign ${state.isSignUpMode ? 'Up' : 'In'} with Google',
//                               style: const TextStyle(color: Colors.black),
//                             ),
//                             style: OutlinedButton.styleFrom(
//                               padding: const EdgeInsets.symmetric(vertical: 12),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         // Toggle between Sign Up and Sign In
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               state.isSignUpMode
//                                   ? 'Already have an account?'
//                                   : 'Don\'t have an account?',
//                               style: const TextStyle(color: Colors.black54),
//                             ),
//                             TextButton(
//                               onPressed:
//                                   state.isLoading
//                                       ? null
//                                       : () {
//                                         _formKey.currentState?.reset();
//                                         emailController.clear();
//                                         passwordController.clear();
//                                         context.read<AuthBloc>().add(
//                                           ToggleAuthModeEvent(),
//                                         );
//                                       },
//                               child: Text(
//                                 state.isSignUpMode ? 'Sign In' : 'Sign Up',
//                                 style: const TextStyle(
//                                   color: Color(0xFF4A90E2),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/auth/auth_bloc.dart';
import 'package:vistacall/bloc/auth/auth_state.dart';
import 'package:vistacall/presentation/widgets/auth/auth_form.dart';
import 'package:vistacall/viewmodels/auth_viewmodel.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(authViewModel: AuthViewModel()),
      child: Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              // Handle successful authentication
              Navigator.of(context).pushReplacementNamed('/home');
            }
            
            if (state is AuthError) {
              // Show error message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
            
            if (state is ResetPasswordSent) {
              // Show password reset success message
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Password reset email sent')),
              );
            }
          },
          child: const AuthForm(),
        ),
      ),
    );
  }
}
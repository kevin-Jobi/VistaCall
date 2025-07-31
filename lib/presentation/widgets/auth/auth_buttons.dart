// // lib/presentation/widgets/auth/auth_buttons.dart

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vistacall/utils/constants.dart';
// import 'package:vistacall/viewmodels/auth_viewmodel.dart';

// class AuthButtons extends StatelessWidget {
//   final GlobalKey<FormState> formKey;
//   final TextEditingController emailController;
//   final TextEditingController passwordController;
//   final bool isLoading;
//   final bool isSignUpMode;

//   const AuthButtons({
//     super.key,
//     required this.formKey,
//     required this.emailController,
//     required this.passwordController,
//     required this.isLoading,
//     required this.isSignUpMode,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final viewModel = AuthViewModel(context.read());

//     return Column(
//       children: [
//         // Email/Password Auth Button
//         SizedBox(
//           width: double.infinity,
//           child: ElevatedButton(
//             onPressed: isLoading
//                 ? null
//                 : () {
//                     if (formKey.currentState!.validate()) {
//                       viewModel.submitForm(
//                         isSignUpMode: isSignUpMode,
//                         email: emailController.text.trim(),
//                         password: passwordController.text.trim(),
//                       );
//                     }
//                   },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppConstants.primaryColor,
//               padding: const EdgeInsets.symmetric(vertical: 12),
//             ),
//             child: isLoading
//                 ? const CircularProgressIndicator(color: Colors.white)
//                 : Text(isSignUpMode ? 'Sign Up' : 'Sign In'),
//           ),
//         ),
//         const SizedBox(height: 16),
//         // Google Auth Button
//         SizedBox(
//           width: double.infinity,
//           child: OutlinedButton.icon(
//             onPressed: isLoading
//                 ? null
//                 : () => viewModel.signInWithGoogle(),
//             icon: Image.asset(
//               'assets/images/google_logo.png',
//               height: 24,
//               width: 24,
//               errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
//             ),
//             label: Text(
//               'Sign ${isSignUpMode ? 'Up' : 'In'} with Google',
//               style: const TextStyle(color: Colors.black),
//             ),
//             style: OutlinedButton.styleFrom(
//               padding: const EdgeInsets.symmetric(vertical: 12),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }


// lib/presentation/widgets/auth/auth_buttons.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/auth/auth_bloc.dart';
import 'package:vistacall/bloc/auth/auth_event.dart';
import 'package:vistacall/utils/constants.dart';

class AuthButtons extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLoading;
  final bool isSignUpMode;

  const AuthButtons({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.isLoading,
    required this.isSignUpMode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Email/Password Auth Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isLoading
                ? null
                : () {
                    if (formKey.currentState!.validate()) {
                      _handleEmailPasswordAuth(context);
                    }
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(isSignUpMode ? 'Sign Up' : 'Sign In'),
          ),
        ),
        const SizedBox(height: 16),
        // Google Auth Button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: isLoading ? null : () => _handleGoogleAuth(context),
            icon: _buildGoogleIcon(),
            label: Text(
              'Sign ${isSignUpMode ? 'Up' : 'In'} with Google',
              style: const TextStyle(color: Colors.black),
            ),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGoogleIcon() {
    return Image.asset(
      'assets/images/google_logo.png',
      height: 24,
      width: 24,
      errorBuilder: (context, error, stackTrace) => const Icon(
        Icons.error,
        size: 24,
        color: Colors.red,
      ),
    );
  }

  void _handleEmailPasswordAuth(BuildContext context) {
    final bloc = context.read<AuthBloc>();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (isSignUpMode) {
      bloc.add(AuthSignUp(email, password));
    } else {
      bloc.add(AuthSignIn(email, password));
    }
  }

  void _handleGoogleAuth(BuildContext context) {
    context.read<AuthBloc>().add(const AuthSignInWithGoogle());
  }
}
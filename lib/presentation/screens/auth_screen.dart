import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/presentation/widgets/custom_textfield.dart';
import 'package:vistacall/utils/constants.dart';
import 'package:vistacall/bloc/auth/auth_bloc.dart';
import 'package:vistacall/bloc/auth/auth_event.dart';
import 'package:vistacall/bloc/auth/auth_state.dart';
import 'package:vistacall/viewmodels/auth_viewmodel.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocProvider(
      create: (context) => AuthBloc(AuthViewmodel()),
      child: Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            // Handle success navigation
            if (state is Authenticated) {
              Navigator.pushReplacementNamed(context, AppConstants.homeRoute);
            }

            // Handle error messages
            if (state is AuthError) {
              print('pooi');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${state.errorMessage}' ?? 'An unknown error occurred',
                  ),
                ),
              );
            }

            // Handle password reset success
            if (state.resetPasswordSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Password reset email sent')),
              );
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 60,
                  ),
                  child: Column(
                    children: [
                      // Image Placeholder
                      Image.asset(
                        state.isSignUpMode
                            ? 'assets/images/signup_image.png'
                            : 'assets/images/signin_image.png',
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 200,
                            width: double.infinity,
                            color: Colors.grey.shade200,
                            child: Center(
                              child: Text(
                                'Image Not Found\n(${state.isSignUpMode ? 'signup_image.png' : 'signin_image.png'})',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 40),
                      // Title
                      Text(
                        state.isSignUpMode
                            ? 'Create New Account'
                            : 'Welcome Back!',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A3C34),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Email Field
                      CustomTextField(
                        controller: emailController,
                        labelText: 'Enter Username',
                        prefixIcon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),
                      // Password Field
                      CustomTextField(
                        controller: passwordController,
                        labelText: 'Enter Password',
                        prefixIcon: Icons.lock,
                        obscureText: !state.isPasswordVisible,
                        showVisibilityToggle: true,
                        isPasswordVisible: state.isPasswordVisible,
                        onVisibilityToggle: () {
                          context.read<AuthBloc>().add(
                            TogglePasswordVisibilityEvent(),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      // Forgot Password (Sign-In only)
                      if (!state.isSignUpMode)
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed:
                                state.isLoading
                                    ? null
                                    : () {
                                      context.read<AuthBloc>().add(
                                        ResetPasswordEvent(
                                          emailController.text.trim(),
                                        ),
                                      );
                                    },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(color: Color(0xFF4A90E2)),
                            ),
                          ),
                        ),
                      const SizedBox(height: 16),
                      // Sign In/Sign Up Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed:
                              state.isLoading
                                  ? null
                                  : () {
                                    final email = emailController.text.trim();
                                    final password =
                                        passwordController.text.trim();

                                    if (email.isEmpty || password.isEmpty) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Please fill in both email and password fields',
                                          ),
                                        ),
                                      );
                                      return;
                                    }
                                    if (state.isSignUpMode) {
                                      context.read<AuthBloc>().add(
                                        SignUpEvent(email, password),
                                      );
                                    } else {
                                      context.read<AuthBloc>().add(
                                        SignInEvent(email, password),
                                      );
                                    }
                                    // Navigation handled by BlocListener
                                  },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppConstants.primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child:
                              state.isLoading
                                  ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : Text(
                                    state.isSignUpMode ? 'Sign Up' : 'Sign In',
                                  ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Google Sign-In Button
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed:
                              state.isLoading
                                  ? null
                                  : () {
                                    context.read<AuthBloc>().add(
                                      SignInWithGoogleEvent(),
                                    );
                                    // Navigation handled by BlocListener
                                  },
                          icon: Image.asset(
                            'assets/images/google_logo.png',
                            height: 24,
                            width: 24,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error);
                            },
                          ),
                          label: Text(
                            'Sign ${state.isSignUpMode ? 'Up' : 'In'} with Google',
                            style: const TextStyle(color: Colors.black),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Toggle between Sign Up and Sign In
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.isSignUpMode
                                ? 'Already have an account?'
                                : 'Don\'t have an account?',
                            style: const TextStyle(color: Colors.black54),
                          ),
                          TextButton(
                            onPressed: () {
                              context.read<AuthBloc>().add(
                                ToggleAuthModeEvent(),
                              );
                            },
                            child: Text(
                              state.isSignUpMode ? 'Sign In' : 'Sign Up',
                              style: const TextStyle(color: Color(0xFF4A90E2)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

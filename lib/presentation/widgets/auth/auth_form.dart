// // lib/presentation/widgets/auth/auth_form.dart

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vistacall/bloc/auth/auth_bloc.dart';
// import 'package:vistacall/bloc/auth/auth_state.dart';
// import 'package:vistacall/presentation/widgets/auth/auth_image_header.dart';
// import 'package:vistacall/presentation/widgets/auth/auth_buttons.dart';
// import 'package:vistacall/presentation/widgets/auth/auth_toggle_mode.dart';
// import 'package:vistacall/presentation/widgets/custom_textfield.dart';
// import 'package:vistacall/viewmodels/auth_viewmodel.dart';

// class AuthForm extends StatefulWidget {
//   const AuthForm({super.key});

//   @override
//   State<AuthForm> createState() => _AuthFormState();
// }

// class _AuthFormState extends State<AuthForm> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final viewModel = AuthViewModel(context.read<AuthBloc>());

//     return BlocBuilder<AuthBloc, AuthState>(
//       builder: (context, state) {
//         return SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   AuthImageHeader(isSignUpMode: state.isSignUpMode),
//                   const SizedBox(height: 40),
//                   _buildTitle(state.isSignUpMode),
//                   const SizedBox(height: 20),
//                   _buildEmailField(viewModel, state),
//                   const SizedBox(height: 16),
//                   _buildPasswordField(viewModel, state),
//                   const SizedBox(height: 16),
//                   if (!state.isSignUpMode) _buildForgotPassword(viewModel, state),
//                   const SizedBox(height: 16),
//                   AuthButtons(
//                     formKey: _formKey,
//                     emailController: _emailController,
//                     passwordController: _passwordController,
//                     isLoading: state.isLoading,
//                     isSignUpMode: state.isSignUpMode,
//                   ),
//                   const SizedBox(height: 16),
//                   AuthToggleMode(
//                     isSignUpMode: state.isSignUpMode,
//                     isLoading: state.isLoading,
//                     onToggle: () {
//                       _formKey.currentState?.reset();
//                       _emailController.clear();
//                       _passwordController.clear();
//                       viewModel.toggleAuthMode();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildTitle(bool isSignUpMode) {
//     return Text(
//       isSignUpMode ? 'Create New Account' : 'Welcome Back!',
//       style: const TextStyle(
//         fontSize: 24,
//         fontWeight: FontWeight.bold,
//         color: Color(0xFF1A3C34),
//       ),
//     );
//   }

//   Widget _buildEmailField(AuthViewModel viewModel, AuthState state) {
//     return CustomTextField(
//       controller: _emailController,
//       labelText: 'Enter Email',
//       hintText: 'example@email.com',
//       prefixIcon: Icons.email,
//       keyboardType: TextInputType.emailAddress,
//       isRequired: true,
//       validator: (value) => viewModel.validateEmail(value),
//     );
//   }

//   Widget _buildPasswordField(AuthViewModel viewModel, AuthState state) {
//     return CustomTextField(
//       controller: _passwordController,
//       labelText: 'Enter Password',
//       hintText: 'At least 6 characters',
//       prefixIcon: Icons.lock,
//       obscureText: !state.isPasswordVisible,
//       showVisibilityToggle: true,
//       isPasswordVisible: state.isPasswordVisible,
//       isRequired: true,
//       onVisibilityToggle: viewModel.togglePasswordVisibility,
//       validator: (value) => viewModel.validatePassword(value, state.isSignUpMode),
//     );
//   }

//   Widget _buildForgotPassword(AuthViewModel viewModel, AuthState state) {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: TextButton(
//         onPressed: state.isLoading
//             ? null
//             : () => viewModel.resetPassword(_emailController.text.trim()),
//         child: const Text(
//           'Forgot Password?',
//           style: TextStyle(color: Color(0xFF4A90E2)),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/auth/auth_bloc.dart';
import 'package:vistacall/bloc/auth/auth_event.dart';
import 'package:vistacall/bloc/auth/auth_state.dart';
import 'package:vistacall/presentation/widgets/auth/auth_image_header.dart';
import 'package:vistacall/presentation/widgets/auth/auth_buttons.dart';
import 'package:vistacall/presentation/widgets/auth/auth_toggle_mode.dart';
import 'package:vistacall/presentation/widgets/custom_textfield.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AuthImageHeader(isSignUpMode: state.isSignUpMode),
                  const SizedBox(height: 40),
                  _buildTitle(state.isSignUpMode),
                  const SizedBox(height: 20),
                  _buildEmailField(state),
                  const SizedBox(height: 16),
                  _buildPasswordField(state),
                  const SizedBox(height: 16),
                  if (!state.isSignUpMode) _buildForgotPassword(state),
                  const SizedBox(height: 16),
                  AuthButtons(
                    formKey: _formKey,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    isLoading: state.isLoading,
                    isSignUpMode: state.isSignUpMode,
                  ),
                  const SizedBox(height: 16),
                  AuthenticationToggleMode(
                    isSignUpMode: state.isSignUpMode,
                    isLoading: state.isLoading,
                    onToggle: _handleToggleAuthMode,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleToggleAuthMode() {
    _formKey.currentState?.reset();
    _emailController.clear();
    _passwordController.clear();
    context.read<AuthBloc>().add(const AuthToggleMode());
  }

  Widget _buildTitle(bool isSignUpMode) {
    return Text(
      isSignUpMode ? 'Create New Account' : 'Welcome Back!',
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1A3C34),
      ),
    );
  }

  Widget _buildEmailField(AuthState state) {
    return CustomTextField(
      controller: _emailController,
      labelText: 'Enter Email',
      hintText: 'example@email.com',
      prefixIcon: Icons.email,
      keyboardType: TextInputType.emailAddress,
      isRequired: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email is required';
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Enter a valid email address';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField(AuthState state) {
    return CustomTextField(
      controller: _passwordController,
      labelText: 'Enter Password',
      hintText: 'At least 6 characters',
      prefixIcon: Icons.lock,
      obscureText: !state.isPasswordVisible,
      showVisibilityToggle: true,
      isPasswordVisible: state.isPasswordVisible,
      isRequired: true,
      onVisibilityToggle: () {
        context.read<AuthBloc>().add(const AuthTogglePasswordVisibility());
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password is required';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        if (state.isSignUpMode && !RegExp(r'^(?=.*[A-Za-z])(?=.*\d)').hasMatch(value)) {
          return 'Password should contain letters and numbers';
        }
        return null;
      },
    );
  }

  Widget _buildForgotPassword(AuthState state) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: state.isLoading
            ? null
            : () {
                if (_emailController.text.isNotEmpty) {
                  context.read<AuthBloc>().add(
                        AuthResetPassword(_emailController.text.trim()),
                      );
                }
              },
        child: const Text(
          'Forgot Password?',
          style: TextStyle(color: Color(0xFF4A90E2)),
        ),
      ),
    );
  }
}
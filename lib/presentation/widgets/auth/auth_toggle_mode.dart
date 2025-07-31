// lib/presentation/widgets/auth/auth_toggle_mode.dart

import 'package:flutter/material.dart';

class AuthenticationToggleMode extends StatelessWidget {
  final bool isSignUpMode;
  final bool isLoading;
  final VoidCallback onToggle;

  const AuthenticationToggleMode({
    super.key,
    required this.isSignUpMode,
    required this.isLoading,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isSignUpMode ? 'Already have an account?' : 'Don\'t have an account?',
          style: const TextStyle(color: Colors.black54),
        ),
        TextButton(
          onPressed: isLoading ? null : onToggle,
          child: Text(
            isSignUpMode ? 'Sign In' : 'Sign Up',
            style: const TextStyle(color: Color(0xFF4A90E2)),
          ),
        ),
      ],
    );
  }
}
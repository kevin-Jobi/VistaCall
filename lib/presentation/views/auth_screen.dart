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
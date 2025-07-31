import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/presentation/views/auth_screen.dart';
import 'package:vistacall/presentation/views/home.dart';
import 'package:vistacall/utils/constants.dart';
import 'package:vistacall/bloc/auth/auth_bloc.dart';
import 'package:vistacall/bloc/auth/auth_state.dart';

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          // User is authenticated, navigate to home
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppConstants.homeRoute,
            (route) => false,
          );
        } else if (state is Unauthenticated) {
          // User is not authenticated, navigate to auth screen
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppConstants.authRoute,
            (route) => false,
          );
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Authenticated) {
            return const Home();
          } else if (state is AuthLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else {
            return const AuthScreen(); // your login screen
          }
        },
      ),
    );
  }
}

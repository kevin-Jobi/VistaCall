

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/welcome/welcome_state.dart';
import 'package:vistacall/presentation/widgets/custom_widgets/custom_elevated_button.dart.dart';
import 'package:vistacall/bloc/welcome/welcome_bloc.dart';
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

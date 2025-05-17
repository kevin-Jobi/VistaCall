import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/appointments_screen.dart';
import 'package:vistacall/auth_screen.dart';
import 'package:vistacall/chat_screen.dart';
import 'package:vistacall/home.dart';
import 'package:vistacall/messages_screen.dart';
import 'package:vistacall/profileScreen.dart';
import 'package:vistacall/splashscreen.dart';
import 'package:vistacall/welcome.dart';
import 'bloc/home_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Vistacall',
        theme: ThemeData(
          primaryColor: const Color(0xFF4A90E2), // Blue
          scaffoldBackgroundColor: Colors.white,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.black54),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A90E2), // Blue for buttons
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const Splashscreen(),
          '/welcome': (context) => const WelcomeScreen(),
          '/auth': (context) => const AuthScreen(),
          '/home': (context) => const Home(),
          '/profile': (context) => const ProfileScreen(),
          '/appointments': (context) => const AppointmentsScreen(),
          '/messages': (context) => MessagesScreen(),
          '/chat':(context)=> const ChatScreen()
        },
      ),
    );
  }
}

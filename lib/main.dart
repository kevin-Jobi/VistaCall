import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/home/home_bloc.dart';
import 'package:vistacall/presentation/screens/splashscreen.dart';
import 'package:vistacall/presentation/screens/welcome.dart';
import 'package:vistacall/presentation/screens/auth_screen.dart';
import 'package:vistacall/presentation/screens/home.dart';
import 'package:vistacall/presentation/screens/profile_screen.dart';
import 'package:vistacall/presentation/screens/appointments_screen.dart';
import 'package:vistacall/presentation/screens/messages_screen.dart';
import 'package:vistacall/presentation/screens/chat_screen.dart';
import 'package:vistacall/presentation/screens/doctor_list_screen.dart';
import 'package:vistacall/presentation/screens/wrapper.dart';
import 'package:vistacall/viewmodels/auth_viewmodel.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_bloc.dart';
import 'package:vistacall/viewmodels/password_visibility_bloc.dart';
import 'package:vistacall/bloc/profile/profile_bloc.dart';
import 'package:vistacall/bloc/appointments/appointments_bloc.dart';
import 'package:vistacall/bloc/messages/messages_bloc.dart';
import 'package:vistacall/bloc/chat/chat_bloc.dart';
import 'package:vistacall/bloc/splash/splash_bloc.dart';
import 'package:vistacall/bloc/welcome/welcome_bloc.dart';
import 'package:vistacall/bloc/auth/auth_bloc.dart';
import 'package:vistacall/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = AuthViewmodel();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SplashBloc()),
        BlocProvider(create: (context) => WelcomeBloc()),
        BlocProvider(create: (context) => AuthBloc(authViewModel)),
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => ProfileBloc(authViewModel)),
        BlocProvider(create: (context) => AppointmentsBloc()),
        BlocProvider(create: (context) => MessagesBloc()),
        BlocProvider(create: (context) => ChatBloc()),
        BlocProvider(create: (context) => DoctorListBloc()),
        BlocProvider(create: (context) => PasswordVisibilityBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Vistacall',
        theme: ThemeData(
          primaryColor: AppConstants.primaryColor,
          scaffoldBackgroundColor: AppConstants.backgroundColor,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.black54),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
        initialRoute: AppConstants.splashRoute,
        routes: {
          AppConstants.appWrapperRoute: (context) => const AppWrapper(),

          AppConstants.splashRoute: (context) => const Splashscreen(),
          AppConstants.welcomeRoute: (context) => const WelcomeScreen(),
          AppConstants.authRoute: (context) => const AuthScreen(),
          AppConstants.homeRoute: (context) => const Home(),
          AppConstants.profileRoute: (context) => const ProfileScreen(),
          AppConstants.appointmentsRoute:
              (context) => const AppointmentsScreen(),
          AppConstants.messagesRoute: (context) => const MessagesScreen(),
          AppConstants.chatRoute: (context) => const ChatScreen(),
          AppConstants.doctorsRoute: (context) {
            final department =
                ModalRoute.of(context)!.settings.arguments as String;
            return DoctorListScreen(department: department);
          },
        },
      ),
    );
  }
}

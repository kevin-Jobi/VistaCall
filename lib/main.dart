// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_app_check/firebase_app_check.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vistacall/bloc/appointments/appointments_bloc.dart';
// import 'package:vistacall/bloc/auth/auth_bloc.dart';
// import 'package:vistacall/bloc/chat/chat_bloc.dart';
// import 'package:vistacall/bloc/doctor_list/doctor_list_bloc.dart';
// import 'package:vistacall/bloc/doctor_list/doctor_list_event.dart';
// import 'package:vistacall/bloc/home/home_bloc.dart';
// import 'package:vistacall/bloc/messages/messages_bloc.dart';
// import 'package:vistacall/bloc/profile/profile_bloc.dart';
// import 'package:vistacall/bloc/splash/splash_bloc.dart';
// import 'package:vistacall/bloc/welcome/welcome_bloc.dart';
// import 'package:vistacall/data/models/doctor.dart';
// import 'package:vistacall/data/services/navigation_service.dart';
// import 'package:vistacall/firebase_options.dart';
// import 'package:vistacall/presentation/views/appointments_screen.dart';
// import 'package:vistacall/presentation/views/auth_screen.dart';
// import 'package:vistacall/presentation/views/chat_screen.dart';
// import 'package:vistacall/presentation/views/doctor_list_screen.dart';
// import 'package:vistacall/presentation/views/dr.profile.dart';
// import 'package:vistacall/presentation/views/home.dart';
// import 'package:vistacall/presentation/views/messages_screen.dart';
// import 'package:vistacall/presentation/views/profile_screen.dart';
// import 'package:vistacall/presentation/views/splashscreen.dart';
// import 'package:vistacall/presentation/views/welcome.dart';
// import 'package:vistacall/presentation/views/wrapper.dart';
// import 'package:vistacall/utils/constants.dart';
// import 'package:vistacall/viewmodels/auth_viewmodel.dart';
// import 'package:vistacall/viewmodels/favorite_viewmodel.dart';
// import 'package:vistacall/viewmodels/home_viewmodel.dart';
// import 'package:vistacall/viewmodels/password_visibility_bloc.dart';
// import 'package:provider/provider.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await FirebaseAppCheck.instance
//       .activate(androidProvider: AndroidProvider.debug);
//   runApp(const MainApp());
// }

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final authViewModel = AuthViewModel();
//     final firestore = FirebaseFirestore.instance;

//     // Manually create bloc instances to avoid context issues
//     final doctorListBloc = DoctorListBloc(firestore: firestore);
//     final homeBloc = HomeBloc(doctorListBloc: doctorListBloc);
//     final splashBloc = SplashBloc();
//     final welcomeBloc = WelcomeBloc();
//     final authBloc = AuthBloc(authViewModel: authViewModel);
//     final profileBloc = ProfileBloc(authViewModel);
//     final appointmentsBloc = AppointmentsBloc();
//     final messagesBloc = MessagesBloc();
//     final chatBloc = ChatBloc();
//     final passwordVisibilityBloc = PasswordVisibilityBloc();

//     doctorListBloc.add(FetchDoctorsByDepartment('all'));
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider.value(value: splashBloc),
//         BlocProvider.value(value: welcomeBloc),
//         BlocProvider.value(value: authBloc),
//         BlocProvider.value(value: homeBloc),
//         BlocProvider.value(value: profileBloc),
//         BlocProvider.value(value: appointmentsBloc),
//         BlocProvider.value(value: messagesBloc),
//         BlocProvider.value(value: chatBloc),
//         BlocProvider.value(value: doctorListBloc),
//         BlocProvider.value(value: passwordVisibilityBloc),
//       ],
//       child: ChangeNotifierProvider(
//         create: (context) => HomeViewModel(
//           homeBloc,
//           doctorListBloc,
//         ),
//         child: MaterialApp(
//           navigatorKey: NavigationService.navigatorKey,
//           debugShowCheckedModeBanner: false,
//           title: 'Vistacall',
//           theme: ThemeData(
//             primaryColor: AppConstants.primaryColor,
//             scaffoldBackgroundColor: AppConstants.backgroundColor,
//             textTheme: const TextTheme(
//               bodyMedium: TextStyle(color: Colors.black54),
//             ),
//             elevatedButtonTheme: ElevatedButtonThemeData(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppConstants.primaryColor,
//                 foregroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//               ),
//             ),
//           ),
//           initialRoute: AppConstants.splashRoute,
//           routes: {
//             AppConstants.appWrapperRoute: (context) => const AppWrapper(),
//             AppConstants.splashRoute: (context) => const Splashscreen(),
//             AppConstants.welcomeRoute: (context) => const WelcomeScreen(),
//             AppConstants.authRoute: (context) => const AuthScreen(),
//             AppConstants.homeRoute: (context) => const Home(),
//             AppConstants.profileRoute: (context) => const ProfileScreen(),
//             AppConstants.appointmentsRoute: (context) =>
//                 const AppointmentsScreen(),
//             AppConstants.messagesRoute: (context) => const MessagesScreen(),
//             AppConstants.chatRoute: (context) => const ChatScreen(),
//             AppConstants.doctorsRoute: (context) {
//               final department =
//                   ModalRoute.of(context)!.settings.arguments as String;
//               return DoctorListScreen(department: department);
//             },
//             '/drprofile': (context) {
//               final args = ModalRoute.of(context)!.settings.arguments
//                   as Map<String, dynamic>;
//               final doctor = args['doctor'] as DoctorModel;
//               final doctorId = args['doctorId'] as String;
//               print(
//                   'Navigating to Drprofile with doctor: ${doctor.personal['fullName']}, ID: $doctorId');
//               return ChangeNotifierProvider(
//                 create: (_) => FavoriteViewModel(doctor, doctorId: doctorId),
//                 child: Drprofile(doctor: doctor),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/appointments/appointments_bloc.dart';
import 'package:vistacall/bloc/auth/auth_bloc.dart';
import 'package:vistacall/bloc/chat/chat_bloc.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_bloc.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_event.dart';
import 'package:vistacall/bloc/home/home_bloc.dart';
import 'package:vistacall/bloc/messages/messages_bloc.dart';
import 'package:vistacall/bloc/profile/profile_bloc.dart';
import 'package:vistacall/bloc/splash/splash_bloc.dart';
import 'package:vistacall/bloc/welcome/welcome_bloc.dart';
import 'package:vistacall/data/models/doctor.dart';
import 'package:vistacall/data/services/navigation_service.dart';
import 'package:vistacall/firebase_options.dart';
import 'package:vistacall/presentation/views/appointments_screen.dart';
import 'package:vistacall/presentation/views/auth_screen.dart';
import 'package:vistacall/presentation/views/chat_screen.dart';
import 'package:vistacall/presentation/views/doctor_list_screen.dart';
import 'package:vistacall/presentation/views/dr.profile.dart';
import 'package:vistacall/presentation/views/home.dart';
import 'package:vistacall/presentation/views/messages_screen.dart';
import 'package:vistacall/presentation/views/profile_screen.dart';
import 'package:vistacall/presentation/views/splashscreen.dart';
import 'package:vistacall/presentation/views/welcome.dart';
import 'package:vistacall/presentation/views/wrapper.dart';
import 'package:vistacall/presentation/widgets/chat/chatDetailScreen.dart';
import 'package:vistacall/utils/constants.dart';
import 'package:vistacall/viewmodels/auth_viewmodel.dart';
import 'package:vistacall/viewmodels/favorite_viewmodel.dart';
import 'package:vistacall/viewmodels/home_viewmodel.dart';
import 'package:vistacall/viewmodels/password_visibility_bloc.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance
      .activate(androidProvider: AndroidProvider.debug);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = AuthViewModel();
    final firestore = FirebaseFirestore.instance;

    // Manually create bloc instances to avoid context issues
    final doctorListBloc = DoctorListBloc(firestore: firestore);
    final homeBloc = HomeBloc(doctorListBloc: doctorListBloc);
    final splashBloc = SplashBloc();
    final welcomeBloc = WelcomeBloc();
    final authBloc = AuthBloc(authViewModel: authViewModel);
    final profileBloc = ProfileBloc(authViewModel);
    final appointmentsBloc = AppointmentsBloc();
    final messagesBloc = MessagesBloc();
    final chatBloc = ChatBloc();
    final passwordVisibilityBloc = PasswordVisibilityBloc();

    doctorListBloc.add(FetchDoctorsByDepartment('all'));
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: splashBloc),
        BlocProvider.value(value: welcomeBloc),
        BlocProvider.value(value: authBloc),
        BlocProvider.value(value: homeBloc),
        BlocProvider.value(value: profileBloc),
        BlocProvider.value(value: appointmentsBloc),
        BlocProvider.value(value: messagesBloc),
        BlocProvider.value(value: chatBloc),
        BlocProvider.value(value: doctorListBloc),
        BlocProvider.value(value: passwordVisibilityBloc),
      ],
      child: ChangeNotifierProvider(
        create: (context) => HomeViewModel(
          homeBloc,
          doctorListBloc,
        ),
        child: MaterialApp(
          navigatorKey: NavigationService.navigatorKey,
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
            AppConstants.appointmentsRoute: (context) =>
                const AppointmentsScreen(),
            AppConstants.messagesRoute: (context) => const MessagesScreen(),
            AppConstants.chatRoute: (context) => const ChatScreen(),
            AppConstants.chatDetailRoute: (context) {
              // New route for ChatDetailScreen
              final args = ModalRoute.of(context)!.settings.arguments
                  as Map<String, String>;
              return ChatDetailScreen(
                doctorId: args['doctorId']!,
                doctorName: args['doctorName']!,
                chatId: args['chatId']!,
              );
            },
            AppConstants.doctorsRoute: (context) {
              final department =
                  ModalRoute.of(context)!.settings.arguments as String;
              return DoctorListScreen(department: department);
            },
            '/drprofile': (context) {
              final args = ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>;
              final doctor = args['doctor'] as DoctorModel;
              final doctorId = args['doctorId'] as String;
              print(
                  'Navigating to Drprofile with doctor: ${doctor.personal['fullName']}, ID: $doctorId');
              return ChangeNotifierProvider(
                create: (_) => FavoriteViewModel(doctor, doctorId: doctorId),
                child: Drprofile(doctor: doctor),
              );
            }
          },
        ),
      ),
    );
  }
}

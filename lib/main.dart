import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
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
import 'package:vistacall/consts.dart';
import 'package:vistacall/data/models/appointment.dart';
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
import 'package:vistacall/presentation/widgets/bookappointments/booking_details.dart';
import 'package:vistacall/presentation/widgets/bookappointments/booking_details_with_rating_page.dart';
import 'package:vistacall/presentation/views/chatDetailScreen.dart';
import 'package:vistacall/theme/app_theme.dart';
import 'package:vistacall/utils/constants.dart';
import 'package:vistacall/viewmodels/auth_viewmodel.dart';
import 'package:vistacall/viewmodels/favorite_viewmodel.dart';
import 'package:vistacall/viewmodels/home_viewmodel.dart';
import 'package:vistacall/viewmodels/password_visibility_bloc.dart';
import 'package:provider/provider.dart';

// void main() async {
//   await dotenv.load(fileName: ".env");
//   final apiKey = dotenv.env['GEMINI_API_KEY'];

//   if(apiKey == null || apiKey.isEmpty){
//     print('ERROR: GEMINI_API_KEY not found in .env file!');
//     return;
//   }
//   Gemini.init(apiKey: apiKey);
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await FirebaseAppCheck.instance
//       .activate(androidProvider: AndroidProvider.debug);
//   runApp(const MainApp());
// }

// void main() async {
//   // Initialize Flutter before using plugins.
//   WidgetsFlutterBinding.ensureInitialized();

//   // Gemini is optional. Its failure should not prevent app startup.
//   try {
//     await dotenv.load(fileName: ".env");

//     final apiKey = dotenv.env['GEMINI_API_KEY'];

//     if (apiKey != null && apiKey.isNotEmpty) {
//       Gemini.init(apiKey: apiKey);
//       debugPrint('Gemini initialized successfully');
//     } else {
//       debugPrint('WARNING: GEMINI_API_KEY is missing');
//     }
//   } catch (e) {
//     debugPrint('Gemini environment loading failed: $e');
//   }

//   // Firebase initialization is required by this application.
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   // App Check should not hold up startup indefinitely.
//   try {
//     await FirebaseAppCheck.instance
//         .activate(androidProvider: AndroidProvider.debug)
//         .timeout(const Duration(seconds: 10));
//   } catch (e) {
//     debugPrint('Firebase App Check activation failed: $e');
//   }

//   debugPrint('Starting VistaCall...');

//   runApp(const MainApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Gemini is optional. Never block app startup because of its API key.
  try {
    await dotenv.load(fileName: ".env");

    final apiKey = dotenv.env['GEMINI_API_KEY'];

    if (apiKey != null && apiKey.isNotEmpty) {
      Gemini.init(apiKey: apiKey);
      debugPrint('Gemini initialized successfully');
    } else {
      debugPrint('WARNING: GEMINI_API_KEY is missing');
    }
  } catch (e) {
    debugPrint('Gemini initialization failed: $e');
  }

  // Initialize Firebase.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // App Check should not block startup indefinitely.
  try {
    await FirebaseAppCheck.instance
        .activate(androidProvider: AndroidProvider.debug)
        .timeout(const Duration(seconds: 10));
  } catch (e) {
    debugPrint('App Check initialization failed: $e');
  }

  debugPrint('Starting VistaCall');

  runApp(const MainApp());
}



class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = AuthViewModel();
    final firestore = FirebaseFirestore.instance;

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
        child: GetMaterialApp(
          navigatorKey: NavigationService.navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Vistacall',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.light,
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
            },
            '/booking-details': (context) {
              final appointment =
                  ModalRoute.of(context)!.settings.arguments as Appointment;
              return BookingDetailsPage(appointment: appointment);
            },
            '/booking-details-with-rating': (context) =>
                BookingDetailsWithRatingPage(
                  appointment:
                      ModalRoute.of(context)!.settings.arguments as Appointment,
                ),
          },
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// /// Premium deep-blue home screen for a doctor booking app.
// /// UI only: every list uses mock data, so swap in your own models/BLoC state
// /// where marked "DATA".

// void main() => runApp(const _PreviewApp());

// class _PreviewApp extends StatelessWidget {
//   const _PreviewApp();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(useMaterial3: true, scaffoldBackgroundColor: AppColors.surface),
//       home: const PremiumHomeScreen(),
//     );
//   }
// }

// // ─────────────────────────────── Palette ───────────────────────────────

// class AppColors {
//   static const navy900 = Color(0xFF061128);
//   static const navy800 = Color(0xFF0A1F44);
//   static const navy700 = Color(0xFF102C5C);
//   static const navy600 = Color(0xFF1B3F7A);
//   static const accent = Color(0xFFC9A961); // muted champagne gold
//   static const surface = Color(0xFFF4F6FB);
//   static const ink = Color(0xFF0B1B3A);
//   static const muted = Color(0xFF6B7A99);
//   static const line = Color(0xFFE3E8F2);
// }

// const _navyGradient = LinearGradient(
//   begin: Alignment.topLeft,
//   end: Alignment.bottomRight,
//   colors: [AppColors.navy800, AppColors.navy600],
// );

// // ─────────────────────────────── Screen ────────────────────────────────

// class PremiumHomeScreen extends StatefulWidget {
//   const PremiumHomeScreen({super.key});

//   @override
//   State<PremiumHomeScreen> createState() => _PremiumHomeScreenState();
// }

// class _PremiumHomeScreenState extends State<PremiumHomeScreen> {
//   int _tab = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBody: true,
//       bottomNavigationBar: _FloatingNavBar(
//         index: _tab,
//         onChanged: (i) => setState(() => _tab = i),
//       ),
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         padding: const EdgeInsets.only(bottom: 120),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             HomeHeader(),
//             SizedBox(height: 22),
//             UpcomingAppointmentCard(),
//             SizedBox(height: 28),
//             SectionTitle(title: 'Specialities'),
//             SizedBox(height: 14),
//             DoctorCategoriesGrid(),
//             SizedBox(height: 28),
//             SectionTitle(title: 'Top Doctors'),
//             SizedBox(height: 14),
//             TopDoctorsList(),
//             SizedBox(height: 28),
//             SectionTitle(title: 'Health Articles'),
//             SizedBox(height: 14),
//             HealthArticles(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ─────────────────────────────── Header ────────────────────────────────

// class HomeHeader extends StatelessWidget {
//   const HomeHeader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final top = MediaQuery.of(context).padding.top;
//     return Container(
//       padding: EdgeInsets.fromLTRB(20, top + 16, 20, 28),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [AppColors.navy900, AppColors.navy700],
//         ),
//         borderRadius: BorderRadius.vertical(bottom: Radius.circular(36)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               const _Avatar(initials: 'AR', size: 46, ring: true),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Good morning',
//                         style: TextStyle(
//                             color: Colors.white.withOpacity(0.6),
//                             fontSize: 12.5,
//                             letterSpacing: 0.3)),
//                     const SizedBox(height: 2),
//                     const Text('Alexander Reed', // DATA: user name
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16.5,
//                             fontWeight: FontWeight.w600)),
//                   ],
//                 ),
//               ),
//               const _GlassIconButton(icon: Icons.notifications_none_rounded, dot: true),
//             ],
//           ),
//           const SizedBox(height: 28),
//           const Text(
//             'Your health,\nin expert hands.',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 29,
//               height: 1.2,
//               fontWeight: FontWeight.w700,
//               letterSpacing: -0.4,
//             ),
//           ),
//           const SizedBox(height: 22),
//           const SearchSection(),
//         ],
//       ),
//     );
//   }
// }

// class SearchSection extends StatelessWidget {
//   const SearchSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 56,
//       padding: const EdgeInsets.only(left: 16, right: 8),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.09),
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: Colors.white.withOpacity(0.14)),
//       ),
//       child: Row(
//         children: [
//           Icon(Icons.search_rounded, color: Colors.white.withOpacity(0.7), size: 22),
//           const SizedBox(width: 10),
//           Expanded(
//             child: TextField(
//               style: const TextStyle(color: Colors.white, fontSize: 14.5),
//               cursorColor: AppColors.accent,
//               decoration: InputDecoration(
//                 border: InputBorder.none,
//                 hintText: 'Search doctors, clinics, symptoms',
//                 hintStyle: TextStyle(color: Colors.white.withOpacity(0.45), fontSize: 14),
//               ),
//             ),
//           ),
//           Container(
//             width: 40,
//             height: 40,
//             decoration: BoxDecoration(
//               color: AppColors.accent,
//               borderRadius: BorderRadius.circular(13),
//             ),
//             child: const Icon(Icons.tune_rounded, color: AppColors.navy900, size: 20),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ───────────────────────── Upcoming appointment ────────────────────────

// class UpcomingAppointmentCard extends StatelessWidget {
//   const UpcomingAppointmentCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         gradient: _navyGradient,
//         borderRadius: BorderRadius.circular(26),
//         border: Border.all(color: AppColors.accent.withOpacity(0.35), width: 0.8),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.navy800.withOpacity(0.28),
//             blurRadius: 30,
//             offset: const Offset(0, 14),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               const Text('UPCOMING',
//                   style: TextStyle(
//                       color: AppColors.accent,
//                       fontSize: 11,
//                       fontWeight: FontWeight.w700,
//                       letterSpacing: 1.6)),
//               const Spacer(),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.12),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: const Text('In 3 days',
//                     style: TextStyle(color: Colors.white, fontSize: 11.5)),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           Row(
//             children: [
//               const _Avatar(initials: 'SM', size: 52),
//               const SizedBox(width: 14),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text('Dr. Sophia Martin', // DATA
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16.5,
//                             fontWeight: FontWeight.w600)),
//                     const SizedBox(height: 3),
//                     Text('Cardiologist',
//                         style: TextStyle(
//                             color: Colors.white.withOpacity(0.65), fontSize: 13)),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           Container(height: 1, color: Colors.white.withOpacity(0.1)),
//           const SizedBox(height: 14),
//           Row(
//             children: [
//               _MetaChip(icon: Icons.calendar_today_rounded, label: 'Thu, 12 Nov'),
//               const SizedBox(width: 16),
//               _MetaChip(icon: Icons.access_time_rounded, label: '10:30 AM'),
//               const Spacer(),
//               Text('Details',
//                   style: TextStyle(
//                       color: AppColors.accent,
//                       fontSize: 13,
//                       fontWeight: FontWeight.w600)),
//               const SizedBox(width: 2),
//               const Icon(Icons.chevron_right_rounded, color: AppColors.accent, size: 18),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _MetaChip extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   const _MetaChip({required this.icon, required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(icon, size: 15, color: Colors.white.withOpacity(0.65)),
//         const SizedBox(width: 6),
//         Text(label,
//             style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12.5)),
//       ],
//     );
//   }
// }

// // ───────────────────────────── Categories ──────────────────────────────

// class DoctorCategoriesGrid extends StatelessWidget {
//   const DoctorCategoriesGrid({super.key});

//   // DATA: replace with your categories
//   static const _items = [
//     (Icons.favorite_border_rounded, 'Cardiology'),
//     (Icons.psychology_outlined, 'Neurology'),
//     (Icons.medical_services_outlined, 'Dental'),
//     (Icons.visibility_outlined, 'Eye Care'),
//     (Icons.child_care_rounded, 'Pediatrics'),
//     (Icons.accessibility_new_rounded, 'Ortho'),
//     (Icons.spa_outlined, 'Dermatology'),
//     (Icons.grid_view_rounded, 'More'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: GridView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: _items.length,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 4,
//           mainAxisSpacing: 18,
//           crossAxisSpacing: 12,
//           mainAxisExtent: 92,
//         ),
//         itemBuilder: (_, i) {
//           final (icon, label) = _items[i];
//           final isMore = i == _items.length - 1;
//           return Column(
//             children: [
//               Container(
//                 width: 62,
//                 height: 62,
//                 decoration: BoxDecoration(
//                   color: isMore ? AppColors.navy800 : Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                   border: isMore ? null : Border.all(color: AppColors.line),
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColors.navy800.withOpacity(0.06),
//                       blurRadius: 14,
//                       offset: const Offset(0, 6),
//                     ),
//                   ],
//                 ),
//                 child: Icon(icon,
//                     size: 26, color: isMore ? AppColors.accent : AppColors.navy700),
//               ),
//               const SizedBox(height: 9),
//               Text(label,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                       color: AppColors.ink, fontSize: 12, fontWeight: FontWeight.w500)),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

// // ───────────────────────────── Top doctors ─────────────────────────────

// class TopDoctorsList extends StatelessWidget {
//   const TopDoctorsList({super.key});

//   // DATA: replace with your doctor model list
//   static const _doctors = [
//     ('Dr. Sophia Martin', 'Cardiologist', 'SM', '4.9', '\$80'),
//     ('Dr. James Whitfield', 'Neurologist', 'JW', '4.8', '\$95'),
//     ('Dr. Amelia Brooks', 'Dermatologist', 'AB', '4.9', '\$70'),
//     ('Dr. Daniel Hayes', 'Orthopedic', 'DH', '4.7', '\$85'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 214,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         physics: const BouncingScrollPhysics(),
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         itemCount: _doctors.length,
//         separatorBuilder: (_, __) => const SizedBox(width: 14),
//         itemBuilder: (_, i) {
//           final (name, spec, initials, rating, fee) = _doctors[i];
//           return Container(
//             width: 176,
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(24),
//               border: Border.all(color: AppColors.line),
//               boxShadow: [
//                 BoxShadow(
//                   color: AppColors.navy800.withOpacity(0.07),
//                   blurRadius: 20,
//                   offset: const Offset(0, 10),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     _Avatar(initials: initials, size: 48),
//                     const Spacer(),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: AppColors.accent.withOpacity(0.14),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Row(
//                         children: [
//                           const Icon(Icons.star_rounded, size: 14, color: AppColors.accent),
//                           const SizedBox(width: 3),
//                           Text(rating,
//                               style: const TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w700,
//                                   color: AppColors.ink)),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 14),
//                 Text(name,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                         fontSize: 14.5,
//                         fontWeight: FontWeight.w700,
//                         color: AppColors.ink)),
//                 const SizedBox(height: 3),
//                 Text(spec,
//                     style: const TextStyle(fontSize: 12.5, color: AppColors.muted)),
//                 const Spacer(),
//                 Row(
//                   children: [
//                     RichText(
//                       text: TextSpan(
//                         children: [
//                           TextSpan(
//                               text: fee,
//                               style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w700,
//                                   color: AppColors.navy800)),
//                           const TextSpan(
//                               text: ' /visit',
//                               style: TextStyle(fontSize: 11, color: AppColors.muted)),
//                         ],
//                       ),
//                     ),
//                     const Spacer(),
//                     Container(
//                       width: 36,
//                       height: 36,
//                       decoration: BoxDecoration(
//                         gradient: _navyGradient,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: const Icon(Icons.arrow_outward_rounded,
//                           size: 18, color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// // ───────────────────────────── Articles ────────────────────────────────

// class HealthArticles extends StatelessWidget {
//   const HealthArticles({super.key});

//   // DATA: replace with your articles
//   static const _articles = [
//     ('HEART HEALTH', '7 daily habits that protect your heart', '5 min read',
//         Icons.favorite_rounded),
//     ('WELLNESS', 'How quality sleep reshapes your immunity', '4 min read',
//         Icons.nightlight_round),
//     ('NUTRITION', 'A simple guide to balanced eating', '6 min read',
//         Icons.eco_rounded),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         children: [
//           for (final a in _articles)
//             Container(
//               margin: const EdgeInsets.only(bottom: 12),
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(22),
//                 border: Border.all(color: AppColors.line),
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 74,
//                     height: 74,
//                     decoration: BoxDecoration(
//                       gradient: _navyGradient,
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Icon(a.$4, color: AppColors.accent, size: 28),
//                   ),
//                   const SizedBox(width: 14),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(a.$1,
//                             style: const TextStyle(
//                                 fontSize: 10.5,
//                                 fontWeight: FontWeight.w700,
//                                 letterSpacing: 1.2,
//                                 color: AppColors.accent)),
//                         const SizedBox(height: 5),
//                         Text(a.$2,
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(
//                                 fontSize: 14,
//                                 height: 1.3,
//                                 fontWeight: FontWeight.w600,
//                                 color: AppColors.ink)),
//                         const SizedBox(height: 6),
//                         Text(a.$3,
//                             style: const TextStyle(fontSize: 11.5, color: AppColors.muted)),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// // ──────────────────────────── Shared widgets ───────────────────────────

// class SectionTitle extends StatelessWidget {
//   final String title;
//   const SectionTitle({super.key, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Row(
//         children: [
//           Text(title,
//               style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w700,
//                   letterSpacing: -0.2,
//                   color: AppColors.ink)),
//           const Spacer(),
//           const Text('See all',
//               style: TextStyle(
//                   fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.navy600)),
//         ],
//       ),
//     );
//   }
// }

// class _Avatar extends StatelessWidget {
//   final String initials;
//   final double size;
//   final bool ring;
//   const _Avatar({required this.initials, required this.size, this.ring = false});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: size,
//       height: size,
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         gradient: const LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [AppColors.navy600, AppColors.navy800],
//         ),
//         border: Border.all(
//           color: ring ? AppColors.accent : Colors.white.withOpacity(0.18),
//           width: ring ? 1.5 : 1,
//         ),
//       ),
//       child: Text(initials,
//           style: TextStyle(
//               color: Colors.white,
//               fontSize: size * 0.34,
//               fontWeight: FontWeight.w600,
//               letterSpacing: 0.5)),
//     );
//   }
// }

// class _GlassIconButton extends StatelessWidget {
//   final IconData icon;
//   final bool dot;
//   const _GlassIconButton({required this.icon, this.dot = false});

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           width: 44,
//           height: 44,
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.09),
//             borderRadius: BorderRadius.circular(14),
//             border: Border.all(color: Colors.white.withOpacity(0.14)),
//           ),
//           child: Icon(icon, color: Colors.white, size: 22),
//         ),
//         if (dot)
//           Positioned(
//             top: 11,
//             right: 12,
//             child: Container(
//               width: 8,
//               height: 8,
//               decoration: BoxDecoration(
//                 color: AppColors.accent,
//                 shape: BoxShape.circle,
//                 border: Border.all(color: AppColors.navy800, width: 1.5),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }

// // ───────────────────────────── Bottom bar ──────────────────────────────

// class _FloatingNavBar extends StatelessWidget {
//   final int index;
//   final ValueChanged<int> onChanged;
//   const _FloatingNavBar({required this.index, required this.onChanged});

//   static const _icons = [
//     Icons.home_rounded,
//     Icons.calendar_month_rounded,
//     Icons.chat_bubble_outline_rounded,
//     Icons.person_outline_rounded,
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
//         child: Container(
//           height: 68,
//           decoration: BoxDecoration(
//             color: AppColors.navy800,
//             borderRadius: BorderRadius.circular(26),
//             boxShadow: [
//               BoxShadow(
//                 color: AppColors.navy900.withOpacity(0.35),
//                 blurRadius: 28,
//                 offset: const Offset(0, 12),
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               for (int i = 0; i < _icons.length; i++)
//                 GestureDetector(
//                   behavior: HitTestBehavior.opaque,
//                   onTap: () => onChanged(i),
//                   child: SizedBox(
//                     width: 60,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(_icons[i],
//                             size: 25,
//                             color: i == index
//                                 ? AppColors.accent
//                                 : Colors.white.withOpacity(0.5)),
//                         const SizedBox(height: 5),
//                         AnimatedContainer(
//                           duration: const Duration(milliseconds: 220),
//                           width: i == index ? 16 : 0,
//                           height: 3,
//                           decoration: BoxDecoration(
//                             color: AppColors.accent,
//                             borderRadius: BorderRadius.circular(2),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
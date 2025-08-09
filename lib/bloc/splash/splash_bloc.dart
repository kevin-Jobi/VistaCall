import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vistacall/bloc/splash/splash_event.dart';
import 'package:vistacall/bloc/splash/splash_state.dart';
import 'package:vistacall/utils/constants.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashLoadingState()) {
    on<StartSplashEvent>((event, emit) async {
      emit(SplashLoadingState());
      await Future.delayed(const Duration(seconds: 3));
      // final authStateStream = FirebaseAuth.instance.authStateChanges();
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        emit(SplashNavigateState(AppConstants.homeRoute));
      } else {
        emit(SplashNavigateState(AppConstants.welcomeRoute));
      }
    });
  }
}

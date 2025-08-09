import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' show User, FirebaseAuth;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/profile/profile_event.dart';
import 'package:vistacall/bloc/profile/profile_state.dart';
import 'package:vistacall/viewmodels/auth_viewmodel.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthViewModel authViewModel;
  StreamSubscription<User?>? _authSubscription;

  ProfileBloc(this.authViewModel) : super(ProfileLoadingState()) {
    // Listen to auth state changes
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        add(LogoutSuccessEvent());
      }
    });

    on<LoadProfileEvent>((event, emit) async {
      emit(ProfileLoadingState());
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          emit(ProfileLoadedState(
            name: user.displayName ?? 'Melbin',
            email: user.email ?? 'melbin@gmail.com',
            photoUrl: user.photoURL,
          ));
        } else {
          emit(ProfileErrorState('User not found'));
        }
      } catch (e) {
        emit(ProfileErrorState('Failed to load profile: $e'));
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(ProfileLoadingState());
      try {
        await authViewModel.logout();
        // Don't emit logged out state here - wait for authStateChanges
      } catch (e) {
        emit(ProfileErrorState('Logout failed: ${e.toString()}'));
        emit(ProfileLoadedState(
          name: FirebaseAuth.instance.currentUser?.displayName ?? 'Melbin',
          email: FirebaseAuth.instance.currentUser?.email ?? 'melbin@gmail.com',
          photoUrl: FirebaseAuth.instance.currentUser?.photoURL,
        ));
      }
    });

    on<LogoutSuccessEvent>((event, emit) {
      emit(ProfileLoggedOutState());
    });
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}

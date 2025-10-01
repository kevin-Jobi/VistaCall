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
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        add(LogoutSuccessEvent());
      } else {
        add(LoadProfileEvent());
      }
    });

    on<LoadProfileEvent>((event, emit) async {
      emit(ProfileLoadingState());
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          print(
              'Loaded user: name=${user.displayName}, email=${user.email}, photoUrl=${user.photoURL}');
          emit(ProfileLoadedState(
            name: user.displayName ?? '',
            email: user.email ?? '',
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
      } catch (e) {
        emit(ProfileErrorState('Logout failed: ${e.toString()}'));
        final u = FirebaseAuth.instance.currentUser;
        emit(ProfileLoadedState(
          name: u?.displayName ?? '',
          email: u?.email ?? '',
          photoUrl: u?.photoURL,
        ));
      }
    });

    on<LogoutSuccessEvent>((event, emit) {
      emit(ProfileLoggedOutState());
    });

    on<UpdateProfileEvent>((event, emit) async {
      final current = FirebaseAuth.instance.currentUser;
      if (current == null) {
        emit(ProfileErrorState('User not found'));
        return;
      }
      emit(ProfileLoadingState());
      try {
        String? newPhotoUrl;

        if (event.imagePath != null && event.imagePath!.isNotEmpty) {
          print('Using original image path: ${event.imagePath}');
          newPhotoUrl = event.imagePath; // Use original path without copying
        }

        if (event.name.isNotEmpty &&
            event.name != (current.displayName ?? '')) {
          print('Updating display name to: ${event.name}');
          await current.updateDisplayName(event.name);
        }

        await current.reload();
        final refreshed = FirebaseAuth.instance.currentUser;
        print(
            'Refreshed user: name=${refreshed?.displayName}, email=${refreshed?.email}, photoUrl=${refreshed?.photoURL}');

        emit(ProfileLoadedState(
          name: refreshed?.displayName ?? event.name,
          email: refreshed?.email ?? current.email ?? '',
          photoUrl: newPhotoUrl ?? refreshed?.photoURL ?? current.photoURL,
        ));
      } catch (e) {
        print('Update profile error: $e');
        emit(ProfileErrorState('Failed to update profile: $e'));
        add(LoadProfileEvent());
      }
    });
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}

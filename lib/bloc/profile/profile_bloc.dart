

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/profile/profile_event.dart';
import 'package:vistacall/bloc/profile/profile_state.dart';
import 'package:vistacall/viewmodels/auth_viewmodel.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthViewmodel authViewModel;

  ProfileBloc(this.authViewModel) : super(ProfileLoadingState()) {
    on<LoadProfileEvent>((event, emit) async {
      emit(ProfileLoadingState());
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          emit(
            ProfileLoadedState(
              name: user.displayName ?? 'Melbin',
              email: user.email ?? 'melbin@gmail.com',
              photoUrl: user.photoURL,
            ),
          );
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
        bool success = await authViewModel.logout();
        if (success) {
          emit(ProfileLoggedOutState());
        } else {
          emit(
            ProfileErrorState(authViewModel.errorMessage ?? 'Logout failed'),
          );
        }
      } catch (e) {
        emit(ProfileErrorState('Logout failed: $e'));
      }
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vistacall/viewmodels/auth_viewmodel.dart';

abstract class ProfileEvent {}

class LoadProfileEvent extends ProfileEvent {}

class LogoutEvent extends ProfileEvent {}

abstract class ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final String name;
  final String email;
  final String? photoUrl;

  ProfileLoadedState({required this.name, required this.email, this.photoUrl});
}

class ProfileErrorState extends ProfileState {
  final String error;

  ProfileErrorState(this.error);
}

class ProfileLoggedOutState extends ProfileState {}

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

    // on<LogoutEvent>((event, emit) async {
    //   emit(ProfileLoadingState());
    //   try {
    //     bool success = await authViewModel.logout();
    //     if (success) {
    //       emit(ProfileLoggedOutState());
    //     } else {
    //       emit(
    //         ProfileErrorState(authViewModel.errorMessage ?? 'Logout failed'),
    //       );
    //     }
    //   } catch (e) {
    //     emit(ProfileErrorState('Logout failed: $e'));
    //   }
    // });
  }
}

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
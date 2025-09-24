abstract class ProfileEvent {}

class LoadProfileEvent extends ProfileEvent {}

class LogoutEvent extends ProfileEvent {}

class LogoutSuccessEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent{
  final String name;
  final String? imagePath;

  UpdateProfileEvent({
    required this.name,
    this.imagePath
  });
}

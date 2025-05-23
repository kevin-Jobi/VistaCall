// abstract class AuthEvent {}

// class SignInEvent extends AuthEvent {
//   final String email;
//   final String password;

//   SignInEvent(this.email, this.password);
// }

// class SignUpEvent extends AuthEvent {
//   final String email;
//   final String password;

//   SignUpEvent(this.email, this.password);
// }

// class SignInWithGoogleEvent extends AuthEvent {}

// class ResetPasswordEvent extends AuthEvent {
//   final String email;

//   ResetPasswordEvent(this.email);
// }

// class ToggleAuthModeEvent extends AuthEvent {}

// // Add to your auth_event.dart
// class LogoutEvent extends AuthEvent {}
//--------------------------------------------------------------
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class CheckAuthStatusEvent extends AuthEvent {
  const CheckAuthStatusEvent();
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;

  const SignUpEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class SignInWithGoogleEvent extends AuthEvent {
  const SignInWithGoogleEvent();
}

class ResetPasswordEvent extends AuthEvent {
  final String email;

  const ResetPasswordEvent(this.email);

  @override
  List<Object?> get props => [email];
}

class ToggleAuthModeEvent extends AuthEvent {
  const ToggleAuthModeEvent();
}

class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}

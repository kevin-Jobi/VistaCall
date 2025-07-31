
// import 'package:equatable/equatable.dart';

// abstract class AuthEvent extends Equatable {
//   const AuthEvent();

//   @override
//   List<Object?> get props => [];
// }

// class CheckAuthStatusEvent extends AuthEvent {
//   const CheckAuthStatusEvent();
// }

// class SignInEvent extends AuthEvent {
//   final String email;
//   final String password;

//   const SignInEvent(this.email, this.password);

//   @override
//   List<Object?> get props => [email, password];
// }

// class SignUpEvent extends AuthEvent {
//   final String email;
//   final String password;

//   const SignUpEvent(this.email, this.password);

//   @override
//   List<Object?> get props => [email, password];
// }

// class SignInWithGoogleEvent extends AuthEvent {
//   const SignInWithGoogleEvent();
// }

// class ResetPasswordEvent extends AuthEvent {
//   final String email;

//   const ResetPasswordEvent(this.email);

//   @override
//   List<Object?> get props => [email];
// }

// class ToggleAuthModeEvent extends AuthEvent {
//   const ToggleAuthModeEvent();
// }

// class TogglePasswordVisibilityEvent extends AuthEvent {}

// class LogoutEvent extends AuthEvent {
//   const LogoutEvent();
// }

// class AuthLoadingEvent extends AuthEvent{}

// class AuthSuccessEvent extends AuthEvent{}

// class AuthErrorEvent extends AuthEvent{
//   final String errorMessage;

//   const AuthErrorEvent(this.errorMessage);
// }

// class ResetPasswordSuccessEvent extends AuthEvent{}

// class LogoutSuccessEvent extends AuthEvent{}



// -----------------------------------------------

// lib/bloc/auth/auth_event.dart

import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthCheckStatus extends AuthEvent {
  const AuthCheckStatus();
}

class AuthSignIn extends AuthEvent {
  final String email;
  final String password;

  const AuthSignIn(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class AuthSignUp extends AuthEvent {
  final String email;
  final String password;

  const AuthSignUp(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class AuthSignInWithGoogle extends AuthEvent {
  const AuthSignInWithGoogle();
}

class AuthResetPassword extends AuthEvent {
  final String email;

  const AuthResetPassword(this.email);

  @override
  List<Object?> get props => [email];
}

class AuthToggleMode extends AuthEvent {
  const AuthToggleMode();
}

class AuthTogglePasswordVisibility extends AuthEvent {
  const AuthTogglePasswordVisibility();
}

class AuthLogout extends AuthEvent {
  const AuthLogout();
}
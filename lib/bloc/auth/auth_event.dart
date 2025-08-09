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
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable {
  final bool isLoading;
  final bool isSignUpMode;
  final bool isPasswordVisible;
  final User? user;

  const AuthState({
    this.isLoading = false,
    this.isSignUpMode = false,
    this.isPasswordVisible = false,
    this.user,
  });

  @override
  List<Object?> get props => [
        isLoading,
        isSignUpMode,
        isPasswordVisible,
        user,
      ];
}

class AuthInitial extends AuthState {
  const AuthInitial() : super();
}

class AuthLoading extends AuthState {
  const AuthLoading({
    bool isSignUpMode = false,
    bool isPasswordVisible = false,
  }) : super(
          isLoading: true,
          isSignUpMode: isSignUpMode,
          isPasswordVisible: isPasswordVisible,
        );
}

class Authenticated extends AuthState {
  const Authenticated(User user, {bool isPasswordVisible = false})
      : super(
          user: user,
          isPasswordVisible: isPasswordVisible,
        );
}

class Unauthenticated extends AuthState {
  const Unauthenticated({
    bool isSignUpMode = false,
    bool isPasswordVisible = false,
  }) : super(
          isSignUpMode: isSignUpMode,
          isPasswordVisible: isPasswordVisible,
        );
}

class AuthError extends AuthState {
  final String message;

  const AuthError(
    this.message, {
    bool isSignUpMode = false,
    bool isPasswordVisible = false,
  }) : super(
          isSignUpMode: isSignUpMode,
          isPasswordVisible: isPasswordVisible,
        );

  @override
  List<Object?> get props => super.props..add(message);
}

class ResetPasswordSent extends AuthState {
  const ResetPasswordSent({
    bool isSignUpMode = false,
    bool isPasswordVisible = false,
  }) : super(
          isSignUpMode: isSignUpMode,
          isPasswordVisible: isPasswordVisible,
        );
}

import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  final bool isLoading;
  final bool isSignUpMode;
  final String? errorMessage;
  final bool resetPasswordSuccess;
  final bool isPasswordVisible;

  const AuthState({
    this.isLoading = false,
    this.isSignUpMode = false,
    this.errorMessage,
    this.resetPasswordSuccess = false,
    this.isPasswordVisible = false,
  });

  @override
  List<Object?> get props => [
    isLoading,
    isSignUpMode,
    errorMessage,
    resetPasswordSuccess,
    isPasswordVisible,
  ];
}

class AuthInitial extends AuthState {
  const AuthInitial()
    : super(
        isLoading: false,
        isSignUpMode: false,
        errorMessage: null,
        resetPasswordSuccess: false,
        isPasswordVisible: false,
      );
}

class Unauthenticated extends AuthState {
  const Unauthenticated({
    bool isSignUpMode = false,
    bool isPasswordVisible = false,
  }) : super(isSignUpMode: isSignUpMode, isPasswordVisible: isPasswordVisible);
}

class Authenticated extends AuthState {
  const Authenticated({bool isPasswordVisible = false})
    : super(isPasswordVisible: isPasswordVisible);
}

class AuthLoading extends AuthState {
  const AuthLoading({bool isSignUpMode = false, bool isPasswordVisible = false})
    : super(
        isLoading: true,
        isSignUpMode: isSignUpMode,
        isPasswordVisible: isPasswordVisible,
      );
}

class AuthError extends AuthState {
  const AuthError(
    String errorMessage, {
    bool isSignUpMode = false,
    bool isPasswordVisible = false,
  }) : super(
          errorMessage: errorMessage,
          isSignUpMode: isSignUpMode,
          isPasswordVisible: isPasswordVisible,
        );
}

class ResetPasswordSuccess extends AuthState {
  const ResetPasswordSuccess({
    bool isSignUpMode = false,
    bool isPasswordVisible = false,
  }) : super(
          resetPasswordSuccess: true,
          isSignUpMode: isSignUpMode,
          isPasswordVisible: isPasswordVisible,
        );
}
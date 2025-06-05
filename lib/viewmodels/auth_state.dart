// class AuthState {
//   final bool isLoading;
//   final bool isSignUpMode;
//   final String? errorMessage;
//   final bool resetPasswordSuccess;

//   AuthState({
//     this.isLoading = false,
//     this.isSignUpMode = false,
//     this.errorMessage,
//     this.resetPasswordSuccess = false,
//   });

//   AuthState copyWith({
//     bool? isLoading,
//     bool? isSignUpMode,
//     String? errorMessage,
//     bool? resetPasswordSuccess,
//   }) {
//     return AuthState(
//       isLoading: isLoading ?? this.isLoading,
//       isSignUpMode: isSignUpMode ?? this.isSignUpMode,
//       errorMessage: errorMessage ?? this.errorMessage,
//       resetPasswordSuccess: resetPasswordSuccess ?? this.resetPasswordSuccess,
//     );
//   }

//   // In auth_state.dart, add:
//   factory AuthState.initial() => AuthState(
//     isLoading: false,
//     errorMessage: null,
//     isSignUpMode: false,
//     resetPasswordSuccess: false,
//   );
// }
//-----------------------------------------------------
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
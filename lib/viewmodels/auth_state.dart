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
abstract class AuthState {
  final bool isLoading;
  final bool isSignUpMode;
  final String? errorMessage;
  final bool resetPasswordSuccess;

  const AuthState({
    this.isLoading = false,
    this.isSignUpMode = false,
    this.errorMessage,
    this.resetPasswordSuccess = false,
  });
}

class AuthInitial extends AuthState {
  const AuthInitial() : super();
}

class Unauthenticated extends AuthState {
  const Unauthenticated({bool isSignUpMode = false})
    : super(isSignUpMode: isSignUpMode);
}

class Authenticated extends AuthState {
  const Authenticated() : super();
}

class AuthLoading extends AuthState {
  const AuthLoading() : super(isLoading: true);
}

class AuthError extends AuthState {
  const AuthError(String errorMessage) : super(errorMessage: errorMessage);
}

class ResetPasswordSuccess extends AuthState {
  const ResetPasswordSuccess() : super(resetPasswordSuccess: true);
}

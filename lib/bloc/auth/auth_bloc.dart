
// import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vistacall/bloc/auth/auth_event.dart';
// import 'package:vistacall/bloc/auth/auth_state.dart';
// import 'package:vistacall/viewmodels/auth_viewmodel.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final AuthViewmodel authViewModel;
//   StreamSubscription<User?>? _authStateSubscription;

//   AuthBloc(this.authViewModel) : super(const Unauthenticated()) {
//     // Listen to Firebase Auth state changes
//     _authStateSubscription = FirebaseAuth.instance.authStateChanges().listen((
//       User? user,
//     ) {
//       if (user == null && state is! Unauthenticated) {
//         // User is signed out, emit Unauthenticated state
//         add(CheckAuthStatusEvent());
//       } else if (user != null && state is! Authenticated) {
//         // User is signed in, emit Authenticated state
//         add(CheckAuthStatusEvent());
//       }
//     });

//     on<SignInEvent>((event, emit) async {
//       emit(const AuthLoading());
//       final success = await authViewModel.signIn(event.email, event.password);
//       if (success) {
//         emit(const Authenticated());
//       } else {
//         print('wow');
//         emit(AuthError(authViewModel.errorMessage ?? 'Sign-In failed'));

//         emit(const Unauthenticated());
//       }
//     });

//     on<SignUpEvent>((event, emit) async {
//       emit(const AuthLoading());
//       final success = await authViewModel.signUp(event.email, event.password);
//       if (success) {
//         emit(const Authenticated());
//       } else {
//         emit(AuthError(authViewModel.errorMessage ?? 'Sign-Up failed'));
//         emit(const Unauthenticated());
//       }
//     });

//     on<SignInWithGoogleEvent>((event, emit) async {
//       emit(const AuthLoading());
//       final success = await authViewModel.signInWithGoogle();
//       if (success) {
//         emit(const Authenticated());
//       } else {
//         emit(AuthError(authViewModel.errorMessage ?? 'Google Sign-In failed'));
//         emit(const Unauthenticated());
//       }
//     });

//     on<ResetPasswordEvent>((event, emit) async {
//       emit(const AuthLoading());
//       final success = await authViewModel.resetPassword(event.email);
//       if (success) {
//         emit(const ResetPasswordSuccess());
//       } else {
//         emit(AuthError(authViewModel.errorMessage ?? 'Reset password failed'));
//         emit(const Unauthenticated());
//       }
//     });

//     // on<LogoutEvent>((event, emit) async {
//     //   emit(const AuthLoading());
//     //   final success = await authViewModel.logout();
//     //   if (success) {
//     //     emit(const Unauthenticated());
//     //   } else {
//     //     emit(AuthError(authViewModel.errorMessage ?? 'Logout failed'));
//     //     // Even if logout "failed", we should still try to go to unauthenticated state
//     //     emit(const Unauthenticated());
//     //   }
//     // });
//     on<LogoutEvent>((event, emit) async {
//       emit(const AuthLoading());
//       final success = await authViewModel.logout();
//       if (success) {
//         emit(const Unauthenticated());
//       } else {
//         emit(AuthError(authViewModel.errorMessage ?? 'Logout failed'));
//         emit(const Unauthenticated()); // fallback to Unauthenticated anyway
//       }
//     });

//     on<ToggleAuthModeEvent>((event, emit) {
//       final newMode = !state.isSignUpMode;
//       emit(Unauthenticated(isSignUpMode: newMode));
//     });

//     // New event to check auth status
//     // on<CheckAuthStatusEvent>((event, emit) {
//     //   final user = authViewModel.getCurrentUser();
//     //   if (user != null) {
//     //     if (state is! Authenticated) {
//     //       emit(const Authenticated());
//     //     }
//     //   } else {
//     //     if (state is! Unauthenticated) {
//     //       emit(const Unauthenticated());
//     //     }
//     //   }
//     // });
//     on<CheckAuthStatusEvent>((event, emit) async {
//       final user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         await user.reload(); // <<< Force refresh
//         if (FirebaseAuth.instance.currentUser != null &&
//             state is! Authenticated) {
//           emit(const Authenticated());
//         }
//       } else {
//         if (state is! Unauthenticated) {
//           emit(const Unauthenticated());
//         }
//       }
//     });

//     on<TogglePasswordVisibilityEvent>((event, emit) {
//       if (state is Authenticated) {
//         emit(Authenticated(isPasswordVisible: !state.isPasswordVisible));
//       } else if (state is AuthLoading) {
//         emit(
//           AuthLoading(
//             isSignUpMode: state.isSignUpMode,
//             isPasswordVisible: !state.isPasswordVisible,
//           ),
//         );
//       } else if (state is AuthError) {
//         emit(
//           AuthError(
//             state.errorMessage!,
//             isSignUpMode: state.isSignUpMode,
//             isPasswordVisible: !state.isPasswordVisible,
//           ),
//         );
//       } else if (state is ResetPasswordSuccess) {
//         emit(
//           ResetPasswordSuccess(
//             isSignUpMode: state.isSignUpMode,
//             isPasswordVisible: !state.isPasswordVisible,
//           ),
//         );
//       } else {
//         emit(
//           Unauthenticated(
//             isSignUpMode: state.isSignUpMode,
//             isPasswordVisible: !state.isPasswordVisible,
//           ),
//         );
//       }
//     });
//   }

//   @override
//   Future<void> close() {
//     _authStateSubscription?.cancel();
//     return super.close();
//   }
// }


// -------------------------------------------------

// lib/bloc/auth/auth_bloc.dart

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vistacall/bloc/auth/auth_event.dart';
import 'package:vistacall/bloc/auth/auth_state.dart';
import 'package:vistacall/viewmodels/auth_viewmodel.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthViewModel _authViewModel;
  StreamSubscription<User?>? _authSubscription;

  AuthBloc({required AuthViewModel authViewModel})
      : _authViewModel = authViewModel,
        super(const AuthInitial()) {
    // Listen to auth state changes
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen(_onAuthChanged);

    // Event handlers
    on<AuthCheckStatus>(_onCheckStatus);
    on<AuthSignIn>(_onSignIn);
    on<AuthSignUp>(_onSignUp);
    on<AuthSignInWithGoogle>(_onSignInWithGoogle);
    on<AuthResetPassword>(_onResetPassword);
    on<AuthToggleMode>(_onToggleMode);
    on<AuthTogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<AuthLogout>(_onLogout);
  }

  void _onAuthChanged(User? user) {
    if (user != null && !user.isAnonymous) {
      add(const AuthCheckStatus());
    }
  }

  Future<void> _onCheckStatus(
    AuthCheckStatus event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final user = _authViewModel.currentUser;
      if (user != null) {
        await user.reload();
        emit(Authenticated(user, isPasswordVisible: state.isPasswordVisible));
      } else {
        emit(Unauthenticated(
          isSignUpMode: state.isSignUpMode,
          isPasswordVisible: state.isPasswordVisible,
        ));
      }
    } catch (e) {
      emit(AuthError(
        'Failed to check auth status',
        isSignUpMode: state.isSignUpMode,
        isPasswordVisible: state.isPasswordVisible,
      ));
    }
  }

  Future<void> _onSignIn(
    AuthSignIn event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading(
      isSignUpMode: state.isSignUpMode,
      isPasswordVisible: state.isPasswordVisible,
    ));

    try {
      final user = await _authViewModel.signIn(event.email, event.password);
      if (user != null) {
        emit(Authenticated(user, isPasswordVisible: state.isPasswordVisible));
      } else {
        emit(const Unauthenticated());
      }
    } on AuthException catch (e) {
      emit(AuthError(
        e.message,
        isSignUpMode: state.isSignUpMode,
        isPasswordVisible: state.isPasswordVisible,
      ));
    }
  }

  Future<void> _onSignUp(
    AuthSignUp event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading(
      isSignUpMode: state.isSignUpMode,
      isPasswordVisible: state.isPasswordVisible,
    ));

    try {
      final user = await _authViewModel.signUp(event.email, event.password);
      if (user != null) {
        emit(Authenticated(user, isPasswordVisible: state.isPasswordVisible));
      } else {
        emit(const Unauthenticated());
      }
    } on AuthException catch (e) {
      emit(AuthError(
        e.message,
        isSignUpMode: state.isSignUpMode,
        isPasswordVisible: state.isPasswordVisible,
      ));
    }
  }

  Future<void> _onSignInWithGoogle(
    AuthSignInWithGoogle event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading(
      isSignUpMode: state.isSignUpMode,
      isPasswordVisible: state.isPasswordVisible,
    ));

    try {
      final user = await _authViewModel.signInWithGoogle();
      if (user != null) {
        emit(Authenticated(user, isPasswordVisible: state.isPasswordVisible));
      } else {
        emit(const Unauthenticated());
      }
    } on AuthException catch (e) {
      emit(AuthError(
        e.message,
        isSignUpMode: state.isSignUpMode,
        isPasswordVisible: state.isPasswordVisible,
      ));
    }
  }

  Future<void> _onResetPassword(
    AuthResetPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading(
      isSignUpMode: state.isSignUpMode,
      isPasswordVisible: state.isPasswordVisible,
    ));

    try {
      await _authViewModel.resetPassword(event.email);
      emit(ResetPasswordSent(
        isSignUpMode: state.isSignUpMode,
        isPasswordVisible: state.isPasswordVisible,
      ));
    } on AuthException catch (e) {
      emit(AuthError(
        e.message,
        isSignUpMode: state.isSignUpMode,
        isPasswordVisible: state.isPasswordVisible,
      ));
    }
  }

  void _onToggleMode(
    AuthToggleMode event,
    Emitter<AuthState> emit,
  ) {
    emit(Unauthenticated(
      isSignUpMode: !state.isSignUpMode,
      isPasswordVisible: state.isPasswordVisible,
    ));
  }

  void _onTogglePasswordVisibility(
    AuthTogglePasswordVisibility event,
    Emitter<AuthState> emit,
  ) {
    if (state is Authenticated) {
      emit(Authenticated(
        state.user!,
        isPasswordVisible: !state.isPasswordVisible,
      ));
    } else {
      emit(Unauthenticated(
        isSignUpMode: state.isSignUpMode,
        isPasswordVisible: !state.isPasswordVisible,
      ));
    }
  }

  Future<void> _onLogout(
    AuthLogout event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading(
      isSignUpMode: state.isSignUpMode,
      isPasswordVisible: state.isPasswordVisible,
    ));

    try {
      await _authViewModel.logout();
      emit(const Unauthenticated());
    } on AuthException catch (e) {
      emit(AuthError(
        e.message,
        isSignUpMode: state.isSignUpMode,
        isPasswordVisible: state.isPasswordVisible,
      ));
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
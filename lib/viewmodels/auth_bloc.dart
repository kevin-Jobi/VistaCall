// import 'package:bloc/bloc.dart';
// import 'package:vistacall/viewmodels/auth_viewmodel.dart';
// import 'auth_event.dart';
// import 'auth_state.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final AuthViewmodel authViewModel;

//   AuthBloc(this.authViewModel) : super(AuthState()) {
//     on<SignInEvent>((event, emit) async {
//       emit(state.copyWith(isLoading: true, errorMessage: null));
//       final success = await authViewModel.signIn(event.email, event.password);
//       if (success) {
//         emit(state.copyWith(isLoading: false));
//       } else {
//         emit(
//           state.copyWith(
//             isLoading: false,
//             errorMessage: authViewModel.errorMessage ?? 'Sign-In failed',
//           ),
//         );
//       }
//     });

//     on<SignUpEvent>((event, emit) async {
//       emit(state.copyWith(isLoading: true, errorMessage: null));
//       final success = await authViewModel.signUp(event.email, event.password);
//       if (success) {
//         emit(state.copyWith(isLoading: false));
//       } else {
//         emit(
//           state.copyWith(
//             isLoading: false,
//             errorMessage: authViewModel.errorMessage ?? 'Sign-Up failed',
//           ),
//         );
//       }
//     });

//     on<SignInWithGoogleEvent>((event, emit) async {
//       emit(state.copyWith(isLoading: true, errorMessage: null));
//       final success = await authViewModel.signInWithGoogle();
//       if (success) {
//         emit(state.copyWith(isLoading: false));
//       } else {
//         emit(
//           state.copyWith(
//             isLoading: false,
//             errorMessage: authViewModel.errorMessage ?? 'Google Sign-In failed',
//           ),
//         );
//       }
//     });

//     on<ResetPasswordEvent>((event, emit) async {
//       emit(
//         state.copyWith(
//           isLoading: true,
//           errorMessage: null,
//           resetPasswordSuccess: false,
//         ),
//       );
//       final success = await authViewModel.resetPassword(event.email);
//       if (success) {
//         emit(state.copyWith(isLoading: false, resetPasswordSuccess: true));
//       } else {
//         emit(
//           state.copyWith(
//             isLoading: false,
//             errorMessage:
//                 authViewModel.errorMessage ?? 'Failed to send reset email',
//           ),
//         );
//       }
//     });

//     // In AuthBloc, add this handler:
//     on<LogoutEvent>((event, emit) async {
//       emit(state.copyWith(isLoading: true, errorMessage: null));
//       final success = await authViewModel.logout();
//       if (success) {
//         emit(AuthState.initial()); // Reset to initial state
//       } else {
//         emit(
//           state.copyWith(
//             isLoading: false,
//             errorMessage: authViewModel.errorMessage ?? 'Logout failed',
//           ),
//         );
//       }
//     });

//     on<ToggleAuthModeEvent>((event, emit) {
//       emit(
//         state.copyWith(isSignUpMode: !state.isSignUpMode, errorMessage: null),
//       );
//     });
//   }
// }
//---------------------------------------------------------
// import 'package:bloc/bloc.dart';
// import 'package:vistacall/viewmodels/auth_viewmodel.dart';
// import 'auth_event.dart';
// import 'auth_state.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final AuthViewmodel authViewModel;

//   AuthBloc(this.authViewModel) : super(const Unauthenticated()) {
//     on<SignInEvent>((event, emit) async {
//       emit(const AuthLoading());

//       final success = await authViewModel.signIn(event.email, event.password);

//       if (success) {
//         emit(const Authenticated());
//       } else {
//         emit(AuthError(authViewModel.errorMessage ?? 'Sign-In failed'));
//         emit(const Unauthenticated()); // Optional fallback
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

//     on<LogoutEvent>((event, emit) async {
//       emit(const AuthLoading());

//       final success = await authViewModel.logout();

//       if (success) {
//         emit(const Unauthenticated());
//       } else {
//         emit(AuthError(authViewModel.errorMessage ?? 'Logout failed'));
//       }
//     });

//     on<ToggleAuthModeEvent>((event, emit) {
//       final newMode = !state.isSignUpMode;
//       emit(Unauthenticated(isSignUpMode: newMode));
//     });
//   }
// }
//-----------------------------------------------
//may 22

// import 'package:bloc/bloc.dart';
// import 'package:vistacall/viewmodels/auth_viewmodel.dart';
// import 'auth_event.dart';
// import 'auth_state.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final AuthViewmodel authViewModel;
//   AuthBloc(this.authViewModel) : super(const Unauthenticated()) {
//     on<SignInEvent>((event, emit) async {
//       emit(const AuthLoading());

//       final success = await authViewModel.signIn(event.email, event.password);

//       if (success) {
//         emit(const Authenticated());
//       } else {
//         emit(AuthError(authViewModel.errorMessage ?? 'Sign-In failed'));
//         emit(const Unauthenticated()); // Optional fallback
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

//     on<LogoutEvent>((event, emit) async {
//       emit(const AuthLoading());

//       final success = await authViewModel.logout();

//       if (success) {
//         emit(const Unauthenticated());
//       } else {
//         emit(AuthError(authViewModel.errorMessage ?? 'Logout failed'));
//       }
//     });

//     on<ToggleAuthModeEvent>((event, emit) {
//       final newMode = !state.isSignUpMode;
//       emit(Unauthenticated(isSignUpMode: newMode));
//     });
//   }
// }
//=======================================================================
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/viewmodels/auth_event.dart';
import 'package:vistacall/viewmodels/auth_state.dart';
import 'package:vistacall/viewmodels/auth_viewmodel.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthViewmodel authViewModel;
  StreamSubscription<User?>? _authStateSubscription;

  AuthBloc(this.authViewModel) : super(const Unauthenticated()) {
    // Listen to Firebase Auth state changes
    _authStateSubscription = FirebaseAuth.instance.authStateChanges().listen((
      User? user,
    ) {
      if (user == null && state is! Unauthenticated) {
        // User is signed out, emit Unauthenticated state
        add(CheckAuthStatusEvent());
      } else if (user != null && state is! Authenticated) {
        // User is signed in, emit Authenticated state
        add(CheckAuthStatusEvent());
      }
    });

    on<SignInEvent>((event, emit) async {
      emit(const AuthLoading());
      final success = await authViewModel.signIn(event.email, event.password);
      if (success) {
        emit(const Authenticated());
      } else {
        print('wow');
        emit(AuthError(authViewModel.errorMessage ?? 'Sign-In failed'));

        emit(const Unauthenticated());
      }
    });

    on<SignUpEvent>((event, emit) async {
      emit(const AuthLoading());
      final success = await authViewModel.signUp(event.email, event.password);
      if (success) {
        emit(const Authenticated());
      } else {
        emit(AuthError(authViewModel.errorMessage ?? 'Sign-Up failed'));
        emit(const Unauthenticated());
      }
    });

    on<SignInWithGoogleEvent>((event, emit) async {
      emit(const AuthLoading());
      final success = await authViewModel.signInWithGoogle();
      if (success) {
        emit(const Authenticated());
      } else {
        emit(AuthError(authViewModel.errorMessage ?? 'Google Sign-In failed'));
        emit(const Unauthenticated());
      }
    });

    on<ResetPasswordEvent>((event, emit) async {
      emit(const AuthLoading());
      final success = await authViewModel.resetPassword(event.email);
      if (success) {
        emit(const ResetPasswordSuccess());
      } else {
        emit(AuthError(authViewModel.errorMessage ?? 'Reset password failed'));
        emit(const Unauthenticated());
      }
    });

    // on<LogoutEvent>((event, emit) async {
    //   emit(const AuthLoading());
    //   final success = await authViewModel.logout();
    //   if (success) {
    //     emit(const Unauthenticated());
    //   } else {
    //     emit(AuthError(authViewModel.errorMessage ?? 'Logout failed'));
    //     // Even if logout "failed", we should still try to go to unauthenticated state
    //     emit(const Unauthenticated());
    //   }
    // });
    on<LogoutEvent>((event, emit) async {
      emit(const AuthLoading());
      final success = await authViewModel.logout();
      if (success) {
        emit(const Unauthenticated());
      } else {
        emit(AuthError(authViewModel.errorMessage ?? 'Logout failed'));
        emit(const Unauthenticated()); // fallback to Unauthenticated anyway
      }
    });

    on<ToggleAuthModeEvent>((event, emit) {
      final newMode = !state.isSignUpMode;
      emit(Unauthenticated(isSignUpMode: newMode));
    });

    // New event to check auth status
    // on<CheckAuthStatusEvent>((event, emit) {
    //   final user = authViewModel.getCurrentUser();
    //   if (user != null) {
    //     if (state is! Authenticated) {
    //       emit(const Authenticated());
    //     }
    //   } else {
    //     if (state is! Unauthenticated) {
    //       emit(const Unauthenticated());
    //     }
    //   }
    // });
    on<CheckAuthStatusEvent>((event, emit) async {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.reload(); // <<< Force refresh
        if (FirebaseAuth.instance.currentUser != null &&
            state is! Authenticated) {
          emit(const Authenticated());
        }
      } else {
        if (state is! Unauthenticated) {
          emit(const Unauthenticated());
        }
      }
    });
  }

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    return super.close();
  }
}

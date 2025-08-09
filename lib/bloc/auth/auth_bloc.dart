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
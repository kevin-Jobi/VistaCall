import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthViewModel {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthViewModel({
    FirebaseAuth? auth,
    GoogleSignIn? googleSignIn,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  // Getters for current auth state
  User? get currentUser => _auth.currentUser;
  bool get isSignedIn => _auth.currentUser != null;

  /// Email/Password Sign Up
  Future<User?> signUp(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw AuthException('An unexpected error occurred', e.toString());
    }
  }

  /// Email/Password Sign In
  Future<User?> signIn(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw AuthException('An unexpected error occurred', e.toString());
    }
  }

  /// Google Sign In
  Future<User?> signInWithGoogle() async {
    try {
      // Ensure previous session is cleared
      await _googleSignIn.signOut();

      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      throw AuthException('Google Sign-In failed', e.toString());
    }
  }

  /// Password Reset
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw AuthException('Password reset failed', e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
        _googleSignIn.disconnect(),
      ]);
    } catch (e, stackTrace) {
      print('Logout error: $e\n$stackTrace');
      throw AuthException('Logout failed', e.toString());
    }
  }

  /// Helper to handle Firebase auth exceptions
  AuthException _handleFirebaseAuthException(FirebaseAuthException e) {
    String message;

    switch (e.code) {
      case 'invalid-email':
        message = 'Please enter a valid email address';
        break;
      case 'weak-password':
        message = 'Password should be at least 6 characters';
        break;
      case 'email-already-in-use':
        message = 'Email is already registered';
        break;
      case 'user-not-found':
        message = 'No user found with this email';
        break;
      case 'wrong-password':
        message = 'Incorrect password';
        break;
      case 'invalid-credential':
        message = 'Invalid email or password';
        break;
      default:
        message = 'Authentication failed: ${e.message}';
    }

    return AuthException(message, e.code);
  }
}

/// Custom exception class for auth errors
class AuthException implements Exception {
  final String message;
  final String code;

  AuthException(this.message, this.code);

  @override
  String toString() => message;
}

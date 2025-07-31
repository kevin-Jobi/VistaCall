
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:vistacall/bloc/auth/auth_bloc.dart';
// import 'package:vistacall/bloc/auth/auth_state.dart';

// class AuthViewmodel {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   String? _errorMessage;
//   bool _isLoading = false;
//   final AuthBloc _authBloc;

//   AuthViewmodel(this._authBloc);

//   String? get errorMessage => _errorMessage;
//   bool get isLoading => _isLoading;



//   Future<bool> signUp(String email, String password) async {
//     _authBloc.add(AuthLoadingEvent());
//     try {
//       _isLoading = true;
//       _errorMessage = null; // Clear previous errors
//       UserCredential userCredential = await _auth
//           .createUserWithEmailAndPassword(email: email, password: password);
//       _isLoading = false;
//       return userCredential.user != null;
//     } on FirebaseAuthException catch (e) {
//       _isLoading = false;
//       switch (e.code) {
//         case 'invalid-email':
//           _errorMessage = 'Please enter a valid email address.';
//           break;
//         case 'weak-password':
//           _errorMessage = 'Password should be at least 6 characters.';
//           break;
//         case 'email-already-in-use':
//           _errorMessage = 'Email is already registered.';
//           break;
//         default:
//           _errorMessage = 'Sign-Up failed. ${e.message}';
//       }
//       return false;
//     } catch (e) {
//       _isLoading = false;
//       _errorMessage = 'An unexpected error occurred. Please try again.';
//       return false;
//     }
//   }



//   Future<bool> signIn(String email, String password) async {
//     try {
//       _isLoading = true;
//       _errorMessage = null;
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       _isLoading = false;
//       return userCredential.user != null;
//     } on FirebaseAuthException catch (e) {
//       _isLoading = false;
//       switch (e.code) {
//         case 'invalid-email':
//           _errorMessage = 'Please enter a valid email address.';
//           break;
//         case 'user-not-found':
//           _errorMessage = 'No user found with this email.';
//           break;
//         case 'wrong-password':
//           _errorMessage = 'Incorrect password.';
//           break;
//         case 'invalid-credential':
//           _errorMessage = 'Invalid email or password. Please try again.';
//           break;

//         default:
//           _errorMessage = 'Sign-In failed. ${e.message}';
//       }
//       return false;
//     } catch (e) {
//       _isLoading = false;
//       _errorMessage = 'An unexpected error occurred.';
//       return false;
//     }
//   }

//   // Sign In with Google
//   Future<bool> signInWithGoogle() async {
//     try {
//       _isLoading = true;
//       _errorMessage = null; // Clear previous errors

//       // First, ensure we're signed out from Google
//       await _googleSignIn.signOut();

//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) {
//         _isLoading = false;
//         return false; // User canceled the sign-in
//       }

//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       UserCredential userCredential = await _auth.signInWithCredential(
//         credential,
//       );

//       _isLoading = false;
//       if (userCredential.user != null) {
//         return true;
//       }
//       return false;
//     } catch (e) {
//       _isLoading = false;
//       _errorMessage = e.toString();
//       print('Google Sign-In Error: $e');
//       return false;
//     }
//   }

//   // Reset Password
//   Future<bool> resetPassword(String email) async {
//     try {
//       _errorMessage = null; // Clear previous errors
//       await _auth.sendPasswordResetEmail(email: email);
//       return true;
//     } catch (e) {
//       _errorMessage = e.toString();
//       print(e.toString());
//       return false;
//     }
//   }

//   Future<bool> logout() async {
//     try {
//       _errorMessage = null;

//       // Step 1: Sign out from Firebase first
//       await _auth.signOut();

//       // Step 2: Handle Google Sign-In logout
//       try {
//         if (await _googleSignIn.isSignedIn()) {
//           await _googleSignIn.signOut();

//           try {
//             await _googleSignIn.disconnect();
//           } catch (disconnectError) {}
//         }
//       } catch (googleError) {}

//       // Step 3: Clear any cached credentials (IMPORTANT!)
//       try {
//         // Clear Google Sign-In cache to prevent auto-login
//         await _googleSignIn.signOut(); // Call again to ensure clean state

//         // Optional: Clear any other auth-related caches
//         // SharedPreferences prefs = await SharedPreferences.getInstance();
//         // await prefs.clear(); // Only if you store auth data in SharedPreferences
//       } catch (clearError) {}

//       return true;
//     } catch (e) {
//       _errorMessage = 'Logout failed: $e';

//       return false;
//     }
//   }


//   // Helper method to check current auth state
//   User? getCurrentUser() {
//     return _auth.currentUser;
//   }

//   // Helper method to check if user is signed in
//   bool isSignedIn() {
//     return _auth.currentUser != null;
//   }
// }



// -------------------------------------------------------------------------------------------------------------------------------------------------

  // Future<bool> logout() async {
  //   try {
  //     print('=== LOGOUT DEBUG START ===');
  //     print('Current Firebase user before logout: ${_auth.currentUser?.email}');
  //     print(
  //       'Google signed in before logout: ${await _googleSignIn.isSignedIn()}',
  //     );

  //     _errorMessage = null;

  //     // Step 1: Sign out from Firebase first
  //     await _auth.signOut();
  //     print('Firebase sign out completed');

  //     // Step 2: Handle Google Sign-In logout more carefully
  //     try {
  //       if (await _googleSignIn.isSignedIn()) {
  //         // Try signOut first (this is usually more reliable than disconnect)
  //         await _googleSignIn.signOut();
  //         print('Google signOut completed');

  //         // Only try disconnect if signOut was successful and we're still connected
  //         try {
  //           await _googleSignIn.disconnect();
  //           print('Google disconnect completed');
  //         } catch (disconnectError) {
  //           print('Google disconnect failed (non-critical): $disconnectError');
  //           // This is often expected and doesn't affect the logout process
  //         }
  //       }
  //     } catch (googleError) {
  //       print('Google sign out error (non-critical): $googleError');
  //       // Don't fail the entire logout process if Google sign out fails
  //       // Firebase logout is more important
  //     }

  //     print('Current Firebase user after logout: ${_auth.currentUser}');
  //     print(
  //       'Google signed in after logout: ${await _googleSignIn.isSignedIn()}',
  //     );
  //     print('=== LOGOUT DEBUG END ===');

  //     return true;
  //   } catch (e) {
  //     _errorMessage = 'Logout failed: $e';
  //     print('Critical logout error: $e');
  //     return false;
  //   }
  // }

  // Fixed logout method
  // Future<bool> logout() async {
  //   try {
  //     _errorMessage = null; // Clear previous errors

  //     // Sign out from Firebase Auth first
  //     await _auth.signOut();

  //     // Then sign out from Google (if signed in)
  //     try {
  //       if (await _googleSignIn.isSignedIn()) {
  //         await _googleSignIn.disconnect();
  //         await _googleSignIn.signOut();
  //       }
  //     } catch (googleSignOutError) {
  //       print('Google sign out error (non-critical): $googleSignOutError');
  //       // Don't fail the entire logout process if Google sign out fails
  //     }

  //     return true;
  //   } catch (e) {
  //     _errorMessage = e.toString();
  //     print('Logout error: $e');
  //     return false;
  //   }
  // }



  // ----------------------------------------------------------------------




  // lib/viewmodels/auth_viewmodel.dart

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

  /// Logout
  // Future<void> logout() async {
  //   try {
  //     await Future.wait([
  //       _auth.signOut(),
  //       _googleSignIn.signOut(),
  //       _googleSignIn.disconnect(),
  //     ]);
  //   } catch (e) {
  //     throw AuthException('Logout failed', e.toString());
  //   }
  // }

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
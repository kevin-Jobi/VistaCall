// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class AuthViewmodel {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();

//   String? _errorMessage;
//   bool _isLoading = false;

//   String? get errorMessage => _errorMessage;
//   bool get isLoading => _isLoading;

//   // Sing Up with Email and Password
//   Future<bool> signUp(String email, String password) async {
//     try {
//       _isLoading = true;
//       UserCredential userCredential = await _auth
//           .createUserWithEmailAndPassword(email: email, password: password);
//       _isLoading = false;
//       if (userCredential.user != null) {
//         return true;
//       }
//       return false;
//     } catch (e) {
//       _isLoading = false;
//       _errorMessage = e.toString();
//       return false;
//     }
//   }

//   // Sign In with Email and Password
//   Future<bool> signIn(String email, String password) async {
//     try {
//       _isLoading = true;
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       _isLoading = false;
//       if (userCredential.user != null) {
//         return true;
//       }
//       return false;
//     } catch (e) {
//       _isLoading = false;
//       _errorMessage = e.toString();
//       return false;
//     }
//   }

//   // Sign In with Google
//   Future<bool> signInWithGoogle() async {
//     try {
//       _isLoading = true;
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
//       return false;
//     }
//   }

//   // Reset Password
//   Future<bool> resetPassword(String email) async {
//     try {
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
//       await _googleSignIn.signOut();
//       await _auth.signOut();
//       await _googleSignIn.disconnect(); // Clears the session completely

//       return true;
//     } catch (e) {
//       _errorMessage = e.toString();
//       return false;
//     }
//   }
// }
// //----------------------------------------------------------------------
//   // Logout
//   // Future<bool> logout() async {
//   //   try {
//   //     await _googleSignIn.signOut(); // Sign out from Google if used
//   //     await _auth.signOut(); // Sign out from Firebase
//   //     return true;
//   //   } catch (e) {
//   //     _errorMessage = e.toString();
//   //     return false;
//   //   }
//   // }

// // class AuthViewmodel {
// //   String? errorMessage;

// //   Future<bool> signIn(String email, String password) async {
// //     // Mock implementation; replace with actual Firebase Auth
// //     try {
// //       await Future.delayed(const Duration(seconds: 1));
// //       if (email.isNotEmpty && password.isNotEmpty) {
// //         return true;
// //       } else {
// //         errorMessage = 'Please enter valid credentials';
// //         return false;
// //       }
// //     } catch (e) {
// //       errorMessage = e.toString();
// //       return false;
// //     }
// //   }

// //   Future<bool> signUp(String email, String password) async {
// //     // Mock implementation; replace with actual Firebase Auth
// //     try {
// //       await Future.delayed(const Duration(seconds: 1));
// //       if (email.isNotEmpty && password.isNotEmpty) {
// //         return true;
// //       } else {
// //         errorMessage = 'Please enter valid credentials';
// //         return false;
// //       }
// //     } catch (e) {
// //       errorMessage = e.toString();
// //       return false;
// //     }
// //   }

// //   Future<bool> signInWithGoogle() async {
// //     // Mock implementation; replace with actual Google Sign-In
// //     try {
// //       await Future.delayed(const Duration(seconds: 1));
// //       return true;
// //     } catch (e) {
// //       errorMessage = e.toString();
// //       return false;
// //     }
// //   }

// //   Future<bool> resetPassword(String email) async {
// //     // Mock implementation; replace with actual Firebase Auth
// //     try {
// //       await Future.delayed(const Duration(seconds: 1));
// //       if (email.isNotEmpty) {
// //         return true;
// //       } else {
// //         errorMessage = 'Please enter a valid email';
// //         return false;
// //       }
// //     } catch (e) {
// //       errorMessage = e.toString();
// //       return false;
// //     }
// //   }
// // }
//-----------------------------------------------------------------
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthViewmodel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String? _errorMessage;
  bool _isLoading = false;

  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;



  Future<bool> signUp(String email, String password) async {
    try {
      _isLoading = true;
      _errorMessage = null; // Clear previous errors
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      _isLoading = false;
      return userCredential.user != null;
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      switch (e.code) {
        case 'invalid-email':
          _errorMessage = 'Please enter a valid email address.';
          break;
        case 'weak-password':
          _errorMessage = 'Password should be at least 6 characters.';
          break;
        case 'email-already-in-use':
          _errorMessage = 'Email is already registered.';
          break;
        default:
          _errorMessage = 'Sign-Up failed. ${e.message}';
      }
      return false;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'An unexpected error occurred. Please try again.';
      return false;
    }
  }



  Future<bool> signIn(String email, String password) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _isLoading = false;
      return userCredential.user != null;
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      switch (e.code) {
        case 'invalid-email':
          _errorMessage = 'Please enter a valid email address.';
          break;
        case 'user-not-found':
          _errorMessage = 'No user found with this email.';
          break;
        case 'wrong-password':
          _errorMessage = 'Incorrect password.';
          break;
        case 'invalid-credential':
          _errorMessage = 'Invalid email or password. Please try again.';
          break;

        default:
          _errorMessage = 'Sign-In failed. ${e.message}';
      }
      return false;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'An unexpected error occurred.';
      return false;
    }
  }

  // Sign In with Google
  Future<bool> signInWithGoogle() async {
    try {
      _isLoading = true;
      _errorMessage = null; // Clear previous errors

      // First, ensure we're signed out from Google
      await _googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        _isLoading = false;
        return false; // User canceled the sign-in
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      _isLoading = false;
      if (userCredential.user != null) {
        return true;
      }
      return false;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      print('Google Sign-In Error: $e');
      return false;
    }
  }

  // Reset Password
  Future<bool> resetPassword(String email) async {
    try {
      _errorMessage = null; // Clear previous errors
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      print(e.toString());
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      _errorMessage = null;

      // Step 1: Sign out from Firebase first
      await _auth.signOut();

      // Step 2: Handle Google Sign-In logout
      try {
        if (await _googleSignIn.isSignedIn()) {
          await _googleSignIn.signOut();

          try {
            await _googleSignIn.disconnect();
          } catch (disconnectError) {}
        }
      } catch (googleError) {}

      // Step 3: Clear any cached credentials (IMPORTANT!)
      try {
        // Clear Google Sign-In cache to prevent auto-login
        await _googleSignIn.signOut(); // Call again to ensure clean state

        // Optional: Clear any other auth-related caches
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // await prefs.clear(); // Only if you store auth data in SharedPreferences
      } catch (clearError) {}

      return true;
    } catch (e) {
      _errorMessage = 'Logout failed: $e';

      return false;
    }
  }


  // Helper method to check current auth state
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Helper method to check if user is signed in
  bool isSignedIn() {
    return _auth.currentUser != null;
  }
}



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
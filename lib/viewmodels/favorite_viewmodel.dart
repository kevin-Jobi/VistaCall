import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vistacall/data/models/doctor.dart';

class FavoriteViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isFavorite = false;
  String? _error;

  bool get isFavorite => _isFavorite;
  String? get error => _error;

  FavoriteViewModel(DoctorModel doctor, {required String doctorId}) {
    _checkFavoriteStatus(doctorId);
  }

  void _checkFavoriteStatus(String doctorId) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        _error = 'No user logged in';
        notifyListeners();
        return;
      }

      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        final favorites =
            userDoc.data()?['favoriteDoctors'] as List<dynamic>? ?? [];
        // final id = doctorId ?? doctor.personal['id'] as String? ?? '';
        // if (id.isEmpty) {
        //   _error = 'Doctor ID not found';
        //   notifyListeners();
        //   return;
        // }
        _isFavorite = favorites.contains(doctorId);
      } else {
        _error = 'User document not found';
      }
      notifyListeners();
    } catch (e) {
      _error = 'Error checking favorite status: $e';
      notifyListeners();
    }
  }

  void toggleFavorite(DoctorModel doctor, {required String doctorId}) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        _error = 'No user logged in';
        notifyListeners();
        return;
      }

      final userDocRef = _firestore.collection('users').doc(user.uid);
      final userDoc = await userDocRef.get();
      final favorites =
          userDoc.data()?['favoriteDoctors'] as List<dynamic>? ?? [];

      // final id = doctorId ?? doctor.personal['id'] as String? ?? '';
      // if (id.isEmpty) {
      //   _error = 'Doctor ID not found';
      //   notifyListeners();
      //   return;
      // }

      if (_isFavorite) {
        await userDocRef.update({
          'favoriteDoctors': FieldValue.arrayRemove([doctorId]),
        });
      } else {
        await userDocRef.update({
          'favoriteDoctors': FieldValue.arrayUnion([doctorId]),
        });
      }
      _isFavorite = !_isFavorite;
      _error = null;
      notifyListeners();
    } catch (e) {
      _error = 'Error toggling favorite: $e';
      notifyListeners();
    }
  }
}

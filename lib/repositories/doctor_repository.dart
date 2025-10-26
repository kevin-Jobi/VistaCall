import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vistacall/data/models/doctor.dart';

class DoctorRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<DoctorModel>> fetchFavoriteDoctors() async{
    final user = _auth.currentUser;
    if(user == null) throw Exception('No user logged in');

    final userDoc = await _firestore.collection('users').doc(user.uid).get();
    final favoriteIds = List<String>.from(userDoc.data()?['favoriteDoctors']??[]);

    if(favoriteIds.isEmpty) return [];

    final querySnapshot = await _firestore.collection('doctors').where(FieldPath.documentId,whereIn: favoriteIds).get();

    return querySnapshot.docs.map((doc)=>DoctorModel.fromFirestore(doc)).toList();
  }
}
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vistacall/bloc/favorite/favorite_event.dart';
import 'package:vistacall/bloc/favorite/favorite_state.dart';
import 'package:vistacall/data/models/doctor.dart';

class FavoriteDoctorsBloc
    extends Bloc<FavoriteDoctorsEvent, FavoriteDoctorsState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FavoriteDoctorsBloc() : super(FavoriteDoctorsInitial()) {
    on<LoadFavoriteDoctors>(_onLoadFavoriteDoctors);
  }

  Future<void> _onLoadFavoriteDoctors(
    LoadFavoriteDoctors event,
    Emitter<FavoriteDoctorsState> emit,
  ) async {
    emit(FavoriteDoctorsLoading());
    try {
      final user = _auth.currentUser;
      if (user == null) {
        emit(FavoriteDoctorsError("No user logged in"));
        return;
      }

      // Fetch user document
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      final favorites =
          List<String>.from(userDoc.data()?['favoriteDoctors'] ?? []);

      if (favorites.isEmpty) {
        emit(FavoriteDoctorsLoaded([]));
        return;
      }

      // Fetch actual doctor details
      final doctors = <DoctorModel>[];
      for (final doctorId in favorites) {
        final docSnapshot =
            await _firestore.collection('doctors').doc(doctorId).get();
        if (docSnapshot.exists) {
          doctors.add(DoctorModel.fromFirestore(docSnapshot));
        }
      }

      emit(FavoriteDoctorsLoaded(doctors));
    } catch (e) {
      emit(FavoriteDoctorsError("Failed to load favorites: $e"));
    }
  }
}

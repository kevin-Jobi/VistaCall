import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'patient_event.dart';
part 'patient_state.dart';

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  PatientBloc() : super(PatientInitial()) {
    on<AddPatient>(_onAddPatient);
    on<LoadPatients>(_onLoadPatients);
  }

  Future<void> _onAddPatient(AddPatient event, Emitter<PatientState> emit) async {
    try {
      emit(PatientLoading());
      final user = _auth.currentUser;
      if (user == null) {
        emit(const PatientError('User not authenticated'));
        return;
      }

      final patientRef = _firestore
          .collection('users')
          .doc(user.uid)
          .collection('patients')
          .doc(); // Auto-generate ID
      await patientRef.set({
        'firstName': event.patient['firstName']!,
        'lastName': event.patient['lastName']!,
        'age': event.patient['age']!,
        'gender': event.patient['gender']!,
        'relation': event.patient['relation']!,
        'email': event.patient['email']!,
        'createdAt': FieldValue.serverTimestamp(),
      });

      add(LoadPatients()); // Reload patients after adding
    } catch (e) {
      emit(PatientError('Failed to add patient: $e'));
    }
  }

  Future<void> _onLoadPatients(
      LoadPatients event, Emitter<PatientState> emit) async {
    try {
      emit(PatientLoading());
      final user = _auth.currentUser;
      if (user == null) {
        emit(const PatientError('User not authenticated'));
        return;
      }

      final patientSnapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('patients')
          .orderBy('createdAt', descending: true)
          .get();
      final patients = patientSnapshot.docs
          .map((doc) => {
                'firstName': doc['firstName'] as String? ?? '',
                'lastName': doc['lastName'] as String? ?? '',
                'age': doc['age'] as String? ?? 'N/A',
                'gender': doc['gender'] as String? ?? '',
                'relation': doc['relation'] as String? ?? '',
                'email': doc['email'] as String? ?? '',
              })
          .toList();

      emit(PatientLoaded(patients));
    } catch (e) {
      emit(PatientError('Failed to load patients: $e'));
    }
  }
}
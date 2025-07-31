// class Doctor {
//   final String name;
//   final String specialty;
//   final String department;

//   Doctor({
//     required this.name,
//     required this.specialty,
//     required this.department,
//   });
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel {
  final Map<String, dynamic> personal;
  final Map<String, dynamic> availability;
  final String certificateUrl;
  final String verificationStatus;

  DoctorModel({
    required this.personal,
    required this.availability,
    required this.certificateUrl,
    required this.verificationStatus,
  });

  factory DoctorModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DoctorModel(
      personal: data['personal'] as Map<String, dynamic>,
      availability: data['availability'] as Map<String, dynamic>,
      certificateUrl: data['certificateUrl'] as String,
      verificationStatus: data['verificationStatus'] as String,
    );
  }
}

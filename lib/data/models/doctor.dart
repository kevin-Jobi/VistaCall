// import 'package:cloud_firestore/cloud_firestore.dart';

// class DoctorModel {
//   String id;
//   final Map<String, dynamic> personal;
//   final Map<String, dynamic> availability;
//   final String certificateUrl;
//   final String verificationStatus;

//   DoctorModel({
//     required this.id,
//     required this.personal,
//     required this.availability,
//     required this.certificateUrl,
//     required this.verificationStatus,
//   });

//   factory DoctorModel.fromFirestore(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//     print('Parsing doctor: ${data['personal']['fullName']}'); // Debug log
//     final personalData = data['personal'] as Map<String, dynamic>? ?? {};
//     final fullName = personalData['fullName'];
//     print('Extracted fullName: $fullName'); // Log extracted name
//     return DoctorModel(
//       id: doc.id,
//       personal: data['personal'] as Map<String, dynamic>,
//       availability: data['availability'] as Map<String, dynamic>,
//       certificateUrl: data['certificateUrl'] as String,
//       verificationStatus: data['verificationStatus'] as String,
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class DoctorModel extends Equatable {
  final String id;
  final Map<String, dynamic> personal;
  final Map<String, dynamic> availability;
  final String verificationStatus;
  final double averageRating; // New field
  final int numRatings; // New field

  DoctorModel({
    required this.id,
    required this.personal,
    required this.availability,
    required this.verificationStatus,
    required this.averageRating,
    required this.numRatings,
  });

  factory DoctorModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    return DoctorModel(
      id: doc.id,
      personal: data?['personal'] as Map<String, dynamic>? ?? {},
      availability: data?['availability'] as Map<String, dynamic>? ?? {},
      verificationStatus: data?['verificationStatus'] ?? 'pending',
      averageRating: data?['averageRating']?.toDouble() ?? 0.0,
      numRatings: data?['numRatings'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [
        id,
        personal,
        availability,
        verificationStatus,
        averageRating,
        numRatings,
      ];
}
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel {
  String id;
  final Map<String, dynamic> personal;
  final Map<String, dynamic> availability;
  final String certificateUrl;
  final String verificationStatus;

  DoctorModel({
    required this.id,
    required this.personal,
    required this.availability,
    required this.certificateUrl,
    required this.verificationStatus,
  });

  factory DoctorModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    print('Parsing doctor: ${data['personal']['fullName']}'); // Debug log
    final personalData = data['personal'] as Map<String, dynamic>? ?? {};
    final fullName = personalData['fullName'];
    print('Extracted fullName: $fullName'); // Log extracted name
    return DoctorModel(
      id: doc.id,
      personal: data['personal'] as Map<String, dynamic>,
      availability: data['availability'] as Map<String, dynamic>,
      certificateUrl: data['certificateUrl'] as String,
      verificationStatus: data['verificationStatus'] as String,
    );
  }
}

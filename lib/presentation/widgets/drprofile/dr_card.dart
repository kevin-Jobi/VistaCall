import 'package:flutter/material.dart';

class DrCard extends StatelessWidget {
  final dynamic doctor;
  const DrCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final imageUrl = doctor.personal?['profileImageUrl']?.toString(); //

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
            child: imageUrl == null
                ? const Icon(
                    Icons.person,
                    color: Colors.white,
                  )
                : null),
        title: Text(
          'Dr.${doctor.personal['fullName'] as String}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
            '${doctor.personal['department']} \n${doctor.availability['yearsOfExperience']} years \nFees: ${doctor.availability['fees']}\n${doctor.personal['hospitalName']}'),
      ),
    );
  }
}

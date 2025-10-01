// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:vistacall/firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   final db = FirebaseFirestore.instance;

//   // Dynamically generate nameToUidMap
//   final nameToUidMap = <String, String>{};
//   final usersSnapshot = await db.collection('users').get();
//   for (var userDoc in usersSnapshot.docs) {
//     final uid = userDoc.id;
//     final patientsSnapshot = await userDoc.reference.collection('patients').get();
//     for (var patientDoc in patientsSnapshot.docs) {
//       final patientData = patientDoc.data() as Map<String, dynamic>;
//       final firstName = patientData['firstName'] ?? '';
//       final lastName = patientData['lastName'] ?? '';
//       final fullName = '$firstName $lastName'.trim();
//       if (fullName.isNotEmpty) {
//         nameToUidMap[fullName] = uid;
//       }
//     }
//   }

//   // Manually add fallback mapping for "Kevin Jobi" if not found
//   if (!nameToUidMap.containsKey('Kevin Jobi')) {
//     nameToUidMap['Kevin Jobi'] = 'uyCT12WyIJXZHlKpC1A10KdCdHi1';
//   }
//   print('Generated nameToUidMap: $nameToUidMap'); // Debug the map

//   // Proceed with migration
//   final chatsSnapshot = await db.collection('chats').get();
//   for (var chatDoc in chatsSnapshot.docs) {
//     final participantData = chatDoc.data() as Map<String, dynamic>;
//     final participants = participantData['participants'] as List<dynamic>;
//     final updatedParticipants = participants.map((p) {
//       return nameToUidMap[p] ?? p; // Replace name with UID if found, else keep as is
//     }).toList();

//     // Ensure updatedParticipants has exactly 2 participants
//     if (updatedParticipants.length != 2) {
//       print('Skipping chat ${chatDoc.id} due to invalid participant count: $updatedParticipants');
//       continue;
//     }

//     final chatId = updatedParticipants[0].compareTo(updatedParticipants[1]) < 0
//         ? '${updatedParticipants[0]}-${updatedParticipants[1]}'
//         : '${updatedParticipants[1]}-${updatedParticipants[0]}';

//     // Update chat document
//     await db.collection('chats').doc(chatId).set({
//       'participants': updatedParticipants,
//       'lastMessage': participantData['lastMessage'],
//       'timestamp': participantData['timestamp'],
//       'unreadCount': participantData['unreadCount'] ?? 0,
//     }, SetOptions(merge: true));

//     // Update messages subcollection
//     final messagesSnapshot = await db
//         .collection('chats')
//         .doc(chatDoc.id)
//         .collection('messages')
//         .get();
//     for (var messageDoc in messagesSnapshot.docs) {
//       final messageData = messageDoc.data() as Map<String, dynamic>;
//       final senderId = messageData['senderId'] as String;
//       final receiverId = messageData['receiverId'] as String;
//       await db
//           .collection('chats')
//           .doc(chatId)
//           .collection('messages')
//           .doc(messageDoc.id)
//           .set({
//         'senderId': nameToUidMap[senderId] ?? senderId,
//         'receiverId': nameToUidMap[receiverId] ?? receiverId,
//         'message': messageData['message'],
//         'timestamp': messageData['timestamp'],
//         'isRead': messageData['isRead'],
//       });
//     }

//     // Delete old chat document if chatId changed
//     if (chatDoc.id != chatId) {
//       await db.collection('chats').doc(chatDoc.id).delete();
//       print('Deleted old chat document: ${chatDoc.id}');
//     }
//   }
//   print('Migration completed at ${DateTime.now()}');
// }
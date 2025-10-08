import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/messages/messages_event.dart';
import 'package:vistacall/bloc/messages/messages_state.dart';
import 'package:vistacall/data/models/conversation.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  StreamSubscription? _chatsSubscription;
  final List<Conversation> _allConversations =
      []; // Global list to hold conversations

  MessagesBloc() : super(MessagesLoadingState()) {
    on<LoadMessagesEvent>((event, emit) async {
      emit(MessagesLoadingState());
      try {
        final user = _auth.currentUser;
        if (user == null) {
          emit(MessagesErrorState('User not authenticated'));
          print('MessagesBloc: User not authenticated');
          return;
        }

        final patientId = user.uid;
        final patientName = await _getPatientNameFromUid(patientId);

        print('MessagesBloc: PatientID: $patientId, PatientName: $patientName');

        await _chatsSubscription?.cancel();
        _allConversations.clear(); // Clear previous conversations
        _chatsSubscription = _db
            .collection('chats')
            .where('participants', arrayContains: patientId)
            .snapshots()
            .listen((chatsSnapshot) {
          print(
              'PatientID: $patientId, Chats found: ${chatsSnapshot.docs.map((d) => d.data()).toList()}');

          // Collect all promises for conversation updates
          final updatePromises = <Future<void>>[];
          for (var chatDoc in chatsSnapshot.docs) {
            final chatId = chatDoc.id;
            final participantData = chatDoc.data() as Map<String, dynamic>;
            final participants =
                participantData['participants'] as List<dynamic>;
            final doctorId = participants.firstWhere((id) => id != patientId,
                orElse: () => null);
            if (doctorId == null) continue;

            updatePromises
                .add(_updateConversation(chatId, doctorId, participantData));
          }

          // Wait for all updates to complete
          Future.wait(updatePromises).then((_) {
            _emitSortedConversations();
          }).catchError((e) {
            print('Error processing conversations: $e');
            emit(MessagesErrorState('Failed to load messages: $e'));
          });
        }, onError: (e) {
          print('Stream error: $e');
          emit(MessagesErrorState('Failed to load messages: $e'));
        });

        emit(MessagesLoadedState([])); // Initial state while data loads
      } catch (e) {
        print('MessagesBloc: Error - $e');
        emit(MessagesErrorState('Failed to load messages: $e'));
      }
    });
  }

  Future<void> _updateConversation(String chatId, String doctorId,
      Map<String, dynamic> participantData) async {
    String doctorName = 'Unknown Doctor';
    try {
      final doc = await _db.collection('doctors').doc(doctorId).get();
      if (doc.exists) {
        doctorName = doc.data()?['personal']?['fullName'] ?? 'Unknown Doctor';
      }
    } catch (e) {
      print('Error fetching doctor name: $e');
    }

    try {
      final lastMessageDoc = await _db
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();
      Conversation conversation;
      if (lastMessageDoc.docs.isNotEmpty) {
        final data = lastMessageDoc.docs.first.data() as Map<String, dynamic>;
        final timestamp = (data['timestamp'] as Timestamp).toDate();
        final isUnread = data['isRead'] == false &&
            data['receiverId'] == _auth.currentUser?.uid;

        conversation = Conversation(
          doctorName: doctorName,
          lastMessage: data['message'] ?? 'No message',
          timestamp: timestamp,
          isUnread: isUnread,
          doctorId: doctorId,
          chatId: chatId,
        );
      } else {
        conversation = Conversation(
          doctorName: doctorName,
          lastMessage: 'No messages yet',
          timestamp: DateTime.now(),
          isUnread: false,
          doctorId: doctorId,
          chatId: chatId,
        );
      }

      // Update or add conversation, deduplicating by chatId
      final existingIndex =
          _allConversations.indexWhere((conv) => conv.chatId == chatId);
      if (existingIndex >= 0) {
        _allConversations[existingIndex] = conversation; // Update existing
      } else {
        _allConversations.add(conversation); // Add new
      }
    } catch (e) {
      print('Error fetching last message: $e');
    }
  }

  void _emitSortedConversations() {
    _allConversations.sort((a, b) {
      return b.timestamp.compareTo(a.timestamp); // Sort by timestamp descending
    });
    emit(MessagesLoadedState(List.from(_allConversations)));
  }

  Future<String> _getPatientNameFromUid(String uid) async {
    try {
      final userDoc =
          await _db.collection('users').doc(uid).collection('patients').get();
      if (userDoc.docs.isNotEmpty) {
        final patientData = userDoc.docs.first.data() as Map<String, dynamic>;
        final firstName = patientData['firstName'] ?? '';
        final lastName = patientData['lastName'] ?? '';
        final name = '$firstName $lastName'.trim();
        print(
            'MessagesBloc: User document data for UID $uid: $patientData, Extracted Name: $name');
        return name.isEmpty ? 'Unknown User' : name;
      }
      print('MessagesBloc: No patients subcollection found for UID $uid');
      return 'Unknown User';
    } catch (e) {
      print('MessagesBloc: Error fetching patient name for UID $uid: $e');
      return 'Unknown User';
    }
  }

  String _formatTimestamp(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return '${date.hour}:${date.minute}'.padLeft(5, '0');
    } else if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day - 1) {
      return 'Yesterday';
    } else {
      return '${date.day}/${date.month}';
    }
  }

  @override
  Future<void> close() {
    _chatsSubscription?.cancel();
    return super.close();
  }
}

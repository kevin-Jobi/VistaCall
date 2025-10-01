// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ChatBloc extends Bloc<ChatEvent, ChatState> {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   ChatBloc() : super(ChatInitial()) {
//     on<LoadChatMessages>(_onLoadChatMessages);
//     on<SendMessage>(_onSendMessage);
//   }

//   Future<void> _onLoadChatMessages(
//       LoadChatMessages event, Emitter<ChatState> emit) async {
//     emit(ChatLoading());
//     try {
//       final patientId = _auth.currentUser?.uid ?? 'unknown';
//       // final patientName = await _getPatientNameFromUid(patientId);
//       // final chatId = _getChatId(patientName, event.doctorId);
//       print('Loading messages for ChatID: ${event.chatId}');
//       emit(ChatLoaded(chatId: event.chatId));
//     } catch (e) {
//       print('LoadChatMessages error: $e');
//       emit(ChatError('Failed to load chat: $e'));
//     }
//   }

//   Future<void> _onSendMessage(
//       SendMessage event, Emitter<ChatState> emit) async {
//     final user = _auth.currentUser;
//     if (user == null) return;

//     final patientId = user.uid;
//     // final patientName = await _getPatientNameFromUid(patientId);
//     // final chatId = _getChatId(patientName, event.doctorId);
//     final chatId = event.chatId;
//     final timestamp = FieldValue.serverTimestamp();

//     print(
//         'Sending message: $chatId, message: ${event.message}, to DoctorID: ${event.doctorId}');
//     try {
//       await _db.collection('chats').doc(chatId).set({
//         'participants': [patientId, event.doctorId],
//         'lastMessage': event.message,
//         'timestamp': timestamp,
//         'unreadCount': FieldValue.increment(1),
//       }, SetOptions(merge: true));

//       await _db.collection('chats').doc(chatId).collection('messages').add({
//         'senderId': patientId,
//         'receiverId': event.doctorId,
//         'message': event.message,
//         'timestamp': timestamp,
//         'isRead': false,
//       });

//       emit(ChatMessageSent(chatId));
//     } catch (e) {
//       print('SendMessage error: $e');
//       emit(ChatError('Failed to send message: $e'));
//     }
//   }

//   // Future<String> _getPatientNameFromUid(String uid) async {
//   //   final doc = await _db.collection('users').doc(uid).get();
//   //   return doc.data()?['name'] ??
//   //       'Unknown User'; // Default to "Jeswin" if missing
//   // }

//   // String _getChatId(String patientName, String doctorId) {
//   //   return patientName.compareTo(doctorId) < 0
//   //       ? '$patientName-$doctorId'
//   //       : '$doctorId-$patientName';
//   // }
// }

// // Define events if not already present
// abstract class ChatEvent {}

// class LoadChatMessages extends ChatEvent {
//   final String doctorId;
//   final String chatId;
//   LoadChatMessages(this.doctorId, this.chatId);
// }

// class SendMessage extends ChatEvent {
//   final String doctorId;
//   final String message;
//   final String chatId;
//   SendMessage(this.doctorId, this.message, this.chatId);
// }

// // Define states if not already present
// abstract class ChatState {}

// class ChatInitial extends ChatState {}

// class ChatLoading extends ChatState {}

// class ChatLoaded extends ChatState {
//   final String chatId;
//   ChatLoaded({required this.chatId});
// }

// class ChatMessageSent extends ChatState {
//   final String chatId;
//   ChatMessageSent(this.chatId);
// }

// class ChatError extends ChatState {
//   final String message;
//   ChatError(this.message);
// }



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/messages/messages_bloc.dart';
import 'package:vistacall/bloc/messages/messages_event.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ChatBloc() : super(ChatInitial()) {
    on<LoadChatMessages>(_onLoadChatMessages);
    on<SendMessage>(_onSendMessage);
  }

  Future<void> _onLoadChatMessages(
      LoadChatMessages event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    try {
      final patientId = _auth.currentUser?.uid ?? 'unknown';
      print('Loading messages for ChatID: ${event.chatId}');
      emit(ChatLoaded(chatId: event.chatId));
    } catch (e) {
      print('LoadChatMessages error: $e');
      emit(ChatError('Failed to load chat: $e'));
    }
  }

  Future<void> _onSendMessage(
      SendMessage event, Emitter<ChatState> emit) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final patientId = user.uid;
    final chatId = event.chatId;
    final timestamp = FieldValue.serverTimestamp();

    print(
        'Sending message: $chatId, message: ${event.message}, to DoctorID: ${event.doctorId}');
    try {
      await _db.collection('chats').doc(chatId).set({
        'participants': [patientId, event.doctorId],
        'lastMessage': event.message,
        'timestamp': timestamp,
        'unreadCount': FieldValue.increment(1),
      }, SetOptions(merge: true));

      await _db.collection('chats').doc(chatId).collection('messages').add({
        'senderId': patientId,
        'receiverId': event.doctorId,
        'message': event.message,
        'timestamp': timestamp,
        'isRead': false,
      });

      emit(ChatMessageSent(chatId));
    } catch (e) {
      print('SendMessage error: $e');
      emit(ChatError('Failed to send message: $e'));
    }
  }
}

// Define events
abstract class ChatEvent {}

class LoadChatMessages extends ChatEvent {
  final String doctorId;
  final String chatId;
  LoadChatMessages(this.doctorId, this.chatId);
}

class SendMessage extends ChatEvent {
  final String doctorId;
  final String message;
  final String chatId;
  SendMessage(this.doctorId, this.message, this.chatId);
}

// Define states
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final String chatId;
  ChatLoaded({required this.chatId});
}

class ChatMessageSent extends ChatState {
  final String chatId;
  ChatMessageSent(this.chatId);
}

class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}
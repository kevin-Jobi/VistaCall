import 'package:bloc/bloc.dart';
import 'package:vistacall/bloc/messages/messages_event.dart';

// Dummy Conversation Model
class Conversation {
  final String doctorName;
  final String lastMessage;
  final String timestamp;
  final bool isUnread;

  Conversation({
    required this.doctorName,
    required this.lastMessage,
    required this.timestamp,
    required this.isUnread,
  });
}

// Events


// States
abstract class MessagesState {}

class MessagesLoadingState extends MessagesState {}

class MessagesLoadedState extends MessagesState {
  final List<Conversation> conversations;

  MessagesLoadedState(this.conversations);
}

class MessagesErrorState extends MessagesState {
  final String error;

  MessagesErrorState(this.error);
}
import 'package:vistacall/data/models/message.dart';

class Message {
  final String text;
  final bool isUser;
  final String timestamp;

  Message({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

abstract class ChatState {}

class ChatLoadingState extends ChatState {}

class ChatLoadedState extends ChatState {
  final List<Message> messages;

  ChatLoadedState(this.messages);
}

class ChatErrorState extends ChatState {
  final String error;

  ChatErrorState(this.error);
}
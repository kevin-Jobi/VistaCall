import 'package:vistacall/data/models/message.dart';


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
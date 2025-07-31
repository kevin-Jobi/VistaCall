import 'package:bloc/bloc.dart';
import 'package:vistacall/bloc/messages/messages_event.dart';
import 'package:vistacall/data/models/conversation.dart';

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

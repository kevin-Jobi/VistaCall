

import 'package:vistacall/bloc/chat/chat_bloc.dart';
import 'package:vistacall/bloc/chat/chat_event.dart';
import 'package:vistacall/bloc/chat/chat_state.dart';
import 'package:vistacall/data/models/message.dart';

class ChatViewModel {
  final ChatBloc _chatBloc;

  ChatViewModel(this._chatBloc);

  // State management methods
  bool isLoading(ChatState state) => state is ChatLoadingState;
  String? getError(ChatState state) => state is ChatErrorState ? state.error : null;
  List<Message> getMessages(ChatState state) => state is ChatLoadedState ? state.messages : [];

  // Action methods
  void loadMessages() => _chatBloc.add(LoadChatEvent());
  void sendMessage(String text) {
    if (text.trim().isNotEmpty) {
      _chatBloc.add(SendMessageEvent(text.trim()));
    }
  }
}
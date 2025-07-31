

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/messages/messages_event.dart';
import 'package:vistacall/bloc/messages/messages_state.dart';
import 'package:vistacall/data/models/conversation.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  MessagesBloc() : super(MessagesLoadingState()) {
    on<LoadMessagesEvent>((event, emit) async {
      emit(MessagesLoadingState());
      try {
        // Dummy data (replace with API call in the future)
        final conversations = [
          Conversation(
            doctorName: 'Dr. John Smith',
            lastMessage: 'How are you feeling?',
            timestamp: '10:30 AM',
            isUnread: true,
          ),
          Conversation(
            doctorName: 'Dr. Emily Johnson',
            lastMessage: 'Your test results are ready.',
            timestamp: 'Yesterday',
            isUnread: false,
          ),
          Conversation(
            doctorName: 'Dr. Sarah Davis',
            lastMessage: 'Please schedule a follow-up.',
            timestamp: 'May 15',
            isUnread: true,
          ),
        ];
        emit(MessagesLoadedState(conversations));
      } catch (e) {
        emit(MessagesErrorState('Failed to load messages: $e'));
      }
    });
  }
}

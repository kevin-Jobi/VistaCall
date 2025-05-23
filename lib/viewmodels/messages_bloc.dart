import 'package:bloc/bloc.dart';

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
abstract class MessagesEvent {}

class LoadMessagesEvent extends MessagesEvent {}

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

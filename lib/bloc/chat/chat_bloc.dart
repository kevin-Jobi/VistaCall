import 'package:bloc/bloc.dart';
import 'package:vistacall/bloc/chat/chat_event.dart';
import 'package:vistacall/bloc/chat/chat_state.dart';
import 'package:vistacall/data/models/message.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatLoadingState()) {
    on<LoadChatEvent>((event, emit) async {
      emit(ChatLoadingState());
      try {
        // Initial AI message
        final messages = [
          Message(
            text: "Hello! How can I assist you today?",
            isUser: false,
            timestamp: "09:21 AM",
          ),
        ];
        emit(ChatLoadedState(messages));
      } catch (e) {
        emit(ChatErrorState('Failed to load chat: $e'));
      }
    });

    on<SendMessageEvent>((event, emit) async {
      if (state is ChatLoadedState) {
        final currentState = state as ChatLoadedState;
        final updatedMessages = List<Message>.from(currentState.messages);

        // Add user message
        updatedMessages.add(Message(
          text: event.message,
          isUser: true,
          timestamp: "09:22 AM", // Simulated timestamp
        ));

        // Simulate AI response
        final aiResponse = _getDummyAIResponse(event.message);
        updatedMessages.add(Message(
          text: aiResponse,
          isUser: false,
          timestamp: "09:23 AM", // Simulated timestamp
        ));

        emit(ChatLoadedState(updatedMessages));
      }
    });
  }

  String _getDummyAIResponse(String userMessage) {
    if (userMessage.toLowerCase().contains("headache")) {
      return "I'm sorry to hear about your headache. Have you tried drinking water or taking a rest? If it persists, you might want to consult a doctor.";
    } else if (userMessage.toLowerCase().contains("appointment")) {
      return "You can book an appointment through the Appointments tab. Would you like to know more about a specific doctor?";
    } else {
      return "I'm here to help! Can you tell me more about your concern?";
    }
  }
}



































// import 'package:bloc/bloc.dart';

// // Dummy Message Model
// class Message {
//   final String text;
//   final bool isUser;
//   final String timestamp;

//   Message({
//     required this.text,
//     required this.isUser,
//     required this.timestamp,
//   });
// }

// // Events
// abstract class ChatEvent {}

// class LoadChatEvent extends ChatEvent {}

// class SendMessageEvent extends ChatEvent {
//   final String message;

//   SendMessageEvent(this.message);
// }

// // States
// abstract class ChatState {}

// class ChatLoadingState extends ChatState {}

// class ChatLoadedState extends ChatState {
//   final List<Message> messages;

//   ChatLoadedState(this.messages);
// }

// class ChatErrorState extends ChatState {
//   final String error;

//   ChatErrorState(this.error);
// }

// class ChatBloc extends Bloc<ChatEvent, ChatState> {
//   ChatBloc() : super(ChatLoadingState()) {
//     on<LoadChatEvent>((event, emit) async {
//       emit(ChatLoadingState());
//       try {
//         // Initial AI message
//         final messages = [
//           Message(
//             text: "Hello! How can I assist you today?",
//             isUser: false,
//             timestamp: "09:21 AM",
//           ),
//         ];
//         emit(ChatLoadedState(messages));
//       } catch (e) {
//         emit(ChatErrorState('Failed to load chat: $e'));
//       }
//     });

//     on<SendMessageEvent>((event, emit) async {
//       if (state is ChatLoadedState) {
//         final currentState = state as ChatLoadedState;
//         final updatedMessages = List<Message>.from(currentState.messages);

//         // Add user message
//         updatedMessages.add(Message(
//           text: event.message,
//           isUser: true,
//           timestamp: "09:22 AM", // Simulated timestamp
//         ));

//         // Simulate AI response
//         final aiResponse = _getDummyAIResponse(event.message);
//         updatedMessages.add(Message(
//           text: aiResponse,
//           isUser: false,
//           timestamp: "09:23 AM", // Simulated timestamp
//         ));

//         emit(ChatLoadedState(updatedMessages));
//       }
//     });
//   }

//   String _getDummyAIResponse(String userMessage) {
//     if (userMessage.toLowerCase().contains("headache")) {
//       return "I'm sorry to hear about your headache. Have you tried drinking water or taking a rest? If it persists, you might want to consult a doctor.";
//     } else if (userMessage.toLowerCase().contains("appointment")) {
//       return "You can book an appointment through the Appointments tab. Would you like to know more about a specific doctor?";
//     } else {
//       return "I'm here to help! Can you tell me more about your concern?";
//     }
//   }
// }